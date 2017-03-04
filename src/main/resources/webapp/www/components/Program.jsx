import React, { Component } from 'react';
import {callQueryParamsApi, callJsonApi} from "../util/callApi.js";
import Paper from 'material-ui/Paper';
import RaisedButton from 'material-ui/RaisedButton';
import TextField from 'material-ui/TextField';

let styles = {
    exercise: {
        display: 'inline-block',
        margin: '30px'
    }
}

export default class Program extends Component {
    constructor(props) {
        super(props);
        this.state = {
            program: null,
            exercises: []
        };
        this.programId = props.params.id;
        this.handleChange = this.handleChange.bind(this);
        this.addResult = this.addResult.bind(this);
    }

    componentWillMount() {
        callQueryParamsApi("/program/"+this.programId, {})
            .then((data)=>{
                this.state.program = data;
                var idList = data[0].exercises.map(eId => "id="+eId+"&");
                idList = idList.toString().replace(/,/g, "")
                callQueryParamsApi("/programexercise?" + idList, {})
                    .then((data)=>{
                        this.state.exercises = data;
                        this.setState(this.state);
                    })
            })
    }    

    handleChange(type, event, eIndex) {
        this.state.exercises[eIndex][type] = event.target.value;
    }

    addResult(eIndex){
        let body = {
            pId: parseInt(this.programId),
            eId: this.state.exercises[eIndex].eId,
            repCount: parseInt(this.state.exercises[eIndex].repCount),
            weight: parseInt(this.state.exercises[eIndex].weight)
        }
        console.log(body);
        callJsonApi("/trainingresult", body, "POST");
    }

    render() {
        return (
            <div>
                {this.state.exercises.map((e,index) =>
                    <div key={e.eId} style={styles.exercise}>
                        <b>{e.name}</b>
                        <br/>
                        <TextField
                            hintText="Rep count"
                            onChange={(event)=>this.handleChange("repCount", event, index)}
                            />
                        <br/>
                        <TextField
                            hintText="Weight"
                            onChange={(event)=>this.handleChange("weight", event, index)}
                            />
                        <br/>
                        <RaisedButton label="Add result" style={styles.button} onTouchTap={()=>this.addResult(index)}/>
                    </div>
                )}
            </div>
        )
    }
}
