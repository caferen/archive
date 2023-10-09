import React from 'react';
import Popup from 'reactjs-popup';
import './styles/Popup.css';


function WinnerPopup(props) {
    return (<Popup
        trigger={props.trigger}
        modal
        nested
        id="popup"
    >
        {close => (
            <div className="modal">
                <button className="close" onClick={close}>
                    &times;
                </button>
                <div className="header"> We have a winner! </div>
                <div className="content">
                    {`Winner is ${props.winner}`}
                </div>
            </div>
        )}
    </Popup>)
}

export default WinnerPopup;