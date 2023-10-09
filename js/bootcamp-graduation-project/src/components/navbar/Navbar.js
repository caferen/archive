import React from "react";
import { Navigation, Goto, Underline } from "./Navbar.styles.js";

const Navbar = () => {
  return (
    <Navigation>
      <div style={{ display: "inline-block", width: 100 }}></div>
      <Underline>
        <Goto to="/">Home</Goto>
      </Underline>
      <Underline>
        <Goto to="/search">Search</Goto>
      </Underline>
      <Underline>
        <Goto to="/about">About</Goto>
      </Underline>
    </Navigation>
  );
};

export default Navbar;
