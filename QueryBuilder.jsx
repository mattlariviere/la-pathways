import React from "react";
import logger from "sabio-debug";
import { Typeahead } from "react-bootstrap-typeahead";
import "react-bootstrap-typeahead/css/Typeahead.css";
import { Form, Button, FormGroup, Label } from "reactstrap";
import { Formik, Field } from "formik";
import PropTypes from "prop-types";
import "./recommendations.css";
import swal from "sweetalert";
// import Auth from "./../../assets/images/auth-layer.png";
import * as recommendationsServices from "../../services/recommendationsService";
import queryBuilderValidationSchema from "./queryBuilderValidationSchema";
import sqlConditionFunction from "./query";
import * as resourceService from "../../services/resourceRecommendationService";

const _logger = logger.extend("Recommendations");

class Recommendations extends React.Component {
  state = {
    formData: {
      resourceId: [],
      condition: "",
      query: ""
    },
    selected: 0,
    value: "",
    name: "",
    resourcesMap: [],
    resources: [],
    mapResources: [],
    isEditing: false
  };

  componentDidMount() {
    _logger("Resources Loading...");
    let { id } = this.props.match.params;
    if (id) {
      let resource = this.props.history.location.state;
      _logger(resource, "====");
      if (resource) {
        this.setState(prevState => {
          return {
            ...prevState,
            formData: {
              ...prevState.formData,
              resourceId: resource.id,
              query: resource.query
            },
            isEditing: true
          };
        });
      } else {
        resourceService
          .getConditionById(id)
          .then(this.onGetResourceSuccess)
          .catch(this.onGetResourcesFailure);
      }
    }

    recommendationsServices
      .getResources()
      .then(this.getResourcesSuccess)
      .catch(this.getResourcesFailure);
  }

  getResourcesSuccess = data => {
    _logger("Resources are showing.");
    _logger(data);
    let resourcesArray = data.items;
    this.setState(prevState => {
      return {
        ...prevState,
        resources: resourcesArray,
        mapResources: resourcesArray.map(this.mapResources)
      };
    });
  };

  onGetResourceSuccess = data => {
    _logger(data.item);
    this.setState(prevState => {
      return {
        ...prevState,
        formData: {
          ...prevState,
          resourceId: data.item.resourceId,
          condition: data.item.condition,
          query: data.item.query
        },
        isEditing: true
      };
    });
  };

  getResourcesFailure = () => {
    _logger("Resources are not showing.");
  };

  mapResources = resource => (
    <option key={resource.id} value={resource.id}>
      {resource.name}
    </option>
  );

  handleSubmit = values => {
    values.condition = sqlConditionFunction(values.query.toUpperCase());
    if (this.state.isEditing) {
      recommendationsServices
        .recommendationsUpdate(values)
        .then(this.onSubmitSuccess)
        .catch(this.onSubmitError);
    } else {
      recommendationsServices
        .recommendationsInsert(values)
        .then(this.onSubmitSuccess)
        .catch(this.onSubmitError);
    }
  };

  onSubmitSuccess = () => {
    if (this.state.isEditing) {
      swal("Success!", "Your resource query has been updated", "success");
    } else {
      swal("Success!", "Your resource query has been added", "success");
    }
    this.resetFormData();
    setTimeout(() => {
      swal.close();
      this.props.history.push(`/resources/queries`);
    }, 800);
    _logger("Recommendation Added.");
  };

  resetFormData = () => {
    this.setState(prevState => {
      return {
        ...prevState,
        formData: {
          resourceId: [],
          condition: "",
          query: ""
        }
      };
    });
  };

  onSubmitError = () => {
    swal(
      "Oops!",
      "Something went wrong, please check if the inputs are correct",
      "info"
    );

    _logger("Recommendation Insert Failed.");
  };

  resourceMapper = resource => {
    return resource.id;
  };

  handleChange = resourceArr => {
    _logger(".......", resourceArr);

    let idArr = resourceArr.map(this.resourceMapper);

    _logger(idArr);
    this.setState(prevState => {
      return {
        ...prevState,
        resourceId: idArr,
        formData: {
          ...prevState.formData,
          resourceId: idArr
        }
      };
    });
  };

