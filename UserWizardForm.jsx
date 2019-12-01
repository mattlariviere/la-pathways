import React from "react";
import * as surveyQuestionsAndAnswers from "../../services/surveyQuestionsAndAnswers";
import Section from "./Section";
import Answer from "./Answer";
import Question from "./Question";
import swal from "sweetalert";
import PropTypes from "prop-types";

class UserWizardForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      currentPage: 0,
      surveyId: 50,
      sections: [],
      mappedSections: [],
      InstanceAnswersRequests: [],
      currentView: null,
      isValid: false
    };
  }

  componentDidMount() {
    this.getSurveyDetails();
  }

  getSurveyDetails = () => {
    surveyQuestionsAndAnswers
      .getSurveyDetails(this.state.surveyId)
      .then(this.getSurveyDetailsSuccess)
      .catch(this.getSurveyDetailsError);
  };

  getSurveyDetailsSuccess = data => {
    let list = data.item.section.length > 0 ? data.item.section : [];
    let sections = list.map(section => {
      let questions = section.questions.map(question => {
        return {
          ...question,
          mappedAnswers: question.answerOptions.map(item =>
            this.mapAnswer(item, question.questionTypeId)
          )
        };
      });
      return {
        ...section,
        mappedQuestions: questions.map(this.mapQuestion)
      };
    });
    this.setState(
      prevState => {
        return {
          ...prevState,
          sections,
          mappedSections: sections.map(this.mapSection)
        };
      },
      () => this.detailReturn(0)
    );
  };

  onAnswered = e => {
    let value = e.target.value;
    let name = e.target.name;

    this.setState(prevState => {
      let instances = [...prevState.InstanceAnswersRequests];
      let current = {
        questionId: this.getQuestionNumber(),
        [name]: [parseInt(value)]
      };
      instances[this.state.currentPage] = current;
      return {
        ...prevState,
        InstanceAnswersRequests: [...instances],
        isValid: value.length > 0 ? true : false
      };
    });
  };

  onClickedCheckBox = e => {
    let isChecked = e.target.checked;
    let value = e.target.value;
    let name = e.target.name;
    this.setState(prevState => {
      let instances = [...prevState.InstanceAnswersRequests];
      let currentAnswers = instances[this.state.currentPage]
        ? instances[this.state.currentPage].answerId
        : [];
      let currentAnswersLength = currentAnswers.length;

      let item = instances[this.state.currentPage]
        ? instances[this.state.currentPage]
        : {};

      item.questionId = this.getQuestionNumber();
      if (!isChecked) {
        item[name] =
          currentAnswersLength > 0
            ? currentAnswers.filter(item => item !== parseInt(value))
            : [];
        currentAnswersLength = item[name] ? item[name].length : [];
      } else {
        item[name] =
          currentAnswersLength > 0
            ? currentAnswers.concat(parseInt(value))
            : [parseInt(value)];
        currentAnswersLength = item[name] ? item[name].length : [];
      }

      instances[this.state.currentPage] = item;
      return {
        InstanceAnswersRequests: [...instances],
        isValid: currentAnswersLength > 0 ? true : false
      };
    });
  };

  getQuestionNumber = () => {
    return this.state.sections[this.state.currentPage].questions[0].questionId;
  };

  mapAnswer = (answer, typeId) => (
    <Answer
      key={answer.answerOptionId}
      Id={answer.answerOptionId}
      text={answer.text}
      name={"text"}
      value={answer.answerOptionId}
      typeId={typeId}
      onAnswered={this.onAnswered}
      clickedCheckBox={this.onClickedCheckBox}
    />
  );

  mapQuestion = question => (
    <Question
      key={question.questionId}
      question={question.question}
      answers={question.mappedAnswers}
      name={"text"}
      value={question.questionId}
    />
  );

  mapSection = section => (
    <Section
      key={section.surveysSectionsId}
      title={section.title}
      questions={section.mappedQuestions}
    />
  );

  _next = () => {
    let currentPage = this.state.currentPage;
    currentPage = currentPage >= 6 ? 7 : currentPage + 1;
    this.detailReturn(currentPage);
  };

  _prev = () => {
    let currentPage = this.state.currentPage;
    currentPage = currentPage <= 0 ? 0 : currentPage - 1;
    this.detailReturn(currentPage);
    this.onPreviousClickDelete();
  };

  detailReturn = page => {
    this.setState(prevState => {
      return {
        ...prevState,
        currentPage: page,
        currentView: this.state.mappedSections[page],
        isValid: false
      };
    });
  };

  onPreviousClickDelete = () => {
    const InstanceAnswersRequests = this.state.InstanceAnswersRequests;
    InstanceAnswersRequests.splice(this.state.currentPage);
    this.setState(
      prevState => {
        return {
          ...prevState,
          InstanceAnswersRequests
        };
      },
      () => {
        if (this.state.currentPage === 0) {
          this.setState(prevState => {
            return {
              ...prevState,
              InstanceAnswersRequests: []
            };
          });
        }
      }
    );
  };

  finishedSurvey = () => {
    surveyQuestionsAndAnswers
      .postNewSurvey({
        InstanceAnswersRequests: this.state.InstanceAnswersRequests,
        SurveyId: this.state.surveyId
      })
      .then(this.postNewSurveySuccess)
      .catch(this.postNewSurveyError);
  };

  postNewSurveySuccess = data => {
    swal({
      title: "Thank you for taking the survey.",
      icon: "success"
    });
    let id = data.item;
    setTimeout(() => {
      swal.close();
      this.props.history.push(`/resources/recommendations/${id}`, id);
    }, 700);
  };

  postNewSurveyError = () => {
    swal({
      title: "Something went wrong. Please try again.",
      icon: "error"
    });
  };

  render() {
    return (
      <>
        <div className="row pt-5">
          {this.state.mappedSections.length > 0 && this.state.currentView}
        </div>

        {this.state.currentPage > 0 ? (
          <button
            className="btn btn-secondary"
            type="button"
            onClick={this._prev}
          >
            Previous
          </button>
        ) : null}

        {this.state.currentPage === 7 ? (
          <button
            type="button"
            disabled={!this.state.isValid}
            className="btn btn-success sweet-3 float-right"
            onClick={this.finishedSurvey}
          >
            Finish
          </button>
        ) : (
          <button
            className="btn btn-primary float-right"
            type="button"
            onClick={this._next}
            disabled={!this.state.isValid}
          >
            {this.state.currentPage !== 7 ? "Next" : "Finish"}
          </button>
        )}
      </>
    );
  }
}

UserWizardForm.propTypes = {
  history: PropTypes.shape({
    push: PropTypes.func
  })
};

export default UserWizardForm;
