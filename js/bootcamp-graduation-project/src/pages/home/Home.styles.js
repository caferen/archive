import styled from "styled-components";

export const ForegroundTrailer = styled.video`
  width: 70%;
  position: absolute;
  top: 50px;
  left: 15%;
  z-index: 1;
`;

export const BackgroundTrailer = styled.video`
  position: absolute;
  object-fit: cover;
  width: 100%;
  height: 100%;
  z-index: 0;
`;

export const Foreground = styled.div`
  position: fixed;
  width: 100%;
  height: 100%;
`;

export const Background = styled.div`
  position: fixed;
  top: 80px;
  left: 0;
  right: 0;
  bottom: 0;
  backdrop-filter: blur(8px);
`;

export const Title = styled.p`
  display: inline-block;
  color: white;
  position: relative;
  font-size: 9vh;
  margin: 0;
  z-index: 10;
  font-family: "JetBrains Mono", monospace;
`;

export const TitleContainer = styled.div`
  display: inline-block;
  position: fixed;
  width: 100%;
  z-index: 10;
  text-align: center;
`;

export const AdContainer = styled.div`
  display: inline-block;
  position: fixed;
  width: 100%;
  top: 25%;
  z-index: 10;
  text-align: center;
`;

export const Ad = styled.p`
  display: inline-block;
  margin: 0;
  color: white;
  position: relative;
  font-family: "JetBrains Mono", monospace;
  font-size: 2.5vh;
`;
