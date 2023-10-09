import { useContext } from 'react';
import { IngredientsContext } from './Home.js';
import './Option.css';


const Option = (props) => {
    const ingredientAmount = useContext(IngredientsContext)[props.ingredient][0];
    const setIngredient = useContext(IngredientsContext)[props.ingredient][1];
    const INGREDIENT_UNIT_PRICES = {
        salad: 0.5,
        cheese: 0.4,
        meat: 1.3,
    };
    return (
        <div className="option">
            <p id="info">{props.ingredient} ($ {INGREDIENT_UNIT_PRICES[props.ingredient]}):</p>
            <button className="button" onClick={ingredientAmount > 0 ? () => setIngredient(ingredientAmount - 1) : null}>-</button>
            <p id="amount">{ingredientAmount}</p>
            <button className="button" onClick={() => setIngredient(ingredientAmount + 1)}>+</button>
            <p>Total Price: $ {(ingredientAmount * INGREDIENT_UNIT_PRICES[props.ingredient]).toFixed(2)}</p>
        </div>
    );
}

export default Option;