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

class CreateTrainingDay extends Component {
    constructor(props) {
        super(props);
        this.state = {
            name: "",
            description: "",
            exercises: [],
            selectedExercise: null,
            selectedExerciseValue: "",
            selectedExercises: []
        };
        this.programId = this.props.programId;
        this.handleChange = this.handleChange.bind(this);
        this.addExercise = this.addExercise.bind(this);
        this.submitTrainingDay = this.submitTrainingDay.bind(this);
    }

    componentWillMount() {
        callQueryParamsApi("/exercise", {})
            .then((data)=>{
                this.state.exercises = data;
                this.setState(this.state);
            })
            .catch((err)=>console.log(err));
    }

    handleChange(type, event, selectValue) {
        this.state[type] = event.target.value;
        this.setState(this.state);
    }

    addExercise(){
        this.state.selectedExercises.push(this.state.selectedExercise);
        this.setState(this.state);
    }

    submitTrainingDay(){
        let selectedExercises = this.state.selectedExercises.map(e=>e.eId);
        let body = {
            pId: parseInt(this.programId),
            name: this.state.name,
            exercises: selectedExercises
        }
        callJsonApi("/trainingday", body, "POST").then((data)=>console.log(data));
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
                <Autocomplete
                    value={this.state.selectedExerciseValue}
                    items={this.state.exercises}
                    getItemValue={(item) => item.name}
                    shouldItemRender={matchStateToTerm}
                    renderItem={(item, isHighlighted)=>(
                        <div
                            style={isHighlighted ? styles.highlightedItem : styles.item}
                            key={item.eId}
                            id={item.eId}
                        >{item.name}</div>
                    )}
                    onSelect={(value, object) => {this.setState({selectedExerciseValue: value, selectedExercise: object})}}
                    onChange={(event, value) => this.setState({selectedExerciseValue: value})}
                    inputProps={{size:41}}
                    menuStyle={styles.menuAutoComplete}
                />
                <div>List of exercises chosen: </div>
                {this.state.selectedExercises.map(ex => 
                    <div key={ex.eId}>{ex.name}</div>
                )}
                <RaisedButton label="Add exercise" style={styles.button} onTouchTap={this.addExercise}/>
                <br/>
                <RaisedButton label="Submit training day" primary={true} style={styles.button} onTouchTap={this.submitTrainingDay}/>
            </div>
        )
    }
}
export default CreateTrainingDay;
