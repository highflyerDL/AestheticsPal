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

export default class TrainingDay extends Component {
    constructor(props) {
        super(props);
        this.state = {
            day: null,
            exercises: [],
            results: [],
            selectedDay: null
        };
        this.daySet = [];
        this.dayId = props.params.id;
        this.handleChange = this.handleChange.bind(this);
        this.handleSelectChange = this.handleSelectChange.bind(this);
        this.addResult = this.addResult.bind(this);
    }

    componentWillMount() {
        callQueryParamsApi("/trainingday/"+this.dayId, {})
            .then((data)=>{
                this.state.day = data;
                var idList = data[0].exercises.map(eId => "id="+eId+"&");
                idList = idList.toString().replace(/,/g, "")

                callQueryParamsApi("/programexercise?" + idList, {})
                    .then((data)=>{
                        this.state.exercises = data;

                        callQueryParamsApi("/trainingresult/"+this.dayId, {})
                            .then((data)=>{
                                this.state.results = data;
                                this.state.results.map(result=> {
                                    this.state.exercises.map(e=>{ 
                                        if(e.eId == result.eId){
                                            result.eName = e.name;
                                        }
                                    });
                                    if(this.daySet.indexOf(result.trainedOn) == -1){
                                        this.daySet.push(result.trainedOn);
                                    }
                                })
                                this.daySet.sort();
                                this.daySet.reverse();
                                this.state.selectedDay = this.daySet[0];
                                
                                this.setState(this.state);
                            })
                    })
            });
    }    

    handleChange(type, event, eIndex) {
        this.state.exercises[eIndex][type] = event.target.value;
    }

    addResult(eIndex){
        let body = {
            tdId: parseInt(this.dayId),
            eId: this.state.exercises[eIndex].eId,
            repCount: parseInt(this.state.exercises[eIndex].repCount),
            weight: parseInt(this.state.exercises[eIndex].weight)
        }
        console.log(body);
        callJsonApi("/trainingresult", body, "POST");
    }

    handleSelectChange(event){
        this.setState({selectedDay:event.target.value});
    }

    render() {
        return (
            <div>
                <select onChange={this.handleSelectChange}>
                    {this.daySet.map((d,i)=><option key={i} value={d}>{d}</option>)}
                </select>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Rep count</th>
                            <th>Weight</th>

                        </tr>
                    </thead>
                    <tbody>
                    {this.state.results.map((r,index)=> {
                            if(r.trainedOn === this.state.selectedDay){
                                return <tr key={r.trId}>
                                    <td>{r.eName}</td>
                                    <td>{r.repCount}</td>
                                    <td>{r.weight}</td>
                                </tr>;
                            }
                        }

                    )}
                    </tbody>
                </table>
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
