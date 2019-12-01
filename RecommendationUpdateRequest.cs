using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sabio.Models.Requests.Recommendations
{
    public class RecommendationUpdateRequest

    {
        [Required]
        public int ResourceId { get; set; }
        [StringLength(10000, MinimumLength = 3, ErrorMessage = "You must fill this field (3000 characters max).")]
        public string Condition { get; set; }
        [StringLength(10000, MinimumLength = 3, ErrorMessage = "You must fill this field (3000 characters max).")]
        public string Query { get; set; }
    }
}
