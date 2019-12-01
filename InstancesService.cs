using Newtonsoft.Json;
using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Domain.Surveys;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Sabio.Services.Surveys
{
    public class InstancesService : IInstancesService
    {
        IDataProvider _data = null;

        public InstancesService(IDataProvider data)
        {
            _data = data;
        }
        public int Add(InstanceAddRequest model, int userId)
        {
            int id = 0;

            string procName = "[dbo].[SurveysInstances_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {

                    AddCommonParams(model, col);
                    col.AddWithValue("@UserId", userId);
                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;
                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object oId = returnCollection["@Id"].Value;
                    int.TryParse(oId.ToString(), out id);
                });

            return id;
        }
        public int AddFromSurveyId(int surveyId, int userId)
        {
            int id = 0;

            string procName = "[dbo].[SurveysInstances_Insert]";
            _data.ExecuteNonQuery(procName,
                inputParamMapper: delegate (SqlParameterCollection col)
                {

                    col.AddWithValue("@SurveyId", surveyId);
                    col.AddWithValue("@UserId", userId);
                    SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
                    idOut.Direction = ParameterDirection.Output;
                    col.Add(idOut);
                },
                returnParameters: delegate (SqlParameterCollection returnCollection)
                {
                    object oId = returnCollection["@Id"].Value;
                    int.TryParse(oId.ToString(), out id);
                });

            return id;
        }

        public Paged<Instance> Paginate(int pageIndex, int pageSize)
        {
            string procName = "[dbo].[SurveysInstances_SelectAll]";
            Paged<Instance> pagedList = null;
            List<Instance> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                procName, (param) =>
                {
                    param.AddWithValue("@PageIndex", pageIndex);
                    param.AddWithValue("@PageSize", pageSize);
                },
                delegate (IDataReader reader, short set)
                {
                    Instance instance = MapInstance(reader);

                    if(totalCount == 0)
                    {
                        totalCount = reader.GetSafeInt32(8);   //the number of columns you got...very important because if wrong it create an out of bounds array
                    }

                    if (list == null)
                    {
                        list = new List<Instance>();
                    }

                    list.Add(instance);
                }
                );
            if (list != null)
            {
                pagedList = new Paged<Instance>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;
        }  

        public void Delete(int id)
        {
            string procName = "[dbo].[SurveysInstances_Delete_ById]";
            _data.ExecuteNonQuery(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            });
        }

        public Details GetDetails(int id)
        {
            string procName = "[dbo].[SurveysInstances_SelectDetails_ById]";
            Details instance = null;

            _data.ExecuteCmd(procName, delegate (SqlParameterCollection paramCollection)
            {
                paramCollection.AddWithValue("@Id", id);
            },
            delegate (IDataReader reader, short set)
            {
                instance = MapDetails(reader);
            }
            );
            return instance;
        }

        public Paged<Instance> Search(string start, string end, int pageIndex, int pageSize)
        {
            string procName = "[dbo].[SurveysInstances_Search]";
            Paged<Instance> pagedList = null;                
            List<Instance> list = null;
            int totalCount = 0;

            _data.ExecuteCmd(
                procName, (param) =>

                {
                    param.AddWithValue("@Start", start);
                    param.AddWithValue("@End", end);
                    param.AddWithValue("@PageIndex", pageIndex);
                    param.AddWithValue("@PageSize", pageSize);
                },
                 delegate (IDataReader reader, short set)
                 {
                     Instance people = MapInstance(reader);
                     totalCount = reader.GetSafeInt32(8);

                     if (list == null)
                     {
                         list = new List<Instance>();
                     }

                     list.Add(people);
                 }
                );
            if (list != null)
            {
                pagedList = new Paged<Instance>(list, pageIndex, pageSize, totalCount);
            }
            return pagedList;

        }

        public static Details MapDetails(IDataReader reader)
        {

            Details details = new Details();
            int startingIdex = 0;
            details.Instance = new Instance();
            details.Instance.Id = reader.GetSafeInt32(startingIdex++);
            details.Instance.UserId = reader.GetSafeInt32(startingIdex++);
            details.Instance.DateCreated = reader.GetSafeDateTime(startingIdex++);
            details.Instance.DateModified = reader.GetSafeDateTime(startingIdex++);

            details.Survey = new Survey();
            details.Survey.Id = reader.GetSafeInt32(startingIdex++);
            details.Survey.Name = reader.GetSafeString(startingIdex++);
            details.Survey.Description = reader.GetSafeString(startingIdex++);
            details.Survey.CreatedBy = reader.GetSafeInt32(startingIdex++);

            details.SurveyStatus = new SurveyStatus();
            details.SurveyStatus.Name = reader.GetSafeString(startingIdex++);

            details.SurveyTypes = new SurveyTypes();
            details.SurveyTypes.Name = reader.GetSafeString(startingIdex++);

            string question = reader.GetSafeString(startingIdex++);
            details.Questions = JsonConvert.DeserializeObject<List<InstanceQuestion>>(question);

            return details;
        }

        public static Instance MapInstance(IDataReader reader)
        {
            Instance instance = new Instance();
            int startingIdex = 0;
            instance.Id = reader.GetSafeInt32(startingIdex++);
            instance.SurveyId = reader.GetSafeInt32(startingIdex++);
            instance.UserProfile = new UserProfile();
            instance.UserProfile.UserId = reader.GetSafeInt32(startingIdex++);
            instance.UserProfile.FirstName = reader.GetSafeString(startingIdex++);
            instance.UserProfile.LastName = reader.GetSafeString(startingIdex++);
            instance.Survey = new Survey();
            instance.Survey.Name = reader.GetSafeString(startingIdex++);
            instance.DateCreated = reader.GetSafeDateTime(startingIdex++);
            instance.DateModified = reader.GetSafeDateTime(startingIdex++);

            return instance;
        }
        private static void AddCommonParams(InstanceAddRequest model, SqlParameterCollection col)
        {
            col.AddWithValue("@SurveyId", model.SurveyId);
        }
    }
}
