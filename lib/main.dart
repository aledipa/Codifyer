import 'package:flutter/material.dart';
// import 'package:alert/alert.dart'; // Alert(message: 'Test').show();
import 'package:flutter_codify/pages/encoder.dart';
import 'package:flutter_codify/pages/formatter.dart';
import 'dart:developer';


void main() {
  runApp(const Codify());
}

class Codify extends StatelessWidget {
  const Codify({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Codifyer",
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Hermit'
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    void showEncodePage(bool action) {
      Navigator.push(//pash
        context, 
        MaterialPageRoute(builder: (context) => EncodePage(isEncode: action)), //context = self o this
      );
    }

    void showFormatPage(bool action) {
      Navigator.push(//pash
        context, 
        MaterialPageRoute(builder: (context) => FormatPage(isEncode: action)), //context = self o this
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Codifyer Home",
        ),
      ),
      body: Center(
        child: PageContainer(
          labelText: "Menu", 
          container: Container(
            width: 290, 
            height: 510,
            child: Column(
              children: <Widget> [
                const Padding(padding: EdgeInsets.only(top: 95)),
                TextButton(
                  onPressed: () {showEncodePage(true); log("Encrypt");},
                  child: const Text(
                    "< Encrypt >",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF6AD2FF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                  width: 15,
                ),
                TextButton(
                  onPressed: () {showFormatPage(false); log("Decrypt");},
                  child: const Text(
                    "< Decrypt >",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF6AD2FF),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 165,
                  width: 15,
                ),
                TextButton(
                  onPressed: () {}, //Alert(message: 'I Forgor💀').show(); log("Help");
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

class PageContainer extends StatelessWidget {
  final String labelText;
  final Container container;

  PageContainer({required this.labelText, required this.container});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            width: 290, 
            height: 495, 
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00FF00)),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          ),
        ),
        Positioned(
          bottom: 470,
          child: SizedBox(
            width: 290,
            child: Text(
              labelText, 
              style: const TextStyle(
                color: Color(0xFF00FF00),
                backgroundColor: Color(0xFF303030),
                fontSize: 35,
              ), 
              textAlign: TextAlign.center,
            ),
          ),
        ),
        container,
      ],
    );
  }
}

class SubContainer extends StatelessWidget {
  final String labelText;
  final Container container;
  final double width = 235; //290-235 = 55/2 = 27.5
  double? height; //230

  SubContainer({Key? key, required this.labelText, required this.container, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    height ??= 230;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 0,
          child: Container(
            width: width, 
            height: height, 
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFF5FFFF)),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
        Positioned(
          bottom: height!-20,
          child: SizedBox(
            width: width,
            child: Text(
              labelText, 
              style: const TextStyle(
                color: Color(0xFFF5FFFF),
                backgroundColor: Color(0xFF303030),
                fontSize: 25,
              ), 
              textAlign: TextAlign.center,
            ),
          ),
        ),
        container,
      ],
    );
  }
}