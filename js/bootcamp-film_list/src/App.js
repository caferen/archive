import React from "react";
import "./App.css";
import MovieGrid from "./movie.js";
import movies from "./movies";


function App() {
  return (
    <div className="container">
      <h1 id="name">Film Listesi</h1>
      <div id="grid-view">
        <div className="column-name">
          <p id="blank">hufeu</p>
          <h4>Name</h4>
          <h4>Category</h4>
        </div>
        {movies.map((movie) => MovieGrid(movie))}
      </div>
    </div>
  );
}

export default App;
