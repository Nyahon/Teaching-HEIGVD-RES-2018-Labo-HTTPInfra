$(function() {

    $("input,textarea").jqBootstrapValidation({
        preventSubmit: true,
        submitError: function($form, event, errors) {
            // additional error messages or events
        },
        submitSuccess: function($form, event) {
            event.preventDefault(); // prevent default submit behaviour
            // get values from FORM
            var name = $("input#name").val();
            var email = $("input#email").val();
            var message = $("textarea#message").val();
            var tel = $("input#tel").val();
            var adresselivraison = $("textarea#adresselivraison").val();
            var adressefacturation = $("textarea#adressefacturation").val();
            var checkbox1 = $("input#checkbox1").val();
            var number1 = $("select#number1").val();
            var number2 = $("select#number2").val();
            var number3 = $("select#number3").val();
            var number4 = $("select#number4").val();
            var products1 = $("select#products1").val();
            var products2 = $("select#products2").val();
            var products3 = $("select#products3").val();
            var products4 = $("select#products4").val();
            var taille1 = $("select#taille1").val();
            var taille2 = $("select#taille2").val();
            var taille3 = $("select#taille3").val();
            var taille4 = $("select#taille4").val();
            var firstName = name; // For Success/Failure Message
            // Check for white space in name for Success/Fail message
            if (firstName.indexOf(' ') >= 0) {
                firstName = name.split(' ').slice(0, -1).join(' ');
            }
            $.ajax({
                url: "././mail/contact_me.php",
                type: "POST",
                data: {
                    name: name,
                    email: email,
                    message: message,
                    tel: tel,
                    adresselivraison:adresselivraison,
                    adressefacturation:adressefacturation,
                    checkbox1:checkbox1,
                    number1:number1,
                    number2:number2,
                    number3:number3,
                    number4:number4,
                    products1:products1,
                    products2:products2,
                    products3:products3,
                    products4:products4,
                    taille1:taille1,
                    taille2:taille2,
                    taille3:taille3,
                    taille4:taille4
                    
                    
                },
                cache: false,
                success: function() {
                    // Success message
                    $('#success').html("<div class='alert alert-success'>");
                    $('#success > .alert-success').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                        .append("</button>");
                    $('#success > .alert-success')
                        .append("<strong>Votre message a bien été envoyé. </strong>");
                    $('#success > .alert-success')
                        .append('</div>');

                    //clear all fields
                    $('#contactForm').trigger("reset");
                },
                error: function() {
                    // Fail message
                    $('#success').html("<div class='alert alert-danger'>");
                    $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                        .append("</button>");
                    $('#success > .alert-danger').append("<strong>Sorry " + firstName + ", Il semble que le serveur mail ne réponde pas. Veuillez essayer plus tard !");
                    $('#success > .alert-danger').append('</div>');
                    //clear all fields
                    $('#contactForm').trigger("reset");
                },
            })
        },
        filter: function() {
            return $(this).is(":visible");
        },
    });

    $("a[data-toggle=\"tab\"]").click(function(e) {
        e.preventDefault();
        $(this).tab("show");
    });
});


/*When clicking on Full hide fail/success boxes */
$('#name').focus(function() {
    $('#success').html('');
});
