import React from "react";
import Error from "./pages/404/404.js";
import Results from "./pages/results/Results.js";
import Home from "./pages/home/Home.js";
import Search from "./pages/search/Search.js";
import About from "./pages/about/About.js";
import { Route, Switch } from "react-router-dom";

function App() {
  return (
    <Switch>
      <Route path="/" component={Home} exact></Route>
      <Route path="/search" component={Search} exact></Route>
      <Route path="/about" component={About} exact></Route>
      <Route path="/result" component={Results}></Route>
      <Route component={Error}></Route>
    </Switch>
  );
}

export default App;
