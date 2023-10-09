import styled from "styled-components";
import { Link } from "react-router-dom";

export const Navigation = styled.div`
  background-color: #111111;
  height: 80px;
  width: 100%;
  box-sizing: border-box;
  position: fixed;
  z-index: 100;
`;

export const Goto = styled(Link)`
  color: white;
  font-size: 24px;
  text-decoration: None;
  padding-top: 22px;
  margin-left: 50px;
  margin-right: 50px;
  display: inline-block;
  height: 80px;
  vertical-align: middle;
  font-family: "JetBrains Mono", monospace;
`;

export const Underline = styled.div`
  display: inline-block;
  height: 77px;
  border-bottom: 3px solid transparent;
  &:hover {
    border-bottom: 3px solid white;
  }
  z-index: 100;
`;
