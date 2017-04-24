import React, { Component } from 'react';
import {callQueryParamsApi, callJsonApi} from "../util/callApi.js";
import Paper from 'material-ui/Paper';
import RaisedButton from 'material-ui/RaisedButton';
import TextField from 'material-ui/TextField';
import CreateTrainingDay from './CreateTrainingDay';
import { Link }from 'react-router';

let styles = {
    paper: {
        position: 'relative',
        margin: 50,
        textAlign: 'center',
        display: 'inline-block',
        padding: '40px 60px',
        width: 150,
        height: 150
    },
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
            days: []
        };
        this.programId = props.params.id;
        this.handleChange = this.handleChange.bind(this);
        this.addResult = this.addResult.bind(this);
    }

    componentWillMount() {
        callQueryParamsApi("/trainingday/program/"+this.programId, {})
            .then((data)=>{
                this.state.days = data;
                this.setState(this.state);
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
                {this.state.days.map((d,index) =>
                    <Link key={d.tdId} to={"/trainingday/"+d.tdId}>
                        <Paper zDepth={2} style={styles.paper}>
                            <div style={styles.name}>{d.name}</div>
                        </Paper>  
                    </Link>
                )}
                <CreateTrainingDay programId={this.programId}/>
            </div>
        )
    }
}