  render() {
    return (
      <React.Fragment>
        <div className="row">
          <div className="col-md-12">
            {" "}
            <h3 className="m-20">Query Builder</h3>
          </div>
        </div>
        <div className="row">
          <div className="col-sm-12">
            <div className="card">
              <div className="card-header">
                <h5 className="m-30">Resource Query Builder</h5>
                <span>
                  In this form you are able to link resources to different
                  category types. Please be careful and follow explicit
                  instructions
                </span>
              </div>
              <div className="card-body">
                <Formik
                  enableReinitialize={true}
                  validationSchema={queryBuilderValidationSchema}
                  initialValues={this.state.formData}
                  onSubmit={this.handleSubmit}
                  onHandleChange={this.onHandleChange}
                >
                  {props => {
                    const {
                      values,
                      touched,
                      errors,
                      handleSubmit,
                      isValid
                    } = props;
                    return (
                      <Form onSubmit={handleSubmit}>
                        <FormGroup>
                          <Label htmlFor="resourceId">Resources</Label>
                          <Typeahead
                            id="typeAhead"
                            name="resourceId"
                            labelKey={option => `${option.name}`}
                            multiple={!this.state.isEditing}
                            selected={
                              this.state.isEditing
                                ? this.state.resources.filter(
                                    item => item.id === values.resourceId
                                  )
                                : 0
                            }
                            options={this.state.resources}
                            placeholder="Select your resource..."
                            onChange={this.handleChange}
                          />
                        </FormGroup>
                        <FormGroup>
                          <Label>Condition</Label>
                          <p>Please fill out with the appropriate format</p>
                          <p className="txt-primary">
                            <i className="fa fa-angle-double-right txt-primary m-r-10"></i>
                            Simple Statement: TA1
                          </p>
                          <p className="txt-primary">
                            <i className="fa fa-angle-double-right txt-primary m-r-10"></i>
                            Simple OR Statement: TA1 OR TA2
                          </p>
                          <p className="txt-primary">
                            <i className="fa fa-angle-double-right txt-primary m-r-10"></i>
                            Simple AND Statement: LOC6 AND COM3
                          </p>
                          <p className="txt-primary">
                            <i className="fa fa-angle-double-right txt-primary m-r-10"></i>
                            Simple AND/OR Statement: LOC6 AND DEMO1 OR DEMO2 OR
                            DEMO3
                          </p>
                          <p className="txt-primary">
                            <i className="fa fa-angle-double-right txt-primary m-r-10"></i>
                            Complex Statement: CAP2 AND CAP4 OR CAP5 / LOC6 OR
                            COM3 / LOC2 AND TA1 AND IND8
                          </p>
                          <div>
                            <Field
                              name="query"
                              type="text"
                              values={values.query}
                              placeholder="Build your query here..."
                              className={
                                errors.query && touched.query
                                  ? "form-control error"
                                  : "form-control"
                              }
                            />
                            {errors.query && touched.query && (
                              <span className="input-feedback">
                                {errors.query}
                              </span>
                            )}
                          </div>
                        </FormGroup>
                        ​
                        <div className="card-footer">
                          <Button
                            type="submit"
                            value="Submit"
                            disabled={!isValid}
                            className="btn btn-primary mt-2"
                          >
                            {this.state.isEditing ? "Update Query" : "Submit"}
                          </Button>
                        </div>
                      </Form>
                    );
                  }}
                </Formik>
              </div>
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  }
}

Recommendations.propTypes = {
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string
    })
  }),
  history: PropTypes.shape({
    push: PropTypes.func,
    location: PropTypes.shape({
      state: PropTypes.shape({
        id: PropTypes.number,
        resourceId: PropTypes.number,
        query: PropTypes.string,
        condition: PropTypes.string
      })
    })
  }),
  state: PropTypes.shape({
    id: PropTypes.number,
    query: PropTypes.string,
    condition: PropTypes.string
  })
};

export default Recommendations;
