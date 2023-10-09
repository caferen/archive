import React, { useContext } from 'react';
import { TwitterTweetEmbed } from 'react-twitter-embed';
import { Drawer } from 'rsuite';
import { AppContext } from '../App.js';
import 'rsuite/dist/styles/rsuite-default.css';


const TweetDrawer = (props) => {
    const open = useContext(AppContext)['open'][0];
    const setOpen = useContext(AppContext)['open'][1];

    return <Drawer
        placement='right'
        show={open}
        backdrop={true}
        onHide={() => setOpen(false)}
    >
        <Drawer.Header>Most Popular Tweets</Drawer.Header>
        <Drawer.Body>
            {props.favorites.map(favorite => <TwitterTweetEmbed tweetId={favorite} key={favorite} />)}
        </Drawer.Body>
    </Drawer>
}

export default TweetDrawer;