var React = require('react');
var _ = require('underscore');

var CurrentState = React.createClass({
    render: function() {
        return (
            <div>
              <p>Current player is {this.props.currentPlayer}.</p>
              <p> The count is {this.props.currentCount}.</p>
              <p> The top card is the {this.props.topCard.rank} of {this.props.topCard.suit}.</p>
              <p>There are {this.props.stackSize} cards in the stack.</p>
            </div>
        );
    }
});

var PlayerState = React.createClass({
    render: function() {
        return (
            <p>Player {this.props.playerState.name} has {this.props.playerState.cards} cards left</p>            
        );
    }
});

var RatscrewWindow = React.createClass({
    render: function() {
        var playerStates = _.map(this.props.gameData.players, function(playerData) {
            return(
            <PlayerState playerState={playerData}/>
            );
        });
        var wonGame = <p>Hello winner {this.props.gameData.gameWinner} </p>
        var inProgressGame = (
            <div>
            <CurrentState currentPlayer={this.props.gameData.currentPlayer}
              topCard={this.props.gameData.topCard}
              stackSize={this.props.gameData.stackSize}
              currentCount={this.props.gameData.currentCount}
            />
            {playerStates}
            </div>
        );
        return inProgressGame;
}
});

module.exports = RatscrewWindow


var data = {
    gameWinner : "Toby",
    topCard : {
        suit : "Spades",
        rank : "Queen"
    },
    currentCount : 2,
    stackSize : 1,
    players : [],
    currentPlayer : "Toby",
    playLog : []
};
