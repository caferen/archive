import React, { useState } from "react";
import Top from "../../assets/position_icons/position_top.png";
import Mid from "../../assets/position_icons/position_mid.png";
import Bot from "../../assets/position_icons/position_bot.png";
import Support from "../../assets/position_icons/position_support.png";
import Jungle from "../../assets/position_icons/position_jungle.png";
import Mastery from "../../assets/mastery.png";
import {
  DropdownBody,
  DropdownContents,
  DropdownItem,
  DropdownItemIcon,
  DropdownItemText,
  DropdownTrigger,
} from "./Dropdown.styles.js";

const Dropdown = (props) => {
  const [isVisible, setIsVisible] = useState(false);

  return Object.keys(props.data).length !== 0 ? (
    <DropdownBody>
      <DropdownTrigger
        onMouseEnter={() => setIsVisible(true)}
        onMouseLeave={() => setIsVisible(false)}
      >
        {props.summoner}
      </DropdownTrigger>
      {isVisible && (
        <DropdownContents>
          <DropdownItem>
            <DropdownItemIcon
              src={`http://ddragon.leagueoflegends.com/cdn/10.25.1/img/profileicon/${props.data.icon}.png`}
              width={"60%"}
            />
            <DropdownItemText>{props.data.level}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Mastery} width={"60%"} />
            <DropdownItemText>{props.data.mastery}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Top} width={"50%"} />
            <DropdownItemText>{props.data.lanes.TOP}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Mid} width={"50%"} />
            <DropdownItemText>{props.data.lanes.MID}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Jungle} width={"50%"} />
            <DropdownItemText>{props.data.lanes.JUNGLE}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Support} width={"50%"} />
            <DropdownItemText>{props.data.lanes.NONE}</DropdownItemText>
          </DropdownItem>
          <DropdownItem>
            <DropdownItemIcon src={Bot} width={"50%"} />
            <DropdownItemText>{props.data.lanes.BOTTOM}</DropdownItemText>
          </DropdownItem>
        </DropdownContents>
      )}
    </DropdownBody>
  ) : null;
};

export default Dropdown;
