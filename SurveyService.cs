using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.Surveys;
using Sabio.Models.Request;
using Sabio.Models.Request.Surveys;
using Sabio.Models.Requests;
using Sabio.Models.Requests.Surveys;
using Sabio.Services.Interfaces;
using Sabio.Services.Interfaces.Surveys;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
namespace Sabio.Services.Surveys
{
    public class SurveyService : ISurveyService
    {
        IDataProvider _data = null;
        public SurveyService(IDataProvider data)
        {
            _data = data;
        }
        public Paged<Survey> GetPaginated(int pageIndex, int pageSize)
        {
            Paged<Survey> pagedResult = null;
            List<Survey> pagedSurveys = null;
            Survey survey = null;
            string procName = "[dbo].[Surveys_SelectAll_Users]";
            int totalCount = 0;
            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@pageIndex", pageIndex);
                paramCollection.AddWithValue("@pageSize", pageSize);
            }
            , singleRecordMapper: delegate (IDataReader reader, short set)
            {
                survey = MapSurvey(reader);
                if (totalCount == 0)
                {
                    totalCount = reader.GetSafeInt32(12);
                }
                if (pagedSurveys == null)
                {
                    pagedSurveys = new List<Survey>();
                }
                pagedSurveys.Add(survey);
            }
            );
            if (pagedSurveys != null)
            {
                pagedResult = new Paged<Survey>(pagedSurveys, pageIndex, pageSize, totalCount);
            }

