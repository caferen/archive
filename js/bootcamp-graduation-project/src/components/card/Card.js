import React, { useState, useEffect } from "react";
import PopupContents from "../popup/Popup.js";
import axios from "axios";
import { StyledCard, Favorite, AnimatedPopup } from "./Card.styles.js";

const Card = (props) => {
  const data = props.data;
  const [splash, setSplash] = useState("");
  useEffect(() => {
    (async () => {
      await axios
        .get(
          `http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${data.name}_0.jpg`,
          { responseType: "arraybuffer" }
        )
        .then((response) => {
          const base64 = btoa(
            new Uint8Array(response.data).reduce(
              (data, byte) => data + String.fromCharCode(byte),
              ""
            )
          );
          return base64;
        })
        .then((splash) => setSplash(splash));
    })();
  }, []);

  return (
    <Favorite>
      <AnimatedPopup
        trigger={
          <StyledCard>
            <img
              src={`data:image/jpeg;base64,${splash}`}
              alt="resim"
              width={"100%"}
            />
            <h3 style={{ margin: 10 }}>{data.name}</h3>
          </StyledCard>
        }
        modal
      >
        <PopupContents data={data} splash={splash} />
      </AnimatedPopup>
    </Favorite>
  );
};

export default Card;
