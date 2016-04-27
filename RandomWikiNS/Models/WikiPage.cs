using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RandomWikiNS.Models
{
    public class WikiPage
    {
        [Key]
        public long PageId { get; set; }

        public virtual Category Category { get; set; }
        public virtual Rating Rating { get; set; }
    }
}
