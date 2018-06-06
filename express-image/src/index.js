var Chance = require('chance');
var chance = new Chance()

var express = require('express');
var app = express();

app.get('/', function(req,res) {
	res.send(generateAvatars());
});

app.listen(3000, function() {
	console.log("Accepting HTTP requests on port 3000.")
});

function generateAvatars() {
	var nbOfA = chance.integer(
		{
			min: 3, max: 10
		}
	);
	var avatars = [];
	for(var i = 0; i < nbOfA; i++){
		avatars.push(
		{
			mail: chance.email(),
			profession: chance.profession()
			//avatar_url: chance.avatar({email: email})
		});
	};
	return avatars;
}
