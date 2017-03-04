import React, { Component } from 'react';
import ReactHighcharts from 'react-highcharts';
import {callQueryParamsApi} from "../util/callApi";
import { browserHistory } from 'react-router';
import {callbackSnackbar, loadingSnackbar} from "../util/snackbarFactory";
import Snackbar from 'material-ui/Snackbar';

const dataTypes = ["temperature", "light", "sound"];

class Chart extends Component {
    constructor(props) {
        super(props);
        this.state = {
            dataType: "temperature",
            snackbar: {
                content: "",
                open: false,
                action: null
            },
            from: ""
        };
        this.handleSnackbarClose = this.handleSnackbarClose.bind(this);
        this.onShowSnackbar = this.onShowSnackbar.bind(this);
    }

    handleSnackbarClose(reason) {
        if (reason === "clickaway") {
            return;
        }
        this.state.snackbar.open = false;
        this.setState(this.state);
    }

    onShowSnackbar(snackbar) {
        snackbar.open = true;
        this.setState({snackbar: snackbar})
    }

    render() {
        return (
            <div>
                <Snackbar
                    action={this.state.snackbar.action}
                    open={this.state.snackbar.open}
                    message={this.state.snackbar.content}
                    autoHideDuration={this.state.snackbar.duration}
                    onRequestClose={this.handleSnackbarClose}
                    />
            </div>
        )
    }
}
Chart.contextTypes = {
  configs: React.PropTypes.object
};
export default Chart;
