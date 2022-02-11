import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart';


class ErrorPage extends StatelessWidget {
  final String inputPage;
  final String inputError;
  const ErrorPage({Key? key, required this.inputPage, this.inputError=""}) : super(key: key);


  @override 
  Widget build(BuildContext context) {
    // Errors
    String getErrorText(String inputPage) {
      switch(inputPage) {
        case "Home":
          return "The selected feature is currently not available. \nRetry later or close and reopen the app. \n\nMore details\n---\n$inputError";
        case "Encode":
          return "Invalid input detected. \nTry removing uncommon chars or following the right input format. \n\nMore details\n---\n$inputError";
        case "Format":
          return "The selected algorithm needs a different input format. \nTry removing uncommon chars or following the right input format. \n\nMore details\n---\n$inputError";
        case "Encrypt":
          return "The selected algorithm needs a different input format or the given parameters are incorrect or incomplete. \nTry checking the input or changing the encryption/decryption details. \nIf using AES-256, make sure you're using a 16 or 32 chars long key/password \n\nMore details\n---\n$inputError";
        case "Export":
          return "The output format is not supported or the encryption/decryption process went wrong. \nTry checking the input format. \n\nMore details\n---\n$inputError";
        default:
          return "Unknown Error. \nTry repeating the process or reopening the app. \n\nMore details\n---\n$inputError";
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Alert Page",
        ),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: PageContainer(
            labelText: "Error", 
            borderColor: const Color(0xFFFF0000), //red
            container: Container(
              width: 290, 
              height: 510,
              child: Column(
                children: <Widget> [
                  const Padding(padding: EdgeInsets.only(top: 70)),
                  SubContainer(
                    labelText: inputPage,
                    height: 270,
                    container: Container(
                      width: 240, 
                      height: 295,
                      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                      child: Scrollbar(
                        child: SingleChildScrollView (
                          scrollDirection: Axis.vertical,
                          child: Text(
                            getErrorText(inputPage),
                            style: const TextStyle(
                              color: Color(0xFFFFBB55), //lightorange
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                    width: 15,
                  ),
                  //Closes the current page and shows the previous one
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "< Retry >",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6AD2FF),
                      ),
                    ),
                  ),
                  // Copies to the clipboard the error message
                  TextButton(
                      onPressed: () {Codify.copyToClipboard(getErrorText(inputPage));}, //Alert(message: 'I Forgor💀').show(); print("Help");
                      child: const Text(
                        "< Copy >",
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFFFFFF33),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}