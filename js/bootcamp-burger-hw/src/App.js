import React from 'react';
import Home from './components/Home.js';
import Error from './components/Error.js';
import { Route, Switch } from 'react-router-dom';
import OrderComplete from './components/OrderComplete.js';

const App = () => {
  return (
    <Switch>
      <Route path="/" component={Home} exact></Route>
      <Route path="/complete" render={(props) => (<OrderComplete {...props}></OrderComplete>)}></Route>
      <Route component={Error}></Route>
    </Switch>
  );
};

export default App;
