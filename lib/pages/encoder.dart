import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart';
import 'package:flutter_codify/pages/formatter.dart';
import 'package:flutter_codify/pages/exporter.dart';
import 'package:flutter_codify/pages/encrypter.dart';
import 'package:hex/hex.dart';
import 'dart:convert';


class EncodePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final bool isEncode;
  bool? isAES = false;
  String? decodeType;
  String title = "Encode";
  String mainButtonText = "Next";
  String subTitleText = "Plain-Text";
  EncodePage({Key? key, required this.isEncode, this.isAES, this.decodeType}) : super(key: key);


  // Decodes Hexadecimal to String
  decHex(String text) {
    return String.fromCharCodes((HEX.decode(text)));
    // return utf8.decode((HEX.decode(text))); //OLD VERSION, It doesn't support accents
  }

  // Decodes Base64 to String
  decBase64(String text) {
    return utf8.decode((base64.decode(text)));
  }

  // Decodes Binary to String
  String decBin(String text) {
    // Adjustes the string data
    text = text.replaceAll(",", ""); text = text.replaceAll(";", "");    //Adjustes commas
    text = text.replaceAll("(", ""); text = text.replaceAll(")", "");    //Adjustes braces
    text = text.replaceAll("[", ""); text = text.replaceAll("]", "");    //Adjustes square braces
    text = text.replaceAll("{", ""); text = text.replaceAll("}", "");    //Adjustes curly braces
    text = text.replaceAll("  ", " "); text = text.replaceAll("-", " "); //Adjustes spaces
    //Converts from Binary to Text
    return String.fromCharCodes(text.split(" ").map((v) => int.parse(v, radix: 2)));
  }

  // Manages the descryption types
  decriptionManager(String? decType, text, context) {
    if (text != null) {
      try {
        switch(decType) {
          case "base64":
            return decBase64(text);
          case "bin":
            return decBin(text).toString();
          case "hex":
            return decHex(text).toString();
          default:
            return Codify.showErrorPage("Encode", "Wrong decryption type Error", context);
        }
      } catch(e) {
        return Codify.showErrorPage("Encode", "${e.runtimeType.toString()} Error", context);
      }
    }
  }

  @override 
  Widget build(BuildContext context) {
    
    // Proceeds to the next page
    void showNextPage(bool isEncode) {
      try {
        // Opens the format selection page
        if (isEncode) {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => FormatPage(isEncode: isEncode, plainText: _controller.text,)),
          );
        } else {
          // Opens the text exporting page
          if (isAES == false) {
              var decodedText = decriptionManager(decodeType, _controller.text, context);
              if (decodedText != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExportPage(inputText: decodedText)),
                );
              }
          } else {
            // Opens the encryption page
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => EncryptPage(isEncode: isEncode, plainText: _controller.text,)),
            );
          }
        }
      } catch(e) {
        // Shows the catched error opening the error page
        Codify.showErrorPage("Encode", "${e.runtimeType.toString()} Error", context);
      }
    }
    if (!isEncode) {
      title = "Decode";
      subTitleText = "Cipher-Text";
      mainButtonText = "Confirm";
    }


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Input Page",
        ),
        // leading: const BackButton(),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: PageContainer(
            labelText: title, 
            container: Container(
              width: 290, 
              height: 510,
              child: Column(
                children: <Widget> [
                  const Padding(padding: EdgeInsets.only(top: 70)),
                  SubContainer(
                    labelText: subTitleText,
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
                          contentPadding: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 45),
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
                  // Opens the next page
                  TextButton(
                    onPressed: () => showNextPage(isEncode),
                    child: Text(
                      "< $mainButtonText >",
                      style: const TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6AD2FF),
                      ),
                    ),
                  ),
                  // Shows infos abput this page
                  TextButton(
                    onPressed: () {
                      try {
                        Codify.showManualPage("Encode", context);
                      } catch(e) {
                        Codify.showErrorPage("Encode", "${e.runtimeType.toString()} Error", context);
                      }
                    },
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
    );
  }
}