import React, { useState, useEffect } from "react";
import './styles/GameTable.css';
import MakeMove from './MakeMove.js';
import WinnerPopup from './Popup.js';


function GameTable() {
    const [turn, setTurn] = useState(true);
    const [gameStatus, setGameStatus] = useState('on');
    const [topLeft, setTopLeft] = useState('empty');
    const [centerLeft, setCenterLeft] = useState('empty');
    const [bottomLeft, setBottomLeft] = useState('empty');
    const [topRight, setTopRight] = useState('empty');
    const [centerRight, setCenterRight] = useState('empty');
    const [bottomRight, setBottomRight] = useState('empty');
    const [topCenter, setTopCenter] = useState('empty');
    const [center, setCenter] = useState('empty');
    const [bottomCenter, setBottomCenter] = useState('empty');

    useEffect(() => {
        if (gameStatus === 'off') {
            return;
        }
        if (topLeft === center && center === bottomRight && center !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (topRight === center && center === bottomLeft && center !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (topLeft === topCenter && topCenter === topRight && topCenter !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (centerLeft === center && center === centerRight && center !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (bottomLeft === bottomCenter && bottomCenter === bottomRight && bottomCenter !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (topLeft === centerLeft && centerLeft === bottomLeft && centerLeft !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (topCenter === center && center === bottomCenter && center !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        } else if (topRight === centerRight && centerRight === bottomRight && centerRight !== 'empty') {
            setGameStatus('off');
            document.getElementById('trigger-button').click();
        }
        setTurn(!turn);
    }, [topLeft, topRight, topCenter, centerLeft, centerRight, center, bottomRight, bottomLeft, bottomCenter]);

    function play(position, positionValue) {
        if (positionValue === 'empty' && gameStatus === 'on') {
            switch (position) {
                case 'top-left':
                    setTopLeft(turn ? 'circle' : 'cross');
                    break;
                case 'center-left':
                    setCenterLeft(turn ? 'circle' : 'cross');
                    break;
                case 'bottom-left':
                    setBottomLeft(turn ? 'circle' : 'cross');
                    break;
                case 'top-right':
                    setTopRight(turn ? 'circle' : 'cross');
                    break;
                case 'center-right':
                    setCenterRight(turn ? 'circle' : 'cross');
                    break;
                case 'bottom-right':
                    setBottomRight(turn ? 'circle' : 'cross');
                    break;
                case 'top-center':
                    setTopCenter(turn ? 'circle' : 'cross');
                    break;
                case 'center':
                    setCenter(turn ? 'circle' : 'cross');
                    break;
                case 'bottom-center':
                    setBottomCenter(turn ? 'circle' : 'cross');
                    break;
                default:
                    break;
            }
        }
    }


    return (
        <div id="main-container">
            <div id="top-left" onClick={() => play('top-left', topLeft)}><MakeMove status={topLeft}></MakeMove></div>
            <div id="center-left" onClick={() => play('center-left', centerLeft)}><MakeMove status={centerLeft}></MakeMove></div>
            <div id="bottom-left" onClick={() => play('bottom-left', bottomLeft)}><MakeMove status={bottomLeft}></MakeMove></div>
            <div id="top-right" onClick={() => play('top-right', topRight)}><MakeMove status={topRight}></MakeMove></div>
            <div id="center-right" onClick={() => play('center-right', centerRight)}><MakeMove status={centerRight}></MakeMove></div>
            <div id="bottom-right" onClick={() => play('bottom-right', bottomRight)}><MakeMove status={bottomRight}></MakeMove></div>
            <div id="top-center" onClick={() => play('top-center', topCenter)}><MakeMove status={topCenter}></MakeMove></div>
            <div id="center" onClick={() => play('center', center)}><MakeMove status={center}></MakeMove></div>
            <div id="bottom-center" onClick={() => play('bottom-center', bottomCenter)}><MakeMove status={bottomCenter}></MakeMove></div>
            <WinnerPopup winner={turn ? 'cross' : 'circle'} trigger={<button id="trigger-button"></button>}></WinnerPopup>
        </div>
    );
}

export default GameTable;