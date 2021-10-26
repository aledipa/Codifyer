// import 'package:encrypt/encrypt_io.dart';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:alert/alert.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_codify/main.dart';
import 'package:flutter_codify/pages/exporter.dart';
// import 'dart:io';
// import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:crypto/crypto.dart';
// import 'dart:convert' as ConvertPack;
// import 'package:cryptography/cryptography.dart' as CryptographyPack;
//Encoding imports


  
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

    final key = encrypt.Key.fromUtf8(secretKey); //)H@McQfTjWnZr4t7w!z%C*F-JaNdRgUk
    // final key = encrypt.Key.fromUtf8(')H@McQfTjWnZr4t7w!z%C*F-JaNdRgUk'); //

    final iv = encrypt.IV.fromLength(16);
    print(iv.base64);

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encMode));

    return encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  }

  // Future<String?> encRSA(String text, String secret_key) async {
  //   final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
  //   final privKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');

  //   final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey, privateKey: privKey));

  //   final encrypted = encrypter.encrypt(text);
  //   final decrypted = encrypter.decrypt(encrypted);

  //   // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  //   // print(encrypted.base64); // kO9EbgbrSwiq0EYz0aBdljHSC/rci2854Qa+nugbhKjidlezNplsEqOxR+pr1RtICZGAtv0YGevJBaRaHS17eHuj7GXo1CM3PR6pjGxrorcwR5Q7/bVEePESsimMbhHWF+AkDIX4v0CwKx9lgaTBgC8/yJKiLmQkyDCj64J3JSE=
  //   return encrypted.base64;
  // }

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
        title: const Text(
          "Encryption Page",
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
                              setState(() {
                                for (int i = 0; i < _isSelected.length; i++) {
                                  if (i == index) {
                                    _isSelected[i] = true;
                                  } else {
                                    _isSelected[i] = false;
                                  }
                                }
                              });
                            },
                            // region example 1
                            color: const Color(0xFFF5FFFF),
                            selectedColor: const Color(0xFFFFBB55),
                            fillColor: const Color(0xFF848484),
                            renderBorder: false,
                            // endregion
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
                            // fillColor: Color(0xFFFFBB55),
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
                    onPressed: () {print("Encrypt"); print(_controller.text); showExportPage();},
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
    );
  }
}