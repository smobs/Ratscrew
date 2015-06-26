var React = require('react');

var RatscrewWindow = React.createClass({
    render: function() {
        return <div>Hello winner {this.props.gameData.gameWinner} </div>;
    }
});

module.exports = RatscrewWindow