import 'package:flutter/material.dart';
// import 'package:alert/alert.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_codify/main.dart';
import 'package:flutter_codify/pages/formatter.dart';
import 'package:flutter_codify/pages/exporter.dart';
import 'package:flutter_codify/pages/encrypter.dart';
import 'dart:convert';


class EncodePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final bool isEncode;
  bool? isAES = false;
  String? decodeType;
  String title = "Encode";
  String mainButtonText = "Next";
  EncodePage({Key? key, required this.isEncode, this.isAES, this.decodeType}) : super(key: key);

  //========== <SPERIMENTAL> ==========

  decBase64(String text) {
    return utf8.decode((base64.decode(text)));
  }

  String decBin(String text) { //Iterable<String>?
    //Adjustes commas
    text = text.replaceAll(",", ""); text = text.replaceAll(";", "");
    //Adjustes braces
    text = text.replaceAll("(", ""); text = text.replaceAll(")", "");
    //Adjustes square braces
    text = text.replaceAll("[", ""); text = text.replaceAll("]", "");
    //Adjustes curly braces
    text = text.replaceAll("{", ""); text = text.replaceAll("}", "");
    //Adjustes spaces
    text = text.replaceAll("  ", " "); text = text.replaceAll("-", " ");
    //Converts from Binary to Text
    return String.fromCharCodes(text.split(" ").map((v) => int.parse(v, radix: 2)));
  }

  decriptionManager(String? decType, text) {
    if (text != null) {
        switch(decType) {
        case "base64":
          return decBase64(text);
        case "bin":
          return decBin(text).toString();
        default:
          // Alert(message: 'Choose a valid decryption type').show();
          break;
      }
    }
  }

    //========== </SPERIMENTAL> ==========

  @override 
  Widget build(BuildContext context) {
    void showNextPage(bool isEncode) {
      if (isEncode) {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => FormatPage(isEncode: isEncode, plainText: _controller.text,)), //FormatPage(isEncode: false,)
        );
      } else {
        if (isAES == false) {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => ExportPage(inputText: decriptionManager(decodeType, _controller.text))),
          );
        } else {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => EncryptPage(isEncode: isEncode, plainText: _controller.text,)),
          );
        }
      }
    }
    if (!isEncode) {
      title = "Decode";
      mainButtonText = "Confirm";
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          title,
        ),
        // leading: const BackButton(),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            child: PageContainer(
              labelText: title, 
              container: Container(
                width: 290, 
                height: 510,
                child: Column(
                  children: <Widget> [
                    const Padding(padding: EdgeInsets.only(top: 70)),
                    SubContainer(
                      labelText: "Plain-Text",
                      container: Container(
                        width: 240, 
                        height: 250,
                        
                        child: TextField(
                          cursorWidth: 10,
                          cursorRadius: const Radius.circular(0),
                          cursorColor: const Color(0xFFd2d8d8),
                          maxLines: null,
                          expands: true,
                          controller: _controller,
                          decoration: const InputDecoration(
                            prefixText: "# ",
                            hintText: "Text here...",
                            contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 45), //.all(15)
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Color(0xFFe3eaea)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 45,
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () {print("Next"); print(_controller.text); showNextPage(isEncode);},
                      child: Text(
                        "< $mainButtonText >",
                        style: const TextStyle(
                          fontSize: 25,
                          color: Color(0xFF6AD2FF),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {}, //Alert(message: 'I Forgor💀').show(); print("Help");
                      child: const Text(
                        "< ? Help >",
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
      ),
    );
  }
}