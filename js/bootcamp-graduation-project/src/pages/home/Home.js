import React from "react";
import Navbar from "../../components/navbar/Navbar.js";
import {
  ForegroundTrailer,
  BackgroundTrailer,
  Foreground,
  Background,
  Title,
  TitleContainer,
  AdContainer,
  Ad,
} from "./Home.styles.js";

const Home = () => {
  return (
    <div>
      <Navbar />
      <div style={{ paddingTop: "80px" }}>
        <TitleContainer>
          <Title>Summoner Stalker</Title>
        </TitleContainer>
        <AdContainer>
          <Ad>
            Find out the favorite League of Legend champions of your friends!
          </Ad>
        </AdContainer>
        <Foreground>
          <ForegroundTrailer autoPlay muted loop>
            <source src="https://lolstatic-a.akamaihd.net/frontpage/apps/prod/harbinger-l10-website/en-us/production/en-us/static/hero-0632cbf2872c5cc0dffa93d2ae8a29e8.webm" />
          </ForegroundTrailer>
          <BackgroundTrailer autoPlay muted loop>
            <source src="https://lolstatic-a.akamaihd.net/frontpage/apps/prod/harbinger-l10-website/en-us/production/en-us/static/hero-0632cbf2872c5cc0dffa93d2ae8a29e8.webm" />
          </BackgroundTrailer>
          <Background />
        </Foreground>
      </div>
    </div>
  );
};

export default Home;
