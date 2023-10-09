import React from "react";
import Navbar from "../../components/navbar/Navbar.js";

const Error = () => {
  return (
    <div>
      <Navbar />
      <div
        style={{
          width: "100%",
          height: "30%",
          position: "fixed",
          top: "35%",
          textAlign: "center",
        }}
      >
        <h1>Page not found!</h1>
      </div>
    </div>
  );
};

export default Error;
