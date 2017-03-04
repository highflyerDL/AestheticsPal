import React, { Component } from 'react';
import {callQueryParamsApi, callJsonApi} from "../util/callApi.js";
import Paper from 'material-ui/Paper';
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
    name: {
        textTransform: 'uppercase',
        fontWeight: 'bold',
        position: 'absolute',
        top: '10px',
        left: '10px'
    },
    desc: {
        position: 'absolute',
        left: '10px'
    }
}

export default class TrainingDayList extends Component {
    constructor(props) {
        super(props);
        this.state = {
            days: []
        };
    }

    componentWillMount() {
        callQueryParamsApi("/trainingdays", {})
            .then((data)=>{
                this.setState({days: data});
            })
    }

    render() {
        return (
            <div>
                {this.state.days.map((day)=> 
                    <Link to={"/trainingdays/"+day.pId}>
                        <Paper key={day.tdId} zDepth={2} style={styles.paper}>
                            <div style={styles.name}>{day.name}</div>
                        </Paper>  
                    </Link>
                )}
            </div>
        )
    }
}
