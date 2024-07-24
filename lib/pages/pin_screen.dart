import 'package:flutter/material.dart';
import 'package:na9ex_app/service/login_activity.dart';

class PinEntryScreen extends StatefulWidget {
  final String mode;

  const PinEntryScreen(this.mode, {super.key});


  @override
  PinEntryScreenState createState() => PinEntryScreenState();
}

class PinEntryScreenState extends State<PinEntryScreen> {
  final List<TextEditingController> _pinControllers = List<TextEditingController>.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List<FocusNode>.generate(4, (index) => FocusNode());
  final List<int> pin = <int>[];
  final LoginActivity loginActivity = LoginActivity();
  @override
  void initState() {
    super.initState();

    // Request focus on the first TextField when the page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }


  void _onKeyPressed(String key) {
    for (int i = 0; i < 4; i++) {
      if (_pinControllers[i].text.isEmpty) {
        if(widget.mode =="Enter"){
          _pinControllers[i].text = "*";
        }else{
          _pinControllers[i].text = key;
        }
        pin.add(int.parse(key));
        if (i < 3) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }else if(widget.mode == "Enter"){
          loginActivity.pinAction(context, pin.join(),widget.mode);
        }
        break;
      }
    }
  }

  void _onDeletePressed() {
    for (int i = 3; i >= 0; i--) {
      if (_pinControllers[i].text.isNotEmpty) {
        pin.removeLast();
        _pinControllers[i].clear();
        FocusScope.of(context).requestFocus(_focusNodes[i]);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('ENTER PIN'),
        // backgroundColor: const Color(0xFF074173),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              'NA9EX',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF074173),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Please ${widget.mode} PIN',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF074173),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(4, (index) => _buildPinBox(_pinControllers[index], _focusNodes[index])),
            ),
            const SizedBox(height: 40),
            _buildCustomKeyboard(),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String enteredPin = pin.join();
                  loginActivity.pinAction(context, enteredPin,widget.mode);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF074173)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Color(0xFF074173))),
                  shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if(widget.mode == "Enter")
              TextButton(
                onPressed: () {
                  loginActivity.forgotPin(context);
                },
                child: const Text(
                  'Forgot PIN?',
                  style: TextStyle(
                    color: Color(0xFF074173),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinBox(TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: true, // Prevent the system keyboard from appearing
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Color(0xFF074173), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Color(0xFF074173), width: 1),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF074173),
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.0, // Adjust this value to reduce height
      children: <Widget>[
        ...List<Widget>.generate(9, (index) {
          return _buildKeyboardButton((index + 1).toString());
        }),
        _buildKeyboardButton(''),
        _buildKeyboardButton('0'),
        _buildKeyboardButton(Icons.backspace, isIcon: true),
      ],
    );
  }

  Widget _buildKeyboardButton(dynamic value, {bool isIcon = false}) {
    return SizedBox(
      height: 50, // Adjust the height of the button
      child: TextButton(
        onPressed: () {
          if (isIcon) {
            _onDeletePressed();
          } else {
            _onKeyPressed(value);
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero, // Remove padding to make button more compact
        ),
        child: isIcon
            ? Icon(value, size: 24, color: const Color(0xFF074173)) // Adjust icon size and color
            : Text(
          value,
          style: const TextStyle(fontSize: 24, color: Color(0xFF074173)), // Adjust text size and color
        ),
      ),
    );
  }


}
