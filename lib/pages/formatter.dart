import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart'; // Main import
//Following pages import
import 'package:flutter_codify/pages/encrypter.dart';
import 'package:flutter_codify/pages/encoder.dart';
import 'package:flutter_codify/pages/exporter.dart';
//Encoding imports
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';

  
class FormatPage extends StatefulWidget {
  final bool isEncode;
  String? plainText = "";
  FormatPage({Key? key, required this.isEncode, this.plainText}) : super(key: key);
  List<Widget> wList = [];


  @override
  FormatPageState createState() => FormatPageState();
}
  
class FormatPageState extends State<FormatPage> {
  List<bool> _isSelected = [true, false, false, false, false, false];
  Map<int, String> _encodingType = const {};
  String? selectedType = "aes";
  String mainButtonText = "Confirm";


  @override 
  Widget build(BuildContext context) {

    String? encHex(String text) {
      return HEX.encode(text.codeUnits);
    }

    String? encBase64(String text) {
      return base64.encode(utf8.encode(text));
    }

    Digest? encSha1(String text) {
      return sha1.convert(utf8.encode(text));
    }

    Digest? encMd5(String text) {
      return md5.convert(utf8.encode(text));
    }

    String encBin(String text) {
      Iterable<String> binary = text.codeUnits.map((int strInt) => strInt.toRadixString(2));
      String binaryText = "";

      for (var element in binary) {binaryText += element.toString() + " ";}
      return binaryText;
    }

    encriptionManager(String? encType, String? text) {
      if (text != null) {
        try {
          switch(encType) {
            case "base64":
              return encBase64(text);
            case "sha1":
              return encSha1(text);
            case "md5":
              return encMd5(text);
            case "bin":
              return encBin(text).toString();
            case "hex":
              return encHex(text);
            default:
              Codify.showErrorPage("Encode", "Wrong decryption type Error", context);
              break;
          }
        } catch(e) {
          Codify.showErrorPage("Encode", "${e.runtimeType.toString()} Error", context);
        }
      }
    }


    void showNextPage() {
      bool isAES = (selectedType == "aes");
      try {
        if (widget.isEncode) {
          if (isAES) {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => EncryptPage(isEncode: widget.isEncode, plainText: widget.plainText,)),
            );
          } else {
            var encodedText = encriptionManager(selectedType, widget.plainText).toString();
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ExportPage(inputText: encodedText)),
            );
          }
        } else {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => EncodePage(isEncode: widget.isEncode, isAES: isAES, decodeType: selectedType)),
          );
        }
      } catch(e) {
        Codify.showErrorPage("Encode", "${e.runtimeType.toString()} Error", context);
      }
    }

    if (widget.isEncode) {
      widget.wList = const <Widget>[
        Text("  * AES-256       ", style: TextStyle(fontSize: 20)),
        Text("  * BASE-64       ", style: TextStyle(fontSize: 20)),
        Text("  * SHA-1         ", style: TextStyle(fontSize: 20)),
        Text("  * MD5           ", style: TextStyle(fontSize: 20)),
        Text("  * BIN           ", style: TextStyle(fontSize: 20)),
        Text("  * HEX           ", style: TextStyle(fontSize: 20)),
      ];
      _encodingType = const {
        0: "aes",
        1: "base64",
        2: "sha1",
        3: "md5",
        4: "bin",
        5: "hex"
      };
      var oldSelected = _isSelected;
      _isSelected = [true, false, false, false, false, false];
      for(int i=0; i<widget.wList.length; i++ ) {
        _isSelected[i] = oldSelected[i];
      }
    } else {
      mainButtonText = "Next";
      widget.wList = const <Widget>[
        Text("  * AES-256       ", style: TextStyle(fontSize: 20)),
        Text("  * BASE-64       ", style: TextStyle(fontSize: 20)),
        Text("  * BIN           ", style: TextStyle(fontSize: 20)),
        Text("  * HEX           ", style: TextStyle(fontSize: 20)),
      ];
      _encodingType = const {
        0: "aes",
        1: "base64",
        2: "bin",
        3: "hex"
      };
      var oldSelected = _isSelected;
      _isSelected = [true, false, false, false];
      for(int i=0; i<widget.wList.length; i++ ) {
        _isSelected[i] = oldSelected[i];
      }
    }
    

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Formatting Page",
        ),
      ),

      body: Center(
        child: PageContainer(
          labelText: "Format", 
          container: Container(
            width: 290, 
            height: 510,
            child: Column(
              children: <Widget> [
                const Padding(padding: EdgeInsets.only(top: 70)),
                SubContainer(
                  labelText: "Type",
                  container: Container(
                    padding: const EdgeInsets.only(top: 50),
                    width: 240, 
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Scrollbar(
                        child: ListView(
                          children: [
                            ToggleButtons(
                              direction: Axis.vertical,
                              children: widget.wList,
                              isSelected: _isSelected,
                              onPressed: (int index) {
                                try {
                                  setState(() {
                                    selectedType = _encodingType[index];
                                    for (int i = 0; i < _isSelected.length; i++) {
                                      if (i == index) {
                                        _isSelected[i] = true;
                                      } else {
                                        _isSelected[i] = false;
                                      }
                                    }
                                  });
                                } catch(e) {
                                  Codify.showErrorPage("Format", "${e.runtimeType.toString()} Error", context);
                                }
                                
                              },
                              // Region 1
                              color: const Color(0xFFF5FFFF),
                              selectedColor: const Color(0xFFFFBB55),
                              fillColor: const Color(0xFF848484),
                              renderBorder: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                  width: 15,
                ),
                TextButton(
                  onPressed: showNextPage,
                  child: Text(
                    "< $mainButtonText >",
                    style: const TextStyle(
                      fontSize: 25,
                      color: Color(0xFF6AD2FF),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    try {
                      Codify.showManualPage("Format", context);
                    } catch(e) {
                      Codify.showErrorPage("Format", "${e.runtimeType.toString()} Error", context);
                    }
                  }, //Alert(message: 'I Forgor💀').show(); print("Help");
                  child: const Text(
                    "< ? Help >",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Color(0xFFFFFF33), //yellow
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}