import 'package:flutter/material.dart';
import 'package:na9ex_app/service/create_ticket.dart';

import '../../components/AdminNavBar.dart';

class TicketForm extends StatefulWidget {
  const TicketForm({super.key});

  @override
  TicketFormState createState() => TicketFormState();
}

class TicketFormState extends State<TicketForm> {
  final _formKey = GlobalKey<FormState>();
  int maleCount = 0;
  int femaleCount = 0;
  int pickupPointId = 0;
  int dropPointId = 0;
  int customerId = 0;
  String toWhere = 'COL->JAF';
  DateTime selectedDate = DateTime.now();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController pickupPointController = TextEditingController();
  final TextEditingController dropPointController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController =
      TextEditingController(text: DateTime.now().toString().split(' ')[0]);
  int currentPageIndex = 0;

  bool isError = false;

  CreateTicketActivity createTicketActivity = CreateTicketActivity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'NA9EX',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF074173)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mobile Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      } else if (value.length != 10 ||
                          !RegExp(r'^[0-9]*$').hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: toWhere,
                          items: <String>['COL->JAF', 'JAF->COL']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              toWhere = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'To Where',
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Use width instead of height
                      Expanded(
                        child: TextFormField(
                          controller: dateController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date',
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(
                                FocusNode()); // to prevent opening default keyboard
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2015, 8),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                                dateController.text =
                                    selectedDate.toString().split(' ')[0];
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Male Count'),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        isError = false;
                                        setState(() {
                                          if (maleCount > 0) maleCount--;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: Center(
                                      child: Text('$maleCount'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        isError = false;
                                        setState(() {
                                          maleCount++;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Use width instead of height (20 is the default padding value in Material Design guidelines)
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Female Count'),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        isError = false;
                                        setState(() {
                                          if (femaleCount > 0) femaleCount--;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: Center(
                                      child: Text('$femaleCount'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: isError
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        isError = false;
                                        setState(() {
                                          femaleCount++;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: pickupPointController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Pickup Point',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: dropPointController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Drop Point',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.6, // 60% of screen width
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (maleCount + femaleCount == 0) {
                            isError = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please select at least one passenger'),
                              ),
                            );
                          } else {
                            isError = false;
                          }
                        });

                        if (_formKey.currentState!.validate()) {
                          createTicketActivity.createTicket(
                              context,
                              mobileNumberController.text,
                              customerNameController.text,
                              dateController.text,
                              toWhere,
                              maleCount,
                              femaleCount,
                              pickupPointId,
                              pickupPointController.text,
                              dropPointId,
                              dropPointController.text,
                              descriptionController.text,
                              customerId);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF074173)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(color: Color(0xFF074173))),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                      ),
                      child: const Text(
                        'Add Ticket',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AdminNavBar(
        currentPageIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
