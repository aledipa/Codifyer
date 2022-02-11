import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart';
import 'package:flutter_codify/pages/exporter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

  
class EncryptPage extends StatefulWidget {
  final bool isEncode;
  String? plainText = "";
  EncryptPage({required this.isEncode, required this.plainText});

  @override
  EncryptPageState createState() => EncryptPageState();
}
  
class EncryptPageState extends State<EncryptPage> {
  final List<bool> _isSelected = [true, false];
  final TextEditingController _controller = TextEditingController();
  String mainButtonText = "Encrypt";

  bool isECB() {
    return _isSelected[0];
  }

  bool isCBC() {
    return _isSelected[1];
  }

  String? encAes256(String text, String secretKey) {
    const encMode = encrypt.AESMode.cbc;

    if (isECB()) {
      const encMode = encrypt.AESMode.ecb;
    }

    final key = encrypt.Key.fromUtf8(secretKey);

    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encMode));

    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String? decAes256(String text, String secretKey) {
    const encMode = encrypt.AESMode.cbc;

    if (isECB()) {
      const encMode = encrypt.AESMode.ecb;
    }

    final key = encrypt.Key.fromUtf8(secretKey);

    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encMode));

    return encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  }

  @override 
  Widget build(BuildContext context) {
    void showExportPage() {
      String? text = "";
      if (widget.plainText!.isNotEmpty) {
        if (widget.isEncode) {
          text = encAes256(widget.plainText.toString(), _controller.text);
        } else {
          text = decAes256(widget.plainText.toString(), _controller.text);
        }
      }
      if (true) {

      }

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ExportPage(inputText: text.toString())),
      );
    }

    if (!widget.isEncode) {
      mainButtonText = "Decrypt";
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "${mainButtonText}ion Page",
        ),

      ),
      body: Center(
        child: PageContainer(
            labelText: "AES-256", 
            container: Container(
              width: 290, 
              height: 510,
              child: Column(
                children: <Widget> [
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  SubContainer(
                    labelText: "Mode",
                    height: 130,
                    container: Container(
                      padding: const EdgeInsets.only(top: 50),
                      width: 240, 
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ToggleButtons(
                            direction: Axis.vertical,
                            children: const <Widget>[
                              Text("  * ECB           ", style: TextStyle(fontSize: 20)),
                              Text("  * CBC           ", style: TextStyle(fontSize: 20)),
                            ],
                            isSelected: _isSelected,
                            onPressed: (int index) {
                              try {
                                setState(() {
                                  for (int i = 0; i < _isSelected.length; i++) {
                                    if (i == index) {
                                      _isSelected[i] = true;
                                    } else {
                                      _isSelected[i] = false;
                                    }
                                  }
                                });
                              } catch(e) {
                                Codify.showErrorPage("Encrypt", "${e.runtimeType.toString()} Error", context);
                              }
                              
                            },
                            // Region 1
                            color: const Color(0xFFF5FFFF),
                            selectedColor: const Color(0xFFFFBB55),
                            fillColor: const Color(0xFF848484),
                            renderBorder: false,
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                    width: 15,
                  ),
                  SubContainer(
                    labelText: "Secret-Key",
                    height: 70,
                    container: Container(
                        width: 240, 
                        height: 90,
                        
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
                  TextButton(
                    onPressed: () {
                      try {
                        showExportPage();
                      } catch(e) {
                        Codify.showErrorPage("Encrypt", "${e.runtimeType.toString()} Error", context);
                      }
                    },
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
                        Codify.showManualPage("Encrypt", context);
                      } catch(e) {
                        Codify.showErrorPage("Encrypt", "${e.runtimeType.toString()} Error", context);
                      }
                    }, //Alert(message: 'I Forgor💀').show(); print("Help");
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
    );
  }
}