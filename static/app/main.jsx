var React = require('react');
var RatscrewWindow = require('./reactscrew.jsx');

var data = {
    gameWinner : "Toby",
    topCard : {
        suit : "Spades",
        rank : "Queen"
    },
    currentCount : 2,
    stackSize : 1,
    players : [
        {name: "Toby", cards: 20},
        {name: "Mike", cards: 11}
    ],
    currentPlayer : "Toby",
    playLog : []
};

React.render(
     <RatscrewWindow gameData={data}/>,
    document.getElementById('example')
);
