import React from "react";
import PropTypes from "prop-types";
import "./Surveys.css";

const SurveyCard = props => {
  const selectedItemEdit = () => {
    props.showEditSurveyForm(props.survey);
  };
  return (
    <div className="col-sm-12 col-xl-12">
      <div className="card survey-card">
        <div className="product-box">
          <div className="card-header b-l-primary border-3">
            <h5>{props.survey.name}</h5>
            <div className="product-img">
              <div className="product-hover">
                <ul>
                  <li>
                    <i className="fa fa-pencil-square-o" onClick={selectedItemEdit} />
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <div className="card-body">
            <p>{props.survey.description}</p>
          </div>
          <div className="card-footer">
            {props.survey.userName.firstName} {props.survey.userName.lastName}
            <div className="float-right">
              {props.survey.statusName}{" "}
              {props.survey.statusId === 1 ? (
                <i className="fa fa-circle text-info" />
              ) : props.survey.statusId === 2 ? (
                <i className="fa fa-circle text-success" />
              ) : props.survey.statusId === 3 ? (
                <i className="fa fa-circle text-warning" />
              ) : props.survey.statusId === 4 ? (
                <i className="fa fa-circle text-danger" />
              ) : (
                      ""
                    )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

SurveyCard.propTypes = {
  showEditSurveyForm: PropTypes.func.isRequired,
  survey: PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
    description: PropTypes.string.isRequired,
    createdBy: PropTypes.string.isRequired,
    firstName: PropTypes.string.isRequired,
    lastName: PropTypes.string.isRequired,
    statusId: PropTypes.number.isRequired,
    statusName: PropTypes.string.isRequired,
    userName: PropTypes.shape({
      firstName: PropTypes.string.isRequired,
      lastName: PropTypes.string.isRequired
    })
  })
};

export default SurveyCard;
