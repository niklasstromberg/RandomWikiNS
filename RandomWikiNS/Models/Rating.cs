using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RandomWikiNS.Models
{
    public class Rating
    {
        [Key]
        public int Id { get; set; }
        public short RatingValue { get; set; }

        public virtual List<WikiPage> Pages { get; set; }
    }
}
