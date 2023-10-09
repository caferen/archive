import React, { useContext } from 'react';
import HashtagInput from './HashtagInput.js';
import Tooltip from "@material-ui/core/Tooltip";
import { AppContext } from '../App.js';

const Searchbox = () => {
    const hashtag = useContext(AppContext)['hashtag'][0];
    const setHashtag = useContext(AppContext)['hashtag'][1];
    const open = useContext(AppContext)['open'][0];
    const setOpen = useContext(AppContext)['open'][1];
    const status = useContext(AppContext)['status'][0];

    return <div className="search-box">
        <Tooltip
            id="tooltip"
            title="Enter a hashtag and press enter to search!"
            placement='top'
            arrow
        >
            <HashtagInput value={hashtag} onChange={(e) => setHashtag(e.target.value)} placeholder="Hashtag"></HashtagInput>
        </Tooltip>
        {status ? <button className="see-tweets" onClick={() => setOpen(!open)}>See Tweets</button> : null}
    </div>
}

export default Searchbox;