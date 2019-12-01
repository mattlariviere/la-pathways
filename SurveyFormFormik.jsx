import React from "react";
import { Form } from "reactstrap";
import { Formik, Field } from "formik";
import PropTypes from "prop-types";
import logger from "sabio-debug";
import swal from "sweetalert";
import surveysValidationSchema from "./surveysValidationSchema";
import * as surveyService from "../../services/surveyService";

const _logger = logger.extend("SurveyFormFormik");

class SurveyFormFormik extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isEditing: false,
      formData: {
        name: "",
        description: "",
        statusId: 0,
        surveyTypeId: 0
      },
      surveyTypes: [],
      surveyStatuses: []
    };
  }
  componentDidMount = () => {
    const { id } = this.props.match.params;
    if (id) {
      let formData = this.props.location.survey;
      if (formData) {
        this.setFormData(formData);
      } else {
        surveyService
          .getById(id)
          .then(this.onGetByIdComponentDidMount)
          .catch(this.onGenericError);
      }
    }

    surveyService
      .getSurveyStatusTypes()
      .then(this.onGetSurveyStatusTypesSuccess)
      .catch(this.onGenericError);
  };

  setFormData = resultData => {
    let data = resultData;

    let formData = {
      id: data.id,
      name: data.name,
      description: data.description,
      statusId: data.statusId.toString(),
      surveyTypeId: data.surveyTypeId.toString()
    };

    this.setState(prevState => {
      return {
        ...prevState,
        formData,
        isEditing: true
      };
    });
  };

  handleChange = e => {
    let name = e.target.name;
    let value = e.target.value;
    this.setState(prevState => {
      return {
        ...prevState,
        formData: {
          ...prevState.formData,
          [name]: value
        }
      };
    });
  };
  onCreateSurveySuccess = data => {
    //get by Id to push the survey?
    let id = data.item;

    surveyService
      .getById(id)
      .then(this.onGetByIdSuccess)
      .catch(this.onGenericError);
    // sweet alert
    swal(`Success!`, `You have created a new survey`, "success");
    setTimeout(() => {
      this.props.history.push("/surveys");
      swal.close();
    }, 700);
  };
  onUpdateSurveySuccess = () => {
    let survey = this.state.formData;
    swal(`Success!`, `${survey.name} has been updated`, "success");
    setTimeout(() => {
      this.props.history.push("/surveys", survey);
      swal.close();
    }, 700);
  };
  onGetByIdComponentDidMount = data => {
    let survey = data.item;
    this.setState(prevState => {
      return {
        ...prevState,
        formData: survey,
        isEditing: true
      };
    });
  };
  onGetSurveyStatusTypesSuccess = data => {
    _logger(data);
    let surveyTypes = data.item.types;
    let surveyStatuses = data.item.status;
    this.setState(prevState => {
      return {
        ...prevState,
        surveyTypes,
        mappedSurveyTypes: surveyTypes.map(this.mapSelect),
        surveyStatuses,
        mappedSurveyStatuses: surveyStatuses.map(this.mapSelect)
      };
    });
  };
  onGenericError = errMessage => {
    _logger(errMessage);
  };
  onSubmitError = errMessage => {
    _logger(errMessage);
    swal("Oops", "Please check your form values", "danger");
  };

  handleSubmit = values => {
    _logger(values);
    if (this.state.formData.id) {
      surveyService
        .update(values)
        .then(this.onUpdateSurveySuccess)
        .catch(this.onSubmitError);
    } else {
      surveyService
        .create(values)
        .then(this.onCreateSurveySuccess)
        .catch(this.onSubmitError);
    }
  };

  mapSelect = survey => (
    <option key={survey.id} value={survey.id}>
      {survey.name}
    </option>
  );
  goToSurvey = () => {
    this.props.history.push("/surveys");
  };

  render() {
    return (
      <React.Fragment>
        <div className="col-sm-12">
          <h1>Survey Form</h1>
          <Formik
            enableReinitialize={true}
            validationSchema={surveysValidationSchema}
            initialValues={this.state.formData}
            onSubmit={this.handleSubmit}
            isInitialValid={this.state.isEditing}
          >
            {props => {
              const { values, touched, errors, isValid, handleSubmit } = props;
              return (
                <div className="card">
                  <div className="card-header">
                    <h5>Add a New Survey</h5>
                    <div>
                      Please fill out this form in order to submit a new survey
                    </div>
                  </div>
                  <div className="card-body">
                    <Form className={"theme-form"} onSubmit={handleSubmit}>
                      <div className="card-body">
                        <div className={"row form-group"}>
                          <label className={"col-sm-3 col-form-label"}>
                            Survey Name
                          </label>
                          <div className={"col-sm-9"}>
                            <Field
                              name="name"
                              type="text"
                              values={values.name}
                              placeholder="Survey Name..."
                              autoComplete="off"
                              className={
                                errors.name && touched.name
                                  ? "form-control errorMessage"
                                  : "form-control"
                              }
                            />
                            {errors.name && touched.name && (
                              <span className="text-danger">{errors.name}</span>
                            )}
                          </div>
                        </div>
                        <div className={"row form-group"}>
                          <label className={"col-sm-3 col-form-label"}>
                            Description
                          </label>
                          <div className={"col-sm-9"}>
                            <Field
                              name="description"
                              placeholder="Please enter a short description about this survey"
                              component="textarea"
                              as="textarea"
                              rows="5"
                              values={values.description}
                              autoComplete="off"
                              className={
                                errors.description && touched.description
                                  ? "form-control errorMessage"
                                  : "form-control"
                              }
                            />
                            {errors.description && touched.description && (
                              <span className="text-danger">
                                {errors.description}
                              </span>
                            )}
                          </div>
                        </div>
                        <div className={"row form-group"}>
                          <label className={"col-sm-3 col-form-label"}>
                            Survey Type
                          </label>
                          <div className={"col-sm-9"}>
                            <Field
                              name="surveyTypeId"
                              component="select"
                              values={parseInt(values.surveyTypeId)}
                              label="surveyTypeId"
                              className={
                                errors.surveyTypeId && touched.surveyTypeId
                                  ? "form-control error"
                                  : "form-control"
                              }
                              as="select"
                            >
                              <option key={0} value={0}>
                                Select Survey Type...
                              </option>
                              {this.state.mappedSurveyTypes}
                            </Field>
                          </div>
                          <div>
                            {errors.surveyTypeId && touched.surveyTypeId && (
                              <span className="text-danger">
                                {errors.surveyTypeId}
                              </span>
                            )}
                          </div>
                        </div>
                        <div className={"row form-group"}>
                          <label className={"col-sm-3 col-form-label"}>
                            Survey Status
                          </label>
                          <div className={"col-sm-9"}>
                            <Field
                              name="statusId"
                              component="select"
                              values={parseInt(values.statusId)}
                              label="statusId"
                              className={
                                errors.statusId && touched.statusId
                                  ? "form-control error"
                                  : "form-control"
                              }
                              as="select"
                            >
                              <option key={0} value={0}>
                                Select Survey Status...
                              </option>
                              {this.state.mappedSurveyStatuses}
                            </Field>
                          </div>
                          <div>
                            {errors.statusId && touched.statusId && (
                              <span className="text-danger">
                                {errors.statusId}
                              </span>
                            )}
                          </div>
                        </div>
                        <div className="row form-group"></div>
                      </div>
                      <div className="card-footer">
                        <button
                          type="submit"
                          className="btn btn-primary ml-2"
                          disabled={!isValid}
                        >
                          {this.state.isEditing ? `Update` : `Submit`}
                        </button>
                        <button
                          type="button"
                          onClick={this.goToSurvey}
                          className="btn btn-secondary ml-2"
                        >
                          Cancel
                        </button>
                      </div>
                    </Form>
                  </div>
                </div>
              );
            }}
          </Formik>
        </div>
      </React.Fragment>
    );
  }
}

SurveyFormFormik.propTypes = {
  history: PropTypes.shape({
    push: PropTypes.func.isRequired
  }),
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.number
    })
  }),
  location: PropTypes.shape({
    survey: PropTypes.shape({
      id: PropTypes.number.isRequired,
      name: PropTypes.string.isRequired,
      description: PropTypes.string.isRequired,
      createdBy: PropTypes.string.isRequired
    })
  })
};

export default SurveyFormFormik;
