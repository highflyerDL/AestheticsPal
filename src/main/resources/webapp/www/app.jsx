import React, { Component } from 'react'
import { Router, Route, Link, IndexRedirect, browserHistory } from 'react-router';
import Main from "./components/Main";
import Chart from "./components/Chart";
import ProgramList from "./components/ProgramList";
import Program from "./components/Program";
import CreateProgram from "./components/CreateProgram";
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

class App extends Component {
  render() {
    return (
      <MuiThemeProvider>
        <Router history={browserHistory}>
          <Route path="/" component={Main} >
            <IndexRedirect to="/program" />
            <Route path="/program/create" component={CreateProgram}/>
            <Route path="/program" component={ProgramList}/>
            <Route path="/program/:id" component={Program}/>
            <Route path='*' component={NotFound} />
          </Route>
        </Router>
      </MuiThemeProvider>
    )
  }
}

const NotFound = () => (
  <h1>404.. This page is not found!</h1>)

export default App;