using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RandomWikiNS.Models
{
    public class WikiPageEditVM : WikiPage
    {
        public List<Category> categorylist { get; set; }
        public List<Rating> ratinglist { get; set; }
    }
}
