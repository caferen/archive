import React, { useState, useEffect, createContext } from 'react';
import { Link } from 'react-router-dom';
import Ingredient from './Ingredient.js';
import Option from './Option.js';
import Navbar from './Navbar.js';
import './Home.css';

export const IngredientsContext = createContext();

const Home = () => {

    const [salad, setSalad] = useState(0);
    const [cheese, setCheese] = useState(0);
    const [meat, setMeat] = useState(0);
    const [salads, setSalads] = useState(Array(0));
    const [cheeses, setCheeses] = useState(Array(0));
    const [meats, setMeats] = useState(Array(0));

    useEffect(() => {
        setSalads([...Array(salad).keys()].map(i => i + 1));
        setCheeses([...Array(cheese).keys()].map(i => i + 1));
        setMeats([...Array(meat).keys()].map(i => i + 1));
    }, [salad, meat, cheese])

    return (
        <IngredientsContext.Provider value={{ salad: [salad, setSalad, salads], cheese: [cheese, setCheese, cheeses], meat: [meat, setMeat, meats] }}>
            <div id="edit-page">
                <Navbar></Navbar>
                <div className="burger">
                    <Ingredient type="bread-top"></Ingredient>
                    {salad || cheese || meat ? null : <h2>Please start addind ingredients!</h2>}
                    {cheeses.map((cheese) => <Ingredient type="cheese" key={cheese}></Ingredient>)}
                    {salads.map((salad) => <Ingredient type="salad" key={salad}></Ingredient>)}
                    {meats.map((meat) => <Ingredient type="meat" key={meat}></Ingredient>)}
                    <Ingredient type="bread-bottom"></Ingredient>
                </div>
                <div id="options">
                    <h3>Current price: $ {(4 + 0.5 * salad + 0.4 * cheese + 1.3 * meat).toFixed(2)}</h3>
                    <Option ingredient="salad"></Option>
                    <Option ingredient="cheese"></Option>
                    <Option ingredient="meat"></Option>
                    {salad || cheese || meat ? <Link to={{ pathname: '/complete', query: [salads, cheeses, meats] }} >ORDER</Link> : null}
                </div>
            </div>
        </IngredientsContext.Provider>
    );
}

export default Home;