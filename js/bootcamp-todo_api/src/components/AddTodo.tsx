import React, { useState, useContext } from 'react';
import { TodoContext } from '../App';
import './AddTodo.css';


const AddTodo = () => {
    const [title, setTitle] = useState<string>('');
    const flip: boolean = useContext(TodoContext)['flip'][0];
    const setFlip = useContext(TodoContext)['flip'][1];

    const addTodo = async () => {
        await fetch('https://5fa97367c9b4e90016e6a7ec.mockapi.io/api/todos', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                isDone: false,
                title: title,
                user: 'user',
            }),
        }).then(() => setFlip(!flip)).then(() => setTitle(''));
    }

    return (
        <div className="addTodo">
            <input value={title} onChange={event => setTitle(event.target.value)}></input>
            <button onClick={addTodo}>Add</button>
        </div>
    )
}

export default AddTodo;