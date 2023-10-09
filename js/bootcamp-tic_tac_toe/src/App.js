import GameTable from './components/GameTable.js';
import './App.css';
import React from 'react';

function App() {
  return (
    <div id="main">
      <h1>Tic Tac Toe</h1>
      <div id="app">{GameTable()}</div>
    </div>
  );
}

export default App;