            return pagedResult;
        }
        public Survey GetById(int id)
        {
            string procName = "dbo.Surveys_SelectById";
            Survey survey = null;
            _data.ExecuteCmd(procName, inputParamMapper: delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            }, singleRecordMapper: delegate (IDataReader reader, short set)
            {
                survey = MapSurvey(reader);
            }
            );
            return survey;
        }

        public Status_Type GetAllTypes_Statuses()
        {
            Status_Type status_type = null;
            List<BaseType> typeList = null;
            List<BaseType> statusList = null;
            BaseType surveyType = null;
            BaseType surveyStatus = null;

            string procName = "[dbo].[SurveyStatus_SurveyTypes_Select]";

            _data.ExecuteCmd(procName, inputParamMapper: null,
                singleRecordMapper: delegate (IDataReader reader, short set)
                {
                    switch (set)
                    {
                        case 0:
                            surveyType = MapBaseTypeMapper(reader);

                            if (typeList == null)
                            {
                                typeList = new List<BaseType>();
                            }
                            typeList.Add(surveyType);
                            break;
                        case 1:

                            surveyStatus = MapBaseTypeMapper(reader);

                            if (statusList == null)
                            {
                                statusList = new List<BaseType>();
                            }
                            statusList.Add(surveyStatus);
                            break;
                    }
                    if (typeList != null || statusList != null)
                    {
                        status_type = new Status_Type { Status = statusList, Types = typeList };
                    }
                });
            return status_type;
        }
        public int Add(AddRequest model, int currentUserId)
        {
            string procName = "[dbo].[Surveys_Insert]";
            int id = 0;
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@CreatedBy", currentUserId);
                AddCommonParams(model, col);
                SqlParameter IdOut = new SqlParameter("@Id", SqlDbType.Int);
                IdOut.Direction = ParameterDirection.Output;
                col.Add(IdOut);
            }, returnParameters: delegate (SqlParameterCollection returnCollection)
            {
                object oId = returnCollection["@Id"].Value;
                int.TryParse(oId.ToString(), out id);
            }
            );
            return id;
        }
        public void Update(UpdateRequest model, int currentUserId)
        {
            string procName = "[dbo].[Surveys_Update]";
            _data.ExecuteNonQuery(procName, inputParamMapper: delegate (SqlParameterCollection col)
            {
                col.AddWithValue("@Id", model.Id);
                col.AddWithValue("@CreatedBy", currentUserId);
                AddCommonParams(model, col);
            }, returnParameters: null
            );
        }

        public void AddSurvey(SurveyAddRequest model, int userId)
        {


            string procName = "[dbo].[SurveyBuilder]";
            DataTable surveySectionTable = new DataTable();
            surveySectionTable.Columns.Add("Title", typeof(string));
            surveySectionTable.Columns.Add("Description", typeof(string));
            surveySectionTable.Columns.Add("SortOrder", typeof(int));
            surveySectionTable.Columns.Add("TempId", typeof(int));
            if (model.SurveySections.Count > 0)
            {
                foreach (var surSec in model.SurveySections)
                {
                    DataRow dr = surveySectionTable.NewRow();
                    dr[0] = surSec.Title;
                    dr[1] = surSec.Description;
                    dr[2] = surSec.SortOrder;
                    dr[3] = surSec.TempId;
                    surveySectionTable.Rows.Add(dr);
                }
                DataTable surveyQuestionTable = new DataTable();
                surveyQuestionTable.Columns.Add("UserId", typeof(int));
                surveyQuestionTable.Columns.Add("Question", typeof(string));
                surveyQuestionTable.Columns.Add("HelpText", typeof(string));
                surveyQuestionTable.Columns.Add("IsRequired", typeof(bool));
                surveyQuestionTable.Columns.Add("IsMultipleAllowed", typeof(bool));
                surveyQuestionTable.Columns.Add("QuestionTypeId", typeof(int));
                surveyQuestionTable.Columns.Add("StatusId", typeof(int));
                surveyQuestionTable.Columns.Add("SortOrder", typeof(int));
                surveyQuestionTable.Columns.Add("TempId", typeof(int));
                if (model.SurveyQuestions.Count > 0)
                {
                    foreach (var surQues in model.SurveyQuestions)
                    {
                        DataRow dr = surveyQuestionTable.NewRow();
                        dr[0] = userId;
                        dr[1] = surQues.Question;
                        dr[2] = surQues.HelpText;
                        dr[3] = surQues.IsRequired;
                        dr[4] = surQues.IsMultipleAllowed;
                        dr[5] = surQues.QuestionTypeId;
                        dr[6] = surQues.StatusId;
                        dr[7] = surQues.SortOrder;
                        dr[8] = surQues.TempId;
                        surveyQuestionTable.Rows.Add(dr);
                    }

                    DataTable surveyQuestionAnswerOptionTable = new DataTable();
                    surveyQuestionAnswerOptionTable.Columns.Add("Text", typeof(string));
                    surveyQuestionAnswerOptionTable.Columns.Add("Value", typeof(string));
                    surveyQuestionAnswerOptionTable.Columns.Add("AdditionalInfo", typeof(string));
                    surveyQuestionAnswerOptionTable.Columns.Add("SortOrder", typeof(int));
                    if (model.AnswerOptions.Count > 0)
                    {
                        foreach (var surOp in model.AnswerOptions)
                        {
                            DataRow dr = surveyQuestionAnswerOptionTable.NewRow();
                            dr[0] = surOp.Text;
                            dr[1] = surOp.Value;
                            dr[2] = surOp.AdditionalInfo;
                            dr[3] = surOp.SortOrder;
                            surveyQuestionAnswerOptionTable.Rows.Add(dr);
                        }
                        _data.ExecuteNonQuery(procName,
                         inputParamMapper: delegate (SqlParameterCollection col)

                         {
                             col.AddWithValue("@NewSurveyId", 0);
                             col.AddWithValue("@NewSectionId", 0);
                             col.AddWithValue("@NewQuestionId", 0);
                             col.AddWithValue("@NewQAOId", 0);
                             col.AddWithValue("@Name", model.Name);
                             col.AddWithValue("@Description", model.Description);
                             col.AddWithValue("@StatusId", model.StatusId);
                             col.AddWithValue("@SurveyTypeId", model.SurveyTypeId);
                             col.AddWithValue("@CreatedBy", userId);
                             col.AddWithValue("@SurveySections", surveySectionTable);
                             col.AddWithValue("UserId", userId);
                             col.AddWithValue("@SurveyQuestions", surveyQuestionTable);
                             col.AddWithValue("@SurveyQuestionAnswerOption", surveyQuestionAnswerOptionTable);

                         }, returnParameters: null
                              );
                    }
                }
            }


        }

        private static void AddCommonParams(AddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@Name", model.Name);
            col.AddWithValue("@Description", model.Description);
            col.AddWithValue("@StatusId", model.StatusId);
            col.AddWithValue("@SurveyTypeId", model.SurveyTypeId);
        }
        private Survey MapSurvey(IDataReader reader)
        {
            Survey survey = new Survey();
            int index = 0;
            survey.Id = reader.GetSafeInt32(index++);
            survey.Name = reader.GetSafeString(index++);
            survey.Description = reader.GetSafeString(index++);
            survey.StatusId = reader.GetSafeInt32(index++);
            survey.StatusName = reader.GetSafeString(index++);
            survey.SurveyTypeId = reader.GetSafeInt32(index++);
            survey.SurveyTypeName = reader.GetSafeString(index++);
            survey.CreatedBy = reader.GetSafeInt32(index++);
            survey.UserName = new Username();
            survey.UserName.FirstName = reader.GetSafeString(index++);
            survey.UserName.LastName = reader.GetSafeString(index++);
            survey.DateCreated = reader.GetDateTime(index++);
            survey.DateModified = reader.GetDateTime(index++);
            return survey;
        }

        private BaseType MapBaseTypeMapper(IDataReader reader)
        {
            BaseType baseType = new BaseType();
            int index = 0;

            baseType.Id = reader.GetSafeInt32(index++);
            baseType.Name = reader.GetString(index++);

            return baseType;
        }
    }
}