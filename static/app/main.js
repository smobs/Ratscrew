var React = require('react');
var RatscrewWindow = require('./reactscrew.jsx');

var data = {
    gameWinner : "Toby",
    topCard : {
        Suit : "Spades",
        Rank : "Queen"
    },
    currentCount : 2,
    stackSize : 1,
    players : [],
    currentPlayer : "Toby",
    playLog : []
}

React.render(
     <RatscrewWindow gameData={data}/>,
    document.getElementById('example')
);