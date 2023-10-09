import React, { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import Card from "../../components/card/Card.js";
import Navbar from "../../components/navbar/Navbar.js";
import DotLoader from "react-spinners/DotLoader";
import Search from "../search/Search.js";
import Dropdown from "../../components/dropdown/Dropdown.js";
import {
  Loader,
  LoaderPosition,
  Favorites,
  TitleContainer,
} from "./Results.styles.js";

const Results = () => {
  const [data, setData] = useState({ favorites: {}, summonerDetails: {} });
  const [loading, setLoading] = useState(true);
  let summoner = "";
  const location = useLocation();
  try {
    summoner = location.state.params;
  } catch (err) {
    console.log(err);
  }

  useEffect(() => {
    (async () => {
      let res = await fetch(
        "http://localhost:5000/",
        {
          method: "POST",
          body: JSON.stringify({ "summonerName": summoner }),
          headers: { 'Content-Type': 'application/json' }
        }
      )
      let data = await res.json()
      setData(data);
      setLoading(false);
    })();
  }, []);

  return summoner.length > 0 ? (
    <div style={{ overflow: "hidden" }}>
      <Navbar />
      <Loader>
        <LoaderPosition loading={loading.toString()}>
          <DotLoader color={"white"} size={250} loading={loading} />
        </LoaderPosition>
      </Loader>
      <Favorites>
        <TitleContainer loading={loading.toString()}>
          Favorite Champions of{" "}
          {<Dropdown summoner={summoner} data={data.summonerDetails} />}
        </TitleContainer>
        <div style={{ overflow: "scroll", height: "75vh" }}>
          {Object.entries(data.favorites).map((favorite) => (
            <Card key={favorite[1].title} data={favorite[1]} />
          ))}
        </div>
      </Favorites>
    </div>
  ) : (
    <Search />
  );
};

export default Results;
