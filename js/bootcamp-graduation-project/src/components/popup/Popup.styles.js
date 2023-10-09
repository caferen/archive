import styled from "styled-components";

export const Background = styled.div`
  background-image: url("${(props) => props.img}");
  position: fixed;
  top: 10%;
  left: 15%;
  background-size: cover;
  filter: blur(5px);
  -webkit-filter: blur(5px);
  height: 80%;
  width: 70%;
  z-index: 0;
  text-align: center;
  animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
  -webkit-animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
`;

export const Popup = styled.div`
  text-align: center;
  z-index: 2;
`;

export const Contents = styled.div`
  position: fixed;
  width: 70%;
  height: 80%;
  top: 13%;
  left: 15%;
  animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
  -webkit-animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
`;

export const Title = styled.p`
  color: white;
  position: relative;
  font-size: 3vh;
  margin: 0;
  top: -27%;
  font-family: "JetBrains Mono", monospace;
  font-family: "Quicksand", sans-serif;
`;

export const Name = styled.p`
  color: white;
  font-size: 9vh;
  margin: 0;
  position: relative;
  top: -30%;
  font-family: "Quicksand", sans-serif;
  -webkit-transform: sscale(1.5, 1); /* Safari and Chrome */
  -moz-transform: scale(1.5, 1); /* Firefox */
  -ms-transform: scale(1.5, 1); /* IE 9 */
  -o-transform: scale(1.5, 1); /* Opera */
  transform: scale(1.5, 1); /* W3C */
`;

export const Blurb = styled.p`
  color: white;
  position: relative;
  font-size: 2vh;
  margin: 0;
  font-family: "JetBrains Mono", monospace;
  font-family: "Quicksand", sans-serif;
  animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
  -webkit-animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
`;

export const BlurbContainer = styled.div`
  width: 60%;
  position: fixed;
  left: 20%;
  bottom: 14%;
`;

export const More = styled.a`
  color: white;
  font-size: 2vh;
  margin: 0;
  font-family: "JetBrains Mono", monospace;
  font-family: "Quicksand", sans-serif;
  text-decoration: None;
`;

export const Details = styled.div`
  position: relative;
  text-align: center;
  width: 100%;
  height: 20%;
  top: -28%;
  background-color: rgba(0, 0, 0, 0.6);
  animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
  -webkit-animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
`;

export const Detail = styled.div`
  position: relative;
  display: inline-block;
  text-align: center;
  width: 7%;
  margin-left: 3%;
  margin-right: 3%;
  animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
  -webkit-animation: anvil 0.3s cubic-bezier(0.38, 0.1, 0.36, 0.9) forwards;
`;

export const DetailText = styled.p`
  color: white;
  display: inline-block;
  font-family: "JetBrains Mono", monospace;
  font-family: "Quicksand", sans-serif;
  margin: 0;
  position: relative;
  font-size: 100%;
`;

export const DetailIcon = styled.img`
  display: inline-block;
  position: relative;
`;
