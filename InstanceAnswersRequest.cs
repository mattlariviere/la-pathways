using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sabio.Models.Requests.Surveys
{
   public class InstanceAnswersRequest
    {
        [Required]
        public int QuestionId { get; set; }
        [Required]
        public List<int> AnswerId { get; set; }
    }
}
