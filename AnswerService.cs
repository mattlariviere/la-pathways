using Newtonsoft.Json;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.Surveys;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Surveys;

using Sabio.Services.Interfaces.Surveys;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Sabio.Services.Surveys
{
    public class AnswerService : IAnswerService
    {
        IDataProvider _data = null;

        public AnswerService(IDataProvider data)
        {
            _data = data;
        }
        public bool Add(AnswerAddRequest model)
        {
            bool isSuccessful = false;
            DataTable dt = null;
            if (model.AnswerOptionIds.Count > 0)
            {
                dt = new DataTable();

                dt.Columns.Add("AnswerOptionId", typeof(int));

                foreach (int item in model.AnswerOptionIds)
                {
                    dt.Rows.Add(item);
                }
            }
            string procName = "[dbo].[SurveyAnswers_Insert_Multiple]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    AddCommonParams(model, col);
                    col.AddWithValue("@AnswersList", dt);


                }, returnParameters: null);
            isSuccessful = true;
            return isSuccessful;
        }
        public bool AddMultiple(AnswerAddRequestMultiple model, int instanceId)
        {
            string procName = "[dbo].[SurveyAnswers_Insert_Multiple_V2]";

            DataTable dt = null;
            bool isSuccessful = false;

            if(model.InstanceAnswersRequests.Count > 0)
            {
                dt = new DataTable();

                dt.Columns.Add("QuestionId", typeof(int));
                dt.Columns.Add("AnswerOptionId", typeof(int));
                foreach(InstanceAnswersRequest item in model.InstanceAnswersRequests)
                {
                    if(item.AnswerId.Count > 0)
                    {
                        foreach (int answer in item.AnswerId)
                        {
                            dt.Rows.Add(item.QuestionId, answer);
                        }
                    }

                }
            }

            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@InstanceId", instanceId);
                col.AddWithValue("@AnswersList", dt);
            }, returnParameters: null);

            isSuccessful = true;
            return isSuccessful;
        }
        public SurveyAnswer GetById(int Id)
        {
            string procName = "[dbo].[SurveyAnswers_SelectById]";

            SurveyAnswer surveyAnswers = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", Id);
            }, delegate (IDataReader reader, short set)
           {
               surveyAnswers = MapSurveyAnswers(reader);
           });
            return surveyAnswers;
        }
        public void Update(AnswerUpdateRequest model)
        {
            string procName = "[dbo].[SurveyAnswers_Update]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {
                    col.AddWithValue("@Id", model.Id);
                    AddCommonParams(model, col);
                }, returnParameters: null);
        }
        public QuestionAnswer GetByQAId(int id)
        {
            string procName = "dbo.QuestionAnswers_GetById";

            QuestionAnswer questionAnswer = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }, delegate (IDataReader reader, short set)
            {
                questionAnswer = MapQuestionAnswers(reader);
            }
            );
            return questionAnswer;
        }
        public Paged<SurveyAnswer> SelectAll(int pageIndex, int pageSize)
        {
            Paged<SurveyAnswer> pagedResult = null;
            List<SurveyAnswer> result = null;
            SurveyAnswer surveyAnswers = null;
            int totalCount = 0;
            _data.ExecuteCmd(
                "dbo.SurveyAnswers_SelectAll",
                inputParamMapper: delegate (SqlParameterCollection parameterCollection)
                {
                    parameterCollection.AddWithValue("@pageIndex", pageIndex);
                    parameterCollection.AddWithValue("@pageSize", pageSize);
                },
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    surveyAnswers = MapSurveyAnswers(reader);

                    if (totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(6);
                    }
                    if (result == null)
                    {
                        result = new List<SurveyAnswer>();
                    }
                    result.Add(surveyAnswers);
                }
            );
            if (result != null)
            {
                pagedResult = new Paged<SurveyAnswer>(result, pageIndex, pageSize, totalCount);
            }
            return pagedResult;
        }
        private static SurveyAnswer MapSurveyAnswers(IDataReader reader)
        {
            SurveyAnswer aSurveyAnswer = new SurveyAnswer();

            int startingIndex = 0;

            aSurveyAnswer.Id = reader.GetSafeInt32(startingIndex++);
            aSurveyAnswer.InstanceId = reader.GetSafeInt32(startingIndex++);
            aSurveyAnswer.QuestionId = reader.GetSafeInt32(startingIndex++);
            aSurveyAnswer.AnswerOptionId = reader.GetSafeInt32(startingIndex++);
            aSurveyAnswer.DateCreated = reader.GetSafeDateTime(startingIndex++);
            aSurveyAnswer.DateModified = reader.GetSafeDateTime(startingIndex++);

            return aSurveyAnswer;
        }
        private static void AddCommonParams(AnswerAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@InstanceId", model.InstanceId);
            col.AddWithValue("@QuestionId", model.QuestionId);
            //col.AddWithValue("@AnswerOptionId", model.AnswerOptionId);

        }
        private static QuestionAnswer MapQuestionAnswers(IDataReader reader)
        {
            QuestionAnswer aQuestionAnswer = new QuestionAnswer();

            int startingIndex = 0;

            aQuestionAnswer.Id = reader.GetSafeInt32(startingIndex++);
            aQuestionAnswer.QuestionTypeId = reader.GetSafeInt32(startingIndex++);
            aQuestionAnswer.Question = reader.GetSafeString(startingIndex++);
            string Answers = reader.GetSafeString(startingIndex++);
            if (aQuestionAnswer.Answers == null)
            {
                aQuestionAnswer.Answers = new List<QAnswers>();
            }
            if (Answers != null)
            {
                aQuestionAnswer.Answers = JsonConvert.DeserializeObject<List<QAnswers>>(Answers);
            }
            return aQuestionAnswer;
        }
    }
}
