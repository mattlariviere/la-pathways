import { Datatable } from "@o2xp/react-datatable";
import React, { Component } from "react";
import PropTypes from "prop-types";
import * as adminServices from "../../services/adminServices";
import logger from "sabio-debug";

const _logger = logger.extend("ResourcesTable");
class ResourcesTable extends Component {
  constructor(props) {
    super(props);
    this.state = {
      resources: [],
      options: {
        title: "Resource",
        dimensions: {
          datatable: {
            width: "80vw",
            height: "95%"
          },
          row: {
            height: "80px"
          }
        },
        keyColumn: "resourceId",
        font: "Arial",
        data: {
          columns: [
            {
              id: "resourceId",
              label: "Resource Id",
              colSize: "25px",
              editable: false
            },
            {
              id: "edit",
              label: "Edit",
              colSize: "25px",
              editable: false
            },
            {
              id: "resourceName",
              label: "Resource Name",
              colSize: "75px",
              editable: false,
              dataType: "text",
              inputType: "input"
            },
            {
              id: "query",
              label: "Query",
              colSize: "75px",
              editable: false
            }
          ],
          rows: []
        },
        features: {
          canDelete: false,
          canPrint: true,
          canDownload: true,
          canSearch: true,
          canRefreshRows: false,
          canOrderColumns: true,
          canSelectRow: true,
          canSaveUserConfiguration: false,
          userConfiguration: {
            columnsOrder: ["resourceId", "edit", "resourceName", "query"],
            copyToClipboard: false
          },
          rowsPerPage: {
            available: [10, 25, 50, 100],
            selected: 50
          }
        }
      }
    };
  }

  componentDidMount() {
    adminServices
      .getAllRecources()
      .then(this.getResourcesSucc)
      .catch(this.getResourcesErr);
  }
  getResourcesSucc = data => {
    _logger(data.items, "All Resources");
    let values = data.items.map(this.mapResource);
    this.setState(prevState => {
      return {
        ...prevState,
        resources: data.items,
        options: {
          ...prevState.options,
          data: {
            ...prevState.options.data,
            rows: values
          }
        }
      };
    });
  };

  mapResource = (item, index) => {
    let editButton = (
      <a className="txt-primary">
        <i
          key={item.id}
          className="fa fa-pencil fa-lg"
          id={index}
          onClick={this.onEditClick}
        ></i>
      </a>
    );
    return {
      resourceId: item.id,
      resourceName: item.name,
      query: item.query,
      edit: editButton
    };
  };

  onEditClick = e => {
    let resource = this.state.resources[e.target.id];
    _logger(this.state.resources[e.target.id]);
    this.props.history.push(`/queryBuilder/edit/${resource.id}`, resource);
  };

  render() {
    return <Datatable options={this.state.options} />;
  }
}

ResourcesTable.propTypes = {
  history: PropTypes.shape({
    push: PropTypes.func
  }),
  resources: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
    email: PropTypes.string,
    phone: PropTypes.number
  })
};

export default ResourcesTable;
