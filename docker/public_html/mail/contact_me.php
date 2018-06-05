<?php
// Check for empty fields
if(empty($_POST['name'])  		||
   empty($_POST['email']) 		||
   empty($_POST['message'])	||
   !filter_var($_POST['email'],FILTER_VALIDATE_EMAIL))
   {
	echo "No arguments Provided!";
	return false;
   }
	
$name = $_POST['name'];
$prenom = $_POST['prenom'];
$email_address = $_POST['email'];
$tel = $_POST['tel'];
$adressefacturation = $_POST['adressefacturation'];
$adresselivraison = $_POST['adresselivraison'];
$same = $_POST['same'];
$number1 = $_POST['number1'];
$products1 = $_POST['products1'];
$taille1 = $_POST['taille1'];
$number2 = $_POST['number2'];
$products2 = $_POST['products2'];
$taille2 = $_POST['taille2'];
$number3 = $_POST['number3'];
$products3 = $_POST['products3'];
$taille3 = $_POST['taille3'];
$number4 = $_POST['number4'];
$products4 = $_POST['products4'];
$taille4 = $_POST['taille4'];
$message = $_POST['message'];

	
// Create the email and send the message
$to = 'info@36bougies.ch'; // Add your email address inbetween the '' replacing yourname@yourdomain.com - This is where the form will send a message to.
$email_subject = "Formulaire de commande du site:  $name  $prenom";
$email_body = "Vous avez reçu un nouveau message d'un client.\n\n"."Voici les details:\n\n
Nom: $name\n\n
Prénom: $prenom\n\n
Email: $email_address\n\n
Téléphone: $tel\n\n
Adresse de facturation:\n $adressefacturation\n\n
Adresse de livraison:\n $adresselivraison\n\n
Adresse de facturation et de livraison sont les mêmes : $same\n\n
\n\n
COMMANDE\n
$number1 $products1 $taille1\n\n
$number2 $products2 $taille2\n\n
$number3 $products3 $taille3\n\n
$number4 $products4 $taille4\n\n
Message : $message\n\n";
$headers = "From: noreply@36bougies.ch\n"; 
// This is the email address the generated message will be from. We recommend using something like noreply@yourdomain.com.
$headers .= "Reply-To: $email_address";	
mail($to,$email_subject,$email_body,$headers);
return true;			
?>