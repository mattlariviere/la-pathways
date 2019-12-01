import React, { Component } from "react";
import * as resourceService from "../../services/resourceRecommendationService";
import logger from "sabio-debug";
import ResourceRecommendationCard from "./ResourceRecommendationCard";
import Pagination from "rc-pagination";
import "rc-pagination/assets/index.css";
import swal from "sweetalert";
// import * as _ from "lodash";
import PropTypes from "prop-types";

const _logger = logger.extend("ResourceRecommendations");

class ResourceRecommendations extends Component {
  constructor() {
    super();
    this.state = {
      activeTab: "1",
      setActiveTab: "1",
      active: "1",
      instanceId: [],
      pageSize: 6,
      current: 0,
      totalCount: 0,
      resources: [],
      categories: {},
      mappedResources: [],
      email: ""
    };
  }

  componentDidMount = () => {
    let { id } = this.props.match.params;
    this.setState(prevState => {
      return {
        ...prevState,
        instanceId: id
      };
    });
    if (id) {
      resourceService
        .getResourcesByInstanceId(id, this.state.current, this.state.pageSize)
        .then(this.onGetResourcesSuccess)
        .catch(this.onGetError);
    }
  };

  onGetResourcesSuccess = data => {
    _logger(data.item);
    let resources = data.item.pagedItems;
    // let categories = resources.map(this.filterResourceTypes);
    this.setState(prevState => {
      return {
        ...prevState,
        resources,
        // categories,
        mappedResources: resources.map(this.mapRecommendation),
        totalCount: data.item.totalCount
      };
    });
  };

  onChange = page => {
    this.setState(prevState => {
      return {
        ...prevState,
        current: page - 1
      };
    });

    resourceService
      .getResourcesByInstanceId(
        this.state.instanceId,
        page - 1,
        this.state.pageSize
      )
      .then(this.onGetResourcesSuccess)
      .catch(this.onGetError);
  };

  mapRecommendation = recommendation => (
    <ResourceRecommendationCard
      pushToViewMore={this.pushToViewMore}
      recommendation={recommendation}
      key={recommendation.id}
    />
  );

  pushToViewMore = recommendation => {
    this.props.history.push(
      `/resources/recommendations/viewmore/${this.state.instanceId}/${recommendation.id}`,
      recommendation,
      this.state.instanceId
    );
  };

  handleEmailResults = () => {
    swal("Please enter the email you would like to send to:", {
      content: "input",
      button: {
        text: "Submit",
        closeModal: false
      }
    }).then(value => {
      if (!value) {
        swal.close();
      } else {
        this.setState(prevState => {
          return {
            ...prevState,
            email: value
          };
        });
        swal(
          "Email Sent!",
          "Please check your email for your personalized resources",
          "success"
        );
      }
    });
  };

  render() {
    return (
      <div className="m-10">
        <div className="row m-2 text-center">
          <div className="col-md-12">
            <h3>Resource Recommendations</h3>
          </div>
        </div>
        <div className="row m-1 text-center">
          <div className="col-md-12">
            <h5>
              Thank you for completing the survey! Here are your resources that
              will help your company grow!
            </h5>
          </div>
        </div>
        <div className="row">{this.state.mappedResources}</div>
        <div className="row">
          <Pagination
            className="pb-3 m-auto ant-pagination pagination"
            pageSize={this.state.pageSize}
            onChange={this.onChange}
            current={this.state.current + 1}
            total={this.state.totalCount}
            showTitle={false}
          />
        </div>
      </div>
    );
  }
}

ResourceRecommendations.propTypes = {
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string
    })
  }),
  history: PropTypes.shape({
    push: PropTypes.func.isRequired
  })
};

export default ResourceRecommendations;
