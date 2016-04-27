using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using RandomWikiNS.Models;
using System.Configuration;
using System.Data.SqlClient;

namespace RandomWikiNS.Controllers
{
    public class RatingsController : Controller
    {
        private RandomWikiNSContext db = new RandomWikiNSContext();

        // Fyller view med data från db
        public ActionResult Index()
        {
            return View(GetRatingsFromDB());
        }

        // hämtar listan av ratings från databasen
        public List<Rating> GetRatingsFromDB()
        {
            List<Rating> rList = new List<Rating>();
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("GetRatings", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Rating r = new Rating();
                            if (!reader.IsDBNull(0))
                                r.Id = (int)reader.GetInt32(0);
                            if (!reader.IsDBNull(1))
                                r.RatingValue = (short)reader.GetInt16(1);
                            rList.Add(r);
                        }
                    }
                }
            }
            return rList;
        }
    }
}
