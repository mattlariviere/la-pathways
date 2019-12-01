using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sabio.Models.Requests
{
    public class ResourceAddRequest
    {
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid name")]
        public string Name { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid headline")]
        public string Headline { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid description")]
        public string Description { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid logo")]
        public string Logo { get; set; }
        [Required]
        [Range(1,100, ErrorMessage = "Please enter a valid Location Id")]
        public int LocationId { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid contact name")]
        public string ContactName { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid contact name")]
        public string ContactEmail { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid phone number")]
        public string Phone { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter a valid site url")]
        public string SiteUrl { get; set; }
        [Required(ErrorMessage = "Date created is a mandatory field")]
        public DateTime DateCreated { get; set; }
        [Required(ErrorMessage = "Date modified is a mandatory field")]
        public DateTime DateModified { get; set; }
    }
}
