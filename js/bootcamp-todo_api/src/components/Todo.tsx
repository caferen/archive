import React, { useContext } from 'react';
import { TodoContext } from '../App';
import Checkbox from '@material-ui/core/Checkbox';
import './Todo.css';

const Todo = (props: {
    todo: {
        id: number,
        title: string,
        isDone: boolean,
        user: string,
    }, deleteKey: number
}) => {
    const flip: boolean = useContext(TodoContext)['flip'][0];
    const setFlip = useContext(TodoContext)['flip'][1];
    const isDone: boolean = useContext(TodoContext)['isDone'][0];
    const setIsDone = useContext(TodoContext)['isDone'][1];

    const deleteTodo = async () => {
        await fetch(`https://5fa97367c9b4e90016e6a7ec.mockapi.io/api/todos/${props.deleteKey}`, {
            method: "DELETE",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(props.todo),
        }).then(() => setFlip(!flip));
    }

    const switchDone = async () => {
        await fetch(`https://5fa97367c9b4e90016e6a7ec.mockapi.io/api/todos/${props.deleteKey}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                id: props.todo.id,
                title: props.todo.title,
                isDone: !props.todo.isDone,
                user: props.todo.user,
            }),
        }).then(() => setIsDone(!isDone))
    }

    return (
        <div className="todo">
            <div> </div>
            <Checkbox checked={props.todo.isDone} onClick={switchDone}></Checkbox>
            <p>{props.todo.title}</p>
            <button onClick={deleteTodo}>x</button>
        </div>
    );
}

export default Todo;