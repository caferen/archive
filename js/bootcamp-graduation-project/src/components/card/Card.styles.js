import styled from "styled-components";
import Popup from "reactjs-popup";

export const StyledCard = styled.div`
  text-align: center;
  border: 3px solid;
  border-color: white;
  margin-bottom: 10%;
  background-color: white;
  box-shadow: 0 10px 16px 0 rgba(255, 255, 255, 0.2),
    0 6px 20px 0 rgba(255, 255, 255, 0.19);
  opacity: 0.6;
  transition: 0.5s;
  &:hover {
    opacity: 1;
    cursor: pointer;
  }
`;

export const Favorite = styled.div`
  display: inline-block;
  width: 25vw;
  margin: 0 25px 0 25px;
`;

export const AnimatedPopup = styled(Popup)`
  animation-name: anvil;
  @keyframes anvil {
    0% {
      transform: scale(1) translateY(0px);
      opacity: 0;
      box-shadow: 0 0 0 rgba(241, 241, 241, 0);
    }
    1% {
      transform: scale(0.96) translateY(10px);
      opacity: 0;
      box-shadow: 0 0 0 rgba(241, 241, 241, 0);
    }
    100% {
      transform: scale(1) translateY(0px);
      opacity: 1;
      box-shadow: 0 0 500px rgba(241, 241, 241, 0);
    }
  }
`;
