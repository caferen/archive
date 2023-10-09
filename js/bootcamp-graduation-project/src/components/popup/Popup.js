import React from "react";
import mastery4 from "../../assets/mastery_icons/level_4.png";
import mastery5 from "../../assets/mastery_icons/level_5.png";
import mastery6 from "../../assets/mastery_icons/level_6.png";
import mastery7 from "../../assets/mastery_icons/level_7.png";
import damageIcon from "../../assets/attack_icon.png";
import kdaIcon from "../../assets/kda_icon.png";
import visionIcon from "../../assets/vision_icon.png";
import {
  Background,
  Popup,
  Contents,
  Title,
  Name,
  Blurb,
  BlurbContainer,
  More,
  Details,
  Detail,
  DetailText,
  DetailIcon,
} from "./Popup.styles.js";

const PopupContents = (props) => {
  const data = props.data;

  return (
    <Popup>
      <Background img={`data:image/jpeg;base64,${props.splash}`} />
      <Contents>
        <img
          src={`data:image/jpeg;base64,${props.splash}`}
          alt="splash art"
          width={"65%"}
        />
        <Title>{data.title}</Title>
        <Name>{data.name}</Name>
        <Details>
          <Detail>
            <DetailIcon
              src={
                data.championLevel === 5
                  ? mastery5
                  : data.championLevel === 6
                  ? mastery6
                  : data.championLevel === 7
                  ? mastery7
                  : mastery4
              }
              width={"100%"}
            />
            <DetailText>{data.championPoints}</DetailText>
          </Detail>
          <Detail>
            <DetailIcon
              src={`/role_icons/${data.role.toLowerCase()}_icon.png`}
              width={"100%"}
            />
            <DetailText>{data.role}</DetailText>
          </Detail>
          <Detail>
            <DetailIcon src={damageIcon} width={"80%"} />
            <DetailText>
              {(data.totalDamage / data.frequency).toFixed(0)}
            </DetailText>
          </Detail>
          <Detail>
            <DetailIcon src={kdaIcon} width={"80%"} color="white" />
            <DetailText>{(data.kda / data.frequency).toFixed(2)}</DetailText>
          </Detail>
          <Detail>
            <DetailIcon src={visionIcon} width={"90%"} />
            <DetailText>
              {(data.visionScore / data.frequency).toFixed(0)}
            </DetailText>
          </Detail>
        </Details>
      </Contents>
      <BlurbContainer>
        <Blurb>
          {data.blurb}
          <More
            href={`https://na.leagueoflegends.com/en-us/champions/${data.name.toLowerCase()}/`}
            target="_blank"
          >
            &nbsp;Learn more here
          </More>
        </Blurb>
      </BlurbContainer>
    </Popup>
  );
};

export default PopupContents;
