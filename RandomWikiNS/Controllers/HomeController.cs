using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Mvc;

namespace RandomWikiNS.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        // tömmer databasen på allt utom rating-definitionerna
        public ActionResult EmptyDatabase()
        {
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("ClearDatabase", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            return View();
        }
    }
}