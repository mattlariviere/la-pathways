import React from "react";
import logger from "sabio-debug";
import * as surveyService from "../../services/surveyService";
import SurveyCard from "./SurveyCard";
import PropTypes from "prop-types";
import Pagination from "rc-pagination";
import "rc-pagination/assets/index.css";

const _logger = logger.extend("Surveys");

class Surveys extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      current: 0,
      total: 0,
      surveys: [],
      mappedSurveys: [],
      pageSize: 8
    };
  }

  componentDidMount = () => {
    let pageSize = this.state.pageSize;
    let current = this.state.current;
    surveyService
      .getAll(current, pageSize)
      .then(this.onGetAllSuccess)
      .catch(this.onGenericError);
  };

  onGetAllSuccess = data => {
    let surveys = data.item.pagedItems;
    this.setState(prevState => {
      return {
        ...prevState,
        surveys: surveys,
        mappedSurveys: surveys.map(this.mapSurvey),
        total: data.item.totalCount
      };
    });
    _logger(this.state.surveys);
  };
  onGenericError = errMessage => {
    _logger(errMessage);
  };

  onChange = page => {
    _logger(page);
    this.setState(prevState => {
      return {
        ...prevState,
        current: page
      };
    });
    surveyService
      .getAll(page - 1, this.state.pageSize)
      .then(this.onGetAllSuccess)
      .catch(this.onGenericError);
  };

  showCreateSurveyForm = () => {
    this.props.history.push("/survey/new");
  };
  showEditSurveyForm = survey => {
    _logger(survey);
    this.props.history.push({ pathname: `/survey/edit/${survey.id}`, survey });
  };

  mapSurvey = survey => (
    <SurveyCard
      showEditSurveyForm={this.showEditSurveyForm}
      survey={survey}
      key={survey.id}
    />
  );

  render() {
    _logger("rendering");
    return (
      <div className="container-fluid">
        <div className="row mb-4">
          <h1>Surveys</h1>
        </div>
        <div className="row mb-4">
          <button
            onClick={this.showCreateSurveyForm}
            className="btn-pill btn-primary btn-air-primary btn btn-primary"
          >
            Add a Survey
          </button>
        </div>
        <div className="row">
          {this.state.mappedSurveys ? this.state.mappedSurveys : ""}
        </div>
        <div className="row">
          <div className="offset-md-5 col-md-2 mb-4">
            <Pagination
              showTitle={false}
              className="ant-pagination pagination"
              onChange={this.onChange}
              current={this.state.current}
              pageSize={6}
              total={this.state.total}
            />
          </div>
        </div>
      </div>
    );
  }
}

Surveys.propTypes = {
  history: PropTypes.shape({
    push: PropTypes.func.isRequired
  })
};

export default Surveys;
