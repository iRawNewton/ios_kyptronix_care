import 'package:ios_kyptronix_care/broadcast/model/emailmodel.dart';
import 'package:ios_kyptronix_care/broadcast/notification_func.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constant/string_file.dart';
import '../screens/dashboard/admin/admindash.dart';

var tempUrl = AppUrl.hostingerUrl;

class SendBroadcast extends StatefulWidget {
  const SendBroadcast({super.key});

  @override
  State<SendBroadcast> createState() => _SendBroadcastState();
}

class _SendBroadcastState extends State<SendBroadcast> {
  List<bool> isChecked = [false];
  List<ClientEmail> clientEmail = [];
  bool isLoading = true;
  Future<List<ClientEmail>?>? _emailListFuture;
  List<String> clientNotificationId = [];
  bool enableButton = false;
  Color color = Colors.grey;
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  // Color color = const Color(0xff28a745);

  Future<List<ClientEmail>?> getEmailList() async {
    String baseUrl = '$tempUrl/notification/blast_notification.php';
    final http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<ClientEmail> emailList = clientEmailFromJson(response.body);

      setState(() {
        clientEmail = emailList;
        isChecked = List<bool>.generate(clientEmail.length, (index) => false);
        isLoading = false;
      });
    }
    return clientEmail;
  }

  bool checkAll = false;

  // Function to toggle the state of all checkboxes
  void toggleCheckAll() {
    setState(() {
      checkAll = !checkAll;
      if (checkAll != false) {
        setState(() {
          color = const Color(0xff28a745);
          enableButton = true;
        });
      } else {
        color = Colors.grey;
        enableButton = false;
      }
      for (int i = 0; i < isChecked.length; i++) {
        isChecked[i] = checkAll;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailListFuture = getEmailList(); // Initialize the future in initState
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade50,
          centerTitle: true,
          title: const Text(
            'Send Broadcast',
            style: TextStyle(
              fontFamily: 'fontOne',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: title,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Notification Title',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: content,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Notification content',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Select Users to send broadcast message',
                  style: TextStyle(
                      fontFamily: 'fontOne',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Background color
                      borderRadius:
                          BorderRadius.circular(20), // Container border radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100, // Light shadow color
                          offset:
                              const Offset(-10, -10), // Light shadow position
                          blurRadius: 10, // Light shadow blur radius
                        ),
                        BoxShadow(
                          color: Colors.grey.shade300, // Dark shadow color
                          offset: const Offset(10, 10), // Dark shadow position
                          blurRadius: 10, // Dark shadow blur radius
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: toggleCheckAll,
                          child: Row(
                            children: [
                              Checkbox(
                                value: checkAll,
                                onChanged: (value) {
                                  setState(() {
                                    checkAll = !checkAll;
                                    toggleCheckAll();
                                  });
                                },
                              ),
                              Text(checkAll ? 'Uncheck All' : 'Check All')
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: _emailListFuture,
                          builder: (context, snapshot) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: clientEmail.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Checkbox(
                                      value: isChecked[index],
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked[index] = value!;
                                          if (isChecked[index] == true) {
                                            if (clientEmail[index].deviceId !=
                                                'waiting for login') {
                                              clientNotificationId.add(
                                                  clientEmail[index].deviceId);
                                              // =============
                                              if (clientNotificationId
                                                  .isNotEmpty) {
                                                setState(() {
                                                  color =
                                                      const Color(0xff28a745);
                                                  enableButton = true;
                                                });
                                              } else {
                                                color = Colors.grey;
                                                enableButton = false;
                                              }
                                              // =============
                                            }
                                          } else {
                                            clientNotificationId.remove(
                                                clientEmail[index].deviceId);
                                            // =============
                                            if (clientNotificationId
                                                .isNotEmpty) {
                                              setState(() {
                                                color = const Color(0xff28a745);
                                                enableButton = true;
                                              });
                                            } else {
                                              color = Colors.grey;
                                              enableButton = false;
                                            }
                                            // =============
                                          }
                                        });
                                      },
                                    ),
                                    title: Text(
                                      clientEmail[index].emailId,
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: SizedBox(
            height: 40.0,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
              ),
              onPressed: enableButton
                  ? () {
                      sendBroadcastNotification(context, title.text.trim(),
                          content.text.trim(), clientNotificationId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          showCloseIcon: true,
                          closeIconColor: Colors.white,
                          content: const Text(
                            'Notification sent',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyAdminDash()));
                    }
                  : null,
              child: const Text(
                'Proceed',
                style: TextStyle(
                  fontFamily: 'fontOne',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

// scaffold k upar

