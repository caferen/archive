import React, { useState, useEffect } from "react";
import { useHistory } from "react-router-dom";
import { Box } from "./SearchBox.styles.js";

const SearchBox = () => {
  const [summoner, setSummoner] = useState("");
  const history = useHistory();

  useEffect(() => {
    const listener = (event) => {
      if (
        (event.code === "Enter" || event.code === "NumpadEnter") &&
        summoner.length > 0
      ) {
        history.push("/result", { params: summoner });
      }
    };
    document.addEventListener("keydown", listener);
    return () => document.removeEventListener("keydown", listener);
  }, [summoner]);

  return (
    <Box
      value={summoner}
      onChange={(e) => setSummoner(e.target.value)}
      placeholder="Summoner Name"
    />
  );
};

export default SearchBox;
