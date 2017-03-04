import React, { Component } from 'react';
import Autocomplete from 'react-autocomplete';
import TextField from 'material-ui/TextField';
import {callQueryParamsApi, callJsonApi} from "../util/callApi.js";
import RaisedButton from 'material-ui/RaisedButton';

let styles = {
  item: {
    padding: '2px 6px',
    cursor: 'default'
  },

  highlightedItem: {
    color: 'white',
    background: 'hsl(200, 50%, 50%)',
    padding: '2px 6px',
    cursor: 'default'
  },

  menu: {
    border: 'solid 1px #ccc'
  },

  button: {
    margin: "20px 0px 0px 0px",
    zIndex: -1
  },

  menuAutoComplete: {
    borderRadius: '3px',
    boxShadow: '0 2px 12px rgba(0, 0, 0, 0.1)',
    background: 'rgba(255, 255, 255, 0.9)',
    padding: '2px 0',
    fontSize: '90%',
    position: 'fixed',
    overflow: 'auto',
    maxHeight: '50%',
    zIndex: 300
  }
}

function matchStateToTerm (state, value) {
  return (
    state.name.toLowerCase().indexOf(value.toLowerCase()) !== -1
  )
}

class CreateProgram extends Component {
    constructor(props) {
        super(props);
        this.state = {
            name: "",
            description: ""
        };
        this.handleChange = this.handleChange.bind(this);
        this.submitProgram = this.submitProgram.bind(this);
    }


    handleChange(type, event, selectValue) {
        this.state[type] = event.target.value;
        this.setState(this.state);
    }

    addExercise(){
        this.state.selectedExercises.push(this.state.selectedExercise);
        this.setState(this.state);
    }

    submitProgram(){
        let body = {
            name: this.state.name,
            description: this.state.description,
        }
        callJsonApi("/program", body, "POST").then((data)=>console.log(data));
    }

    render() {
        return (
            <div className="container">
                <TextField
                    hintText="Name"
                    onChange={(event)=>this.handleChange("name", event)}
                    />
                <br/>
                <TextField
                    hintText="Description"
                    onChange={(event)=>this.handleChange("description", event)}
                    />
                <br/>
                <RaisedButton label="Submit program" primary={true} style={styles.button} onTouchTap={this.submitProgram}/>
            </div>
        )
    }
}
export default CreateProgram;
