using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using RandomWikiNS.Models;
using System.Configuration;
using LinqToWiki.Generated;
using System.Data.SqlClient;

namespace RandomWikiNS.Controllers
{
    public class WikiPagesController : Controller
    {
        private RandomWikiNSContext db = new RandomWikiNSContext();

        // Fyller viewmodel och returnerar view
        public ActionResult Index()
        {
            var v = FullListFromDB(Get10RandomFromAPI());
            var l = ConvertListAsync(v);
            return View(l);
        }

        // Ändrar modellen från model till viewmodel
        private List<WikiPageVM> ConvertListAsync(List<WikiPage> list)
        {
            List<WikiPageVM> newlist = new List<WikiPageVM>();
            foreach (var p in list)
            {
                WikiPageVM obj = new WikiPageVM();
                obj.url = GetUrl(p.PageId);
                obj.title = "";
                obj.PageId = p.PageId;
                obj.Category = p.Category;
                obj.Rating = p.Rating;
                newlist.Add(obj);
            }
            return newlist;
        }

        // Hämtar objekten från databasen, baserat på id-referensen från "Get10RandomFromAPI()"
        private List<WikiPage> FullListFromDB(List<WikiPage> list)
        {
            List<WikiPage> returnList = list;
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
            foreach (WikiPage page in returnList)
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("GetWikiPage", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(page.PageId));
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();

                        int? cat = null;
                        int? rat = null;
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                if (!reader.IsDBNull(1))
                                    cat = (int?)reader.GetInt32(1);
                                if (!reader.IsDBNull(2))
                                    rat = (int?)reader.GetInt32(2);
                            }
                        }
                        if (cat.HasValue)
                        {
                            Category c = GetCategoryFromDB(cat);
                            page.Category = c;
                        }

                        if (rat.HasValue)
                        {
                            Rating r = GetRatingFromDB(rat);
                            page.Rating = r;
                        }
                    }
                }
            }
            return returnList;
        }

        // Hämtar 10 random wikis via API och sparar till databasen. Returnerar referens till IDn
        private List<WikiPage> Get10RandomFromAPI()
        {
            List<WikiPage> listOf10Pages = new List<WikiPage>();
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;

            // Grunden för anropet till wikipedias API, begränsat till svenska sidor
            Wiki wiki = new Wiki("PhoneraASPNS", "sv.wikipedia.org", "/w/api.php");
            try
            {
                // Anrop till API, medelst LinqToWiki
                var query = (from wp in wiki.Query.random()
                             select new { wp.id }).ToEnumerable().Take(10);

                // Loop genom 10 pageIDs, sparas individuellt i databasen med stored procedure "SaveWikiPage"
                foreach (var p in query)
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        using (SqlCommand cmd = new SqlCommand("SaveWikiPage", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(p.id));
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    // De 10 random sidor som hämtats sparas i en lista, för referens
                    WikiPage page = new WikiPage { PageId = p.id };
                    listOf10Pages.Add(page);
                }

                return listOf10Pages;
            }
            catch (Exception e)
            {
                string error = e.Message;
                // errorlog
                return null;
            }
        }

        // hämtar category för vald pageid från db
        public Category GetCategoryFromDB(int? id)
        {
            if (id != null)
            {
                string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
                Category result = new Category();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("GetCategory", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@catid", id);
                        con.Open();

                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            result.Id = reader.GetFieldValue<int>(0);
                            result.CategoryName = reader.GetFieldValue<string>(1);
                        }
                    }
                }
                return result;
            }
            else return null;
        }

        // hämtar rating för vald pageid från db
        public Rating GetRatingFromDB(int? id)
        {
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
            Rating result = new Rating();

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("GetRating", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ratid", id);
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        result.Id = reader.GetFieldValue<int>(0);
                        result.RatingValue = reader.GetFieldValue<short>(1);
                    }
                }
            }
            return result;
        }

        // Konstruerar och returnerar url baserad på pageid
        public string GetUrl(long id)
        {
            string url = "http://sv.wikipedia.org/?curid=" + id;
            return url;
        }

        // Fyller viewmodel och dirigerar till Details-vyn
        public ActionResult Details(long id)
        {
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
            WikiPageEditVM page = new WikiPageEditVM();
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("GetWikiPage", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(id));
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    int? cat = null;
                    int? rat = null;
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            page.PageId = reader.GetInt64(0);
                            if (!reader.IsDBNull(1))
                                cat = (int?)reader.GetInt32(1);
                            if (!reader.IsDBNull(2))
                                rat = (int?)reader.GetInt32(2);
                        }
                    }
                    if (cat.HasValue)
                    {
                        Category c = GetCategoryFromDB(cat);
                        page.Category = c;
                    }

                    if (rat.HasValue)
                    {
                        Rating r = GetRatingFromDB(rat);
                        page.Rating = r;
                    }
                    CategoriesController cc = new CategoriesController();
                    page.categorylist = cc.GetCategoriesFromDB();
                    RatingsController rc = new RatingsController();
                    page.ratinglist = rc.GetRatingsFromDB();
                }
            }
            return View(page);
        }

        // Anropas av knapp i details-vyn. Sparar vald category till DB för vald pageid
        public ActionResult AddCategory([Bind(Include = "PageId, Id")] long id, int cat)
        {
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("SetWikiCategory", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(id));
                    cmd.Parameters.AddWithValue("@categoryid", cat);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            return RedirectToAction("Details", "WikiPages", new { id = id });
        }

        // Anropas av knapp i details-vyn. Sparar vald rating till DB för vald pageid
        public ActionResult AddRating([Bind(Include = "PageId, Id")] long id, int rat)
        {
            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("CreateRatingOnWiki", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(id));
                    cmd.Parameters.AddWithValue("@ratingid", rat);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            return RedirectToAction("Details", "WikiPages", new { id = id });
        }

        // Fyller viewmodel från db och returnerar view
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            string cs = ConfigurationManager.ConnectionStrings["RandomWikiNSContext"].ConnectionString;
            WikiPageEditVM page = new WikiPageEditVM();
            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("GetWikiPage", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@pageid", Convert.ToInt64(id));
                    con.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    int? cat = null;
                    int? rat = null;
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            page.PageId = reader.GetInt64(0);
                            if (!reader.IsDBNull(1))
                                cat = (int?)reader.GetInt32(1);
                            if (!reader.IsDBNull(2))
                                rat = (int?)reader.GetInt32(2);
                        }
                    }
                    if (cat.HasValue)
                    {
                        Category c = GetCategoryFromDB(cat);
                        page.Category = c;
                    }

                    if (rat.HasValue)
                    {
                        Rating r = GetRatingFromDB(rat);
                        page.Rating = r;
                    }
                    CategoriesController cc = new CategoriesController();
                    page.categorylist = cc.GetCategoriesFromDB();
                    RatingsController rc = new RatingsController();
                    page.ratinglist = rc.GetRatingsFromDB();
                }
            }

            if (page == null)
            {
                return HttpNotFound();
            }
            return View(page);
        }
    }
}
