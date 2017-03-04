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

export default class ProgramList extends Component {
    constructor(props) {
        super(props);
        this.state = {
            programs: []
        };
    }

    componentWillMount() {
        callQueryParamsApi("/program", {})
            .then((data)=>{
                this.setState({programs: data});
            })
    }

    render() {
        return (
            <div>
                {this.state.programs.map((program)=> 
                    <Link to={"/program/"+program.pId}>
                        <Paper key={program.pId} zDepth={2} style={styles.paper}>
                            <div style={styles.name}>{program.name}</div>
                            <div style={styles.desc}>{program.description}</div>
                        </Paper>  
                    </Link>
                )}
            </div>
        )
    }
}
