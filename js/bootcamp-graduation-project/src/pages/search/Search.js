import React from "react";
import Navbar from "../../components/navbar/Navbar.js";
import { MainDiv, TitleContainer, Title } from "./Search.styles.js";
import SearchBox from "../../components/searchbox/SearchBox.js";

const Search = () => {
  return (
    <MainDiv>
      <Navbar />
      <TitleContainer>
        <Title>Search for a Summoner</Title>
      </TitleContainer>
      <SearchBox />
    </MainDiv>
  );
};

export default Search;
