import React, { useState, useEffect, createContext } from 'react';
import Searchbox from './components/Searchbox.js';
import Wordcloud from './components/Wordcloud.js';
import Drawer from './components/Drawer.js';
import './App.css';
import Keywords from './components/Keyword.js';

export const AppContext = createContext();

const App = () => {
    const [hashtag, setHashtag] = useState("#");
    const [open, setOpen] = useState(false);
    const [status, setstatus] = useState(false);
    const [words, setWords] = useState([]);
    const [favorites, setFavorites] = useState([]);

    useEffect(() => {
        const listener = event => {
            if ((event.code === "Enter" || event.code === "NumpadEnter") && hashtag.length > 1) {
                setstatus(true);
                fetch('/tweets', {
                    method: 'POST', headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ 'search': hashtag })
                }).then(res => res.json()).then(data => {
                    setWords(data['words']);
                    setFavorites(data['favorites'])
                });
            }
        };
        document.addEventListener("keydown", listener);
        return () => document.removeEventListener("keydown", listener);
    }, [hashtag]);

    return (
        <div className="App">
            <AppContext.Provider value={{ 'hashtag': [hashtag, setHashtag], 'open': [open, setOpen], 'status': [status, setstatus] }}>
                <Searchbox></Searchbox>
                <Keywords words={words}></Keywords>
                <Wordcloud status={status} words={words}></Wordcloud>
                <Drawer favorites={favorites}></Drawer>
            </AppContext.Provider>
        </div>
    );
}

export default App;