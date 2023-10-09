import styled from "styled-components";

export const DropdownBody = styled.div`
  display: inline-block;
`;

export const DropdownContents = styled.div`
  position: fixed;
  z-index: 100;
  background-color: rgba(256, 256, 256, 0.8);
  height: 25%;
  width: 100%;
  left: 0;
  display: flex;
  justify-content: space-around;
  align-items: center;
`;

export const DropdownItem = styled.div`
  width: 25%;
  margin: 25px;
`;

export const DropdownItemIcon = styled.img`
  display: inline-block;
`;

export const DropdownItemText = styled.p`
  font-size: 75%;
  margin: 0;
  color: #111111;
`;

export const DropdownTrigger = styled.div`
  text-decoration: underline;
`;
