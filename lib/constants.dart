import 'package:flutter/material.dart';
import 'package:na9ex_app/service/api_client.dart';
import 'package:na9ex_app/service/ticket_service.dart';

const String BASE_URL = 'http://192.168.8.138:8080/api/v1';
int USER_ID = 0;

String SUCCESS ="SUCCESS";
String WARNING = "WARNING";

Future<bool?> showCustomAlert(BuildContext context, String heading, String msg, String type) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          heading,
          style: TextStyle(
            color: type == 'error' ? Colors.red :
            type == 'warning' ? Colors.orange :
            type == 'success' ? Colors.green :
            Colors.black, // default color
          ),
        ),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

void showSuccessDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.green),
        ),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


showConformationDialog(BuildContext context, String title, String msg, int id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(color: Colors.orange),
        ),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: const Text('Confirm'),
            onPressed: () async {
              Navigator.of(context).pop();
              // await Future.delayed(Duration(milliseconds: 500)); // Add a delay
              TicketService().onClickUpdateStatus(context, id, 1);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () async {
              Navigator.of(context).pop();
              // await Future.delayed(Duration(milliseconds: 500)); // Add a delay
              TicketService().onClickedDelete(context, id);
            },
          ),
        ],
      );
    },
  );
}