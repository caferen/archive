import styled from "styled-components";

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

export const Title = styled.p`
  display: inline-block;
  color: white;
  position: relative;
  font-size: 7vh;
  margin: 0;
  z-index: 10;
  font-family: "JetBrains Mono", monospace;
`;

export const TitleContainer = styled.div`
  display: inline-block;
  position: absolute;
  width: 100%;
  top: 10%;
  margin-top: 25px;
  z-index: 10;
  text-align: center;
`;

export const Container = styled.div`
  display: inline-block;
  position: fixed;
  left: 10%;
  width: 80%;
  top: ${(props) => props.top};
  z-index: 10;
  text-align: center;
`;

export const Paragraph = styled.p`
  display: inline-block;
  margin: 0;
  color: white;
  position: relative;
  font-family: "JetBrains Mono", monospace;
  font-size: 2vh;
`;

export const Background = styled.div`
  position: fixed;
  top: 80px;
  left: 0;
  right: 0;
  bottom: 0;
  backdrop-filter: blur(2px);
`;

export const GitHub = styled.a`
  display: inline-block;
  margin: 0;
  color: white;
  position: relative;
  font-family: "JetBrains Mono", monospace;
  font-size: 2vh;
`;
