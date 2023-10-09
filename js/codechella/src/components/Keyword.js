import styled from 'styled-components';

const Keyword = styled.h3`
    color: #E1E8ED;
    font-size: 24px;
    font-family: 'Times New Roman', Times, serif;
    font-weight: 400;
    display: inline-block;
    text-align: center;
    margin: 0;
    width: 20%;
`

const Keywords = (props) => {
    return (
        <div className="favorites">
            {props.words.map((word) => props.words.indexOf(word) < 5 ? <Keyword key={props.words.indexOf(word)}>{word['text']}</Keyword> : null)}
        </div>
    );
}

export default Keywords;