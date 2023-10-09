import React, { useState, useEffect, createContext } from "react";
import "./App.css";
import AddTodo from "./components/AddTodo";
import Todo from "./components/Todo";

export const TodoContext = createContext<any>({});

function App() {
  const [todoList, setTodoList] = useState<Array<any>>([]);
  const [flip, setFlip] = useState(false);
  const [isDone, setIsDone] = useState(false);
  const [finished, setFinished] = useState(0);

  useEffect(() => {
    (async () => {
      await fetch('https://5fa97367c9b4e90016e6a7ec.mockapi.io/api/todos', { method: 'GET' }).then((response) => {
        if (response.status === 200 || response.status === 201) {
          response.json().then((parsedJson) => {
            setTodoList([...parsedJson].filter((todo) => todo.user === 'user'));
            setFinished([...parsedJson].filter((todo) => todo.user === 'user' && todo.isDone).length);
          });
        } else {
          console.log(response);
        }
      });
    })();
  }, [flip, isDone]);

  return (
    <div className="App">
      <TodoContext.Provider value={{ flip: [flip, setFlip], isDone: [isDone, setIsDone] }}>
        <h2>You have {finished} finished, {todoList.length - finished} unfinished, and {todoList.length} total tasks</h2>
        {todoList.map((todo, index) => (<Todo todo={todo} deleteKey={todo.id} key={index}></Todo>))}
        <AddTodo></AddTodo>
      </TodoContext.Provider>
    </div>
  );
}

export default App;
