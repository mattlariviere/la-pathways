using Sabio.Models.Domain.Surveys;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Sabio.Models.Requests.Surveys
{
    public class SurveyAddRequest
    {
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Please enter Name under 100 characters.")]
        public string Name { get; set; }
        [Required]
        [StringLength(2000, MinimumLength = 2, ErrorMessage = "Please enter Text under 2000 characters.")]
        public string Description { get; set; }
        [Required]
        public int StatusId { get; set; }
        [Required]
        public int SurveyTypeId { get; set; }
        public int CreatedBy { get; set; }
        [Required]
        public List<SurveySectionType> SurveySections { get; set; }
        [Required]
        public List<SurveyQuestionType> SurveyQuestions { get; set; }
        [Required]
        public List<SurveyQuestionAnswerOptionType> AnswerOptions { get; set; }
    }
}
