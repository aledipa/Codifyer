import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart';


class ManualPage extends StatelessWidget {
  final String inputPage;
  const ManualPage({Key? key, required this.inputPage}) : super(key: key);


  @override 
  Widget build(BuildContext context) {
    // Manuals
    String getInfoText(String inputPage) {
      switch(inputPage) {
        case "Home":
          return "In the Home page you can open the Encription page by clicking “Encrypt” and the decription one by clicking “Decript”";
        case "Encode":
          return "In the Encode/Decode page you can write your plain text if you want to encode it and the cipher text if you want to decode it";
        case "Format":
          return "In the Format page you can choose the encryption/decription format or algorithm that you want to use";
        case "Encrypt":
          return "In the Encrypt/Decrypt page you can define the parameters needed to complete the encription or decription of the selected format. \n[!] The AES-256 encryption's key/password must be 16 or 32 chars long";
        case "Export":
          return "In the Export page you can read the encoded or decoded text and copy it on the clipboard by clicking on “Save”";
        default:
          return "Where did you found this one? Honestly, I don't know yet how to help you with this";
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Codifyer Manual",
        ),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: PageContainer(
            labelText: "Guide",
            borderColor: const Color(0xFFFFFF33), //Yellow
            container: Container(
              width: 290, 
              height: 510,
              child: Column(
                children: <Widget> [
                  const Padding(padding: EdgeInsets.only(top: 70)),
                  SubContainer(
                    labelText: inputPage,
                    height: 300,
                    container: Container(
                      width: 240, 
                      height: 325,
                      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                      child: Scrollbar(
                        child: SingleChildScrollView (
                          scrollDirection: Axis.vertical,
                          child: Text(
                            getInfoText(inputPage),
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
                    onPressed: () {Navigator.pop(context);},
                    child: const Text(
                      "< OK >",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6AD2FF), //lightblue
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