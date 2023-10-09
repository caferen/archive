import React from "react";
import Navbar from "../../components/navbar/Navbar.js";
import {
  BackgroundTrailer,
  Foreground,
  Title,
  TitleContainer,
  Container,
  Paragraph,
  Background,
  GitHub,
} from "./About.styles.js";

const About = () => {
  return (
    <div>
      <Navbar />
      <div style={{ paddingTop: "80px" }}>
        <TitleContainer>
          <Title>About Summoner Stalker</Title>
        </TitleContainer>
        <Container top="32%">
          <Paragraph>
            Summoner Stalker is a tool to help you analyze the favorite
            champions of League of Legends players.
          </Paragraph>
        </Container>
        <Container top="52%">
          <Paragraph>
            It is built with React, Node, AWS Lambda, and Riot Games API.
          </Paragraph>
        </Container>
        <Container top="62%">
        </Container>
        <Container top="72%">
          <Paragraph>
            If you're not getting any results, that's because the API key had
            expired. Contact me in that case.
          </Paragraph>
        </Container>
        <Foreground>
          <BackgroundTrailer autoPlay muted loop>
            <source src="https://lolstatic-a.akamaihd.net/frontpage/apps/prod/harbinger-l10-website/en-us/production/en-us/static/what-is-league-of-legends-7371486f4c8b54e87c27b26983151db2.webm" />
          </BackgroundTrailer>
        </Foreground>
        <Background />
      </div>
    </div>
  );
};

export default About;
