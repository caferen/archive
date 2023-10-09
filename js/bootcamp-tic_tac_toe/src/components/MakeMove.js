import React from 'react';
import cross from '../assets/cross.png';
import circle from '../assets/circle.png';

function MakeMove(props) {
    if (props.status === 'circle') {
        return (
            <img src={circle} width="140" height="140" alt="circle" />
        );
    } else if (props.status === 'cross') {
        return (
            <img src={cross} alt="cross" />
        );
    } else {
        return null;
    }
}

export default MakeMove;