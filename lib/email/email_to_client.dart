import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmailToNewClient(
    context, toText, ccText, name, password) async {
  try {
    // var userEmail = 'kyptronix@gmail.com';
    var userEmail = 'kyptronix.dev@gmail.com';
    var message = Message();

    // message.subject = subject.text;
    message.subject =
        ' Welcome to Kyptronix Care App - Your Project\'s Perfect Companion';
    // summary
    message.html = ' <p><b>Dear ${name.text},</b></p>'
        '<p>We trust this email finds you in the best of health. We sincerely appreciate your choice in partnering with Kyptronix LLP for your project. We are truly excited to have you on board and are committed to ensuring a seamless and enjoyable experience.</p>'
        //
        '<p>To commence your journey with the Kyptronix Care App, we are delighted to present you with your login credentials:</p>'
        //
        '<ul>'
        '<li>User name: ${toText.text}</li>'
        '<li>Password: ${password.text}</li>'
        '</ul>'
        //
        '<p>For your convenience, we\'ve provided links to download the Kyptronix Care App for both iOS and Android platforms:</p>'
        '<ul>'
        '<li> <a href="https://apps.apple.com/in/app/kyptronix-care/id6468647884">Download for iOS </a> </li>'
        '<li> <a href="https://play.google.com/store/apps/details?id=com.kyptronix.dev">Download for Android </a> </li>'
        '</ul>'
        //
        '<p>The Kyptronix Care App boasts an array of remarkable features that are designed to empower you throughout your project journey:</p>'
        '<p><b>Key Features:</p>'
        '<p>'
        '<ol>'
        '<li> <b>Real-time Project Tracking:</b> Keep a close eye on the status of your project at any time. </li>'
        '<li> <b>Progress Updates:</b> Stay in the loop with the latest developments in your project, ensuring you\'re always up to date. </li>'
        '<li> <b>Exclusive Offers and Promotions:</b> Discover our latest promotions and take advantage of exciting offers available only to our app users. </li>'
        '</ol>'
        '</p>'
        //
        '<p>We firmly believe that these features will greatly enhance your interaction with our products and services, making your experience with Kyptronix exceptional.</p>'
        //
        '<p>If you have any questions, face any challenges during the login process, or need assistance with any aspect of the app, please do not hesitate to reach out to our dedicated support team at <a href="mailto:kyptronix.dev@gmail.com">kyptronix.dev@gmail.com</a> or call our helpline at +1 (213) 900 9305. Our friendly support agents are eager to assist you promptly.</p>'
        //
        '<p>Once again, we extend our sincere gratitude for choosing Kyptronix. We are eagerly looking forward to the opportunity to serve you and provide top-notch support through our Kyptronix Care App.</p>'
        '<p>Warm regards,</p>'
        '<p>Kyptronix LLP Customer Support Team</p>'
        '<p> <a href="https://play.google.com/store/apps/details?id=com.kyptronix.dev">Download for Android </a>| <a href="https://apps.apple.com/in/app/kyptronix-care/id6468647884">Download for iOS </a> </p>';
    //

    // !!!!!!!!!!!!!!!!!!
    // '<p>Link: <a href="https://play.google.com/store/apps/details?id=com.kyptronix.dev">Kyptronix Care</a></p>'
    // '<p>User name: ${toText.text}</p>'
    // '<p>Password: Kyptronix2023</p>'
    // ' <p>This will help us keep track of the progress on each project and ensure that all assigned tasks are duly accounted for.</p>'
    // ' <p>Whether you\'re working remotely or at the office, please make it a habit to log in to the application and update your tasks regularly. By doing so, we can collaborate more effectively, identify potential bottlenecks, and address any challenges that may arise promptly.</p>'
    // ' <p>If you encounter any technical difficulties or have questions about using the mobile application, feel free to reach out to our support team for assistance. They are available to help you navigate through the system and ensure a smooth experience.</p>'
    // ' <p>Let\'s make the most of this tool to enhance our productivity and deliver exceptional results. Thank you for your cooperation, and have a productive day!</p>'
    // '<br>'
    // ' <br>'
    // '<p>Best regards,</p>'
    // '<p>Support Team</p>'
    // '<p>Kyptronix LLP</p>';

    // message.html = body.text;

    message.from = Address(userEmail.toString(), 'Kyptronix LLP');

    // receipents
    List<String> emails = toText.text.split(',');
    List<Address> recipients = [];
    for (String email in emails) {
      recipients.add(Address(email.trim()));
    }
    message.recipients = recipients;

    // cc receipents
    // List<String> ccEmails = ccText.split(',');
    // List<Address> ccRecipient = [];
    // for (String ccEmail in ccEmails) {
    //   recipients.add(Address(ccEmail.trim()));
    // }
    // message.ccRecipients = ccRecipient;

    // var smtpServer = gmail(userEmail, 'cnasttaokkyfzsug');
    var smtpServer = gmail(userEmail, 'wiyrzbnywenvpfpv');
    send(message, smtpServer);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: const Text(
          'Email sent',
          style: TextStyle(
            fontFamily: 'fontTwo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade400,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(
            fontFamily: 'fontTwo',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
