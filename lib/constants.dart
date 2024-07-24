import 'package:flutter/material.dart';
import 'package:na9ex_app/pages/admin/admin_home.dart';
import 'package:na9ex_app/service/ticket_service.dart';
import 'package:quickalert/quickalert.dart';

// const String BASE_URL = 'http://192.168.1.27:8080/api/v1';
const String BASE_URL = 'http://192.168.8.138:8080/api/v1';
int USER_ID = 0;

String SUCCESS ="SUCCESS";
String WARNING = "WARNING";

const int OK = 200;
const int NOT_FOUND = 404;
const int BAD_REQUEST = 400;



Future<bool?> showCustomAlert(BuildContext context, String heading, String msg, String type) async {
  QuickAlertType alertType;

  switch (type) {
    case 'error':
      alertType = QuickAlertType.error;
      break;
    case 'warning':
      alertType = QuickAlertType.warning;
      break;
    case 'success':
      alertType = QuickAlertType.success;
      break;
    default:
      alertType = QuickAlertType.info;
  }

  var result = await QuickAlert.show(
    context: context,
    type: alertType,
    text: msg,
    title: heading,
    confirmBtnText: 'OK',
    confirmBtnColor: const Color(0xFF074173),
    onConfirmBtnTap: () {
      Navigator.of(context).pop(true);
    },
  );

  if (result is bool) {
    return result;
  } else {
    return null;
  }
}


showConformationDialog(BuildContext context_, String title, String msg, int id) {
  showDialog(
    context: context_,
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
              TicketService().onClickUpdateStatus(context_, id, 1);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async {
              Navigator.of(context).pop();
              // await Future.delayed(Duration(milliseconds: 500)); // Add a delay
              TicketService().onClickedDelete(context_, id);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AdminHomePage()),
              );
            },
          ),
        ],
      );
    },
  );
}


void showLoading(BuildContext context) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: 'Loading',
    text: 'Fetching your data',
  );
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}