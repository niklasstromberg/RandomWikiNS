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
    public class CategoriesController : Controller
    {
        private RandomWikiNSContext db = new RandomWikiNSContext();

        // indexvyn. Fyller viewmodel
        public ActionResult Index()
        {
            return View(GetCategoriesFromDB());
        }

        // Hämtar data till viewmodel från db
        public List<Category> GetCategoriesFromDB()
        {
            List<Category> CList = new List<Category>();
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("GetCategories", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Category c = new Category();
                            if (!reader.IsDBNull(0))
                                c.Id = (int)reader.GetInt32(0);
                            if (!reader.IsDBNull(1))
                                c.CategoryName = (string)reader.GetString(1);
                            CList.Add(c);
                        }
                    }
                }
            }
            return CList;
        }

        // genererar vyn för att skapa category
        public ActionResult Create()
        {
            return View();
        }

        // Kör stored procedure med inparameter för att skapa ny category
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,CategoryName")] Category category)
        {
            if (ModelState.IsValid)
            {
                string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("CreateCategory", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@name", category.CategoryName);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                return RedirectToAction("Index");
            }

            return View(category);
        }
    }
}
