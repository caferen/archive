import React from 'react';
import Ingredient from './Ingredient.js';
import Navbar from './Navbar.js';
import './OrderComplete.css';

const OrderComplete = (props) => {

    const salads = props.location.query[0];
    const cheeses = props.location.query[1];
    const meats = props.location.query[2];

    return (
        <div>
            <Navbar></Navbar>
            <div className="burger">
                <Ingredient type="bread-top"></Ingredient>
                {cheeses.map((cheese) => <Ingredient type="cheese" key={cheese}></Ingredient>)}
                {salads.map((salad) => <Ingredient type="salad" key={salad}></Ingredient>)}
                {meats.map((meat) => <Ingredient type="meat" key={meat}></Ingredient>)}
                <Ingredient type="bread-bottom"></Ingredient>
            </div>
            <h1>Order completed. Thank you!</h1>
        </div>
    );
}

export default OrderComplete;