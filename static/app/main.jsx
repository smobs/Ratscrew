var $ = require('jquery');
var React = require('react');
var RatscrewWindow = require('./reactscrew.jsx');


var RatscrewApp = React.createClass({
    loadGameData: function () {
        $.ajax({
            url: this.props.gameUrl,
            dataType: 'json',
            success: function(data) {
                if (this.isMounted()){
                    this.setState(data);
                }
            }.bind(this),
            error: function(xhr, status, err){
                console.error(this.props.gameUrl, status, err.toString());
            }
        });
    },
    getInitialState: function(){
        return {}
    },
    componentDidMount: function(){
        this.loadGameData();
        var play = function (playerName){
            var url = this.props.playUrl + "/" + playerName
            $.ajax({
                url: url,
                dataType: 'json',
                success: function(data) {
                    this.loadGameData();
                }.bind(this),
                error: function(xhr, status, err){
                    console.error(url, status, err.toString());
                }
            }); 
        }.bind(this);
        global.playCard = play;
        
        var snap = function (playerName){
            var url = this.props.snapUrl + "/" + playerName
            $.ajax({
                url: url,
                dataType: 'json',
                success: function(data) {
                    this.loadGameData();
                }.bind(this),
                error: function(xhr, status, err){
                    console.error(url, status, err.toString());
                }
            }); 
        }.bind(this);
        global.attemptSnap = snap;
        

    },
    render: function(){
        return <RatscrewWindow gameData={this.state}/> 
    }
});

React.render(
    <RatscrewApp gameUrl="/gameState" playUrl="/playCard" snapUrl="/snap"/>,
    document.getElementById('example')
);
