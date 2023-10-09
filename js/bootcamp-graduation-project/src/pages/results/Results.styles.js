import styled from "styled-components";

export const Loader = styled.div`
  position: fixed;
  background-image: linear-gradient(rgba(17, 17, 17, 1), rgba(17, 17, 60, 1));
  height: 100%;
  width: 100%;
`;

export const LoaderPosition = styled.div`
  visibility: ${(props) => (props.loading === "true" ? "visible" : "hidden")};
  height: 20%;
  width: 20%;
  position: fixed;
  top: 40%;
  left: 40%;
`;

export const Favorites = styled.div`
  text-align: center;
  width: 100%;
  padding-top: 80px;
`;

export const TitleContainer = styled.div`
  width: 100%;
  text-align: center;
  position: relative;
  top: 0;
  margin-top: 10px;
  margin-bottom: 40px;
  color: white;
  font-size: 5vh;
  font-family: "JetBrains Mono", monospace;
  visibility: ${(props) => (props.loading === "false" ? "visible" : "hidden")};
`;
