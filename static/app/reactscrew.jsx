var React = require('react');
var _ = require('underscore');



var TopCard = React.createClass({
    render: function() {
        if (this.props.card){
            return <p> The top card is the {this.props.card.rank} of {this.props.card.suit}.</p>
        }
        else {
            return <p> Currently no top card. </p>
        }
    }
});
var CurrentState = React.createClass({
    render: function() {
        return (
            <div>
              <p>Current player is {this.props.currentPlayer}.</p>
              <p> The count is {this.props.currentCount}.</p>
              <TopCard card={this.props.topCard}/>
              <p>There are {this.props.stackSize} cards in the stack.</p>
            </div>
        );
    }
});


var PlayCardButton = React.createClass({
    handleClick: function(){
        global.playCard(this.props.playerName)
    },
    render: function(){
        return  <button onClick={this.handleClick}>Play Card.</button>
    }
});
var SnapButton = React.createClass({
    handleClick: function(){
        global.attemptSnap(this.props.playerName)
    },
    render: function(){
         return <button onClick={this.handleClick}>Snap</button>
    }
});

var PlayerState = React.createClass({
    
    render: function() {
        return (
            <div>
            <p>Player {this.props.playerState.name} has {this.props.playerState.cards} cards left</p>
            <PlayCardButton playerName={this.props.playerState.name}/>
            <SnapButton playerName={this.props.playerState.name}/>
            </div>
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
