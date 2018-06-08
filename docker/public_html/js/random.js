$(function(){
        console.log("Loading random");
        function loadRandom(){
                $.getJSON("/api/random/", function(random){
                        console.log(random);
                        var message = "Nobody is here";
                        if(random.length > 0){
                                message = random[0].mail + ", " + random[0].profession;
                        }
                        // Getting an element of page and replacing it
                        $(".skills").text(message);
                });
        };
        loadRandom();
        setInterval(loadRandom, 2000);
});
