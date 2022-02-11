import 'package:flutter/material.dart';
import 'package:flutter_codify/infos/manual.dart';
import 'package:flutter_codify/infos/error.dart';
import 'package:flutter_codify/pages/encoder.dart';
import 'package:flutter_codify/pages/formatter.dart';
import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';   //Currently without ADS :)

void main() {
  runApp(const Codify());
}

class Codify extends StatelessWidget {
  const Codify({Key? key}) : super(key: key);

  static void showManualPage(String page, context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManualPage(inputPage: page)),
    );
  }

  static void showErrorPage(String page, String error, context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ErrorPage(inputPage: page, inputError: error)),
    );
  }

  static void copyToClipboard(String link) {
    Clipboard.setData(ClipboardData(text: link));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Codifyer",
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Hermit'),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showEncodePage(bool action) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EncodePage(isEncode: action)),
      );
    }

    void showFormatPage(bool action) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FormatPage(isEncode: action)),
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
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 95)),
                // Button to open the encoding page
                TextButton(
                  onPressed: () {
                    try {
                      showEncodePage(true);
                    } catch (e) {
                      Codify.showErrorPage(
                          "Home", "${e.runtimeType.toString()} Error", context);
                    }
                  },
                  child: const Text(
                    "< Encrypt >",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF6AD2FF),
                    ),
                  ),
                ),
                // White space
                const SizedBox(
                  height: 25,
                  width: 15,
                ),
                // Button to open the format selection page
                TextButton(
                  onPressed: () {
                    try {
                      showFormatPage(false);
                    } catch (e) {
                      Codify.showErrorPage(
                          "Home", "${e.runtimeType.toString()} Error", context);
                    }
                  },
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
                // Button to get help about this page
                TextButton(
                  onPressed: () {
                    try {
                      Codify.showManualPage("Home", context);
                    } catch (e) {
                      Codify.showErrorPage(
                          "Home", "${e.runtimeType.toString()} Error", context);
                    }
                  }, //Alert(message: 'I Forgor💀').show(); log("Help");
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

// Green large widget box
class PageContainer extends StatelessWidget {
  final String labelText;
  final Container container;
  Color borderColor;

  PageContainer(
      {Key? key,
      required this.labelText,
      required this.container,
      this.borderColor = const Color(0xFF00FF00)})
      : super(key: key);
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
              border: Border.all(color: borderColor),
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
              style: TextStyle(
                color: borderColor,
                backgroundColor: const Color(0xFF303030),
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

// Multicolor smaller sub-widget box
class SubContainer extends StatelessWidget {
  final String labelText;
  final Container container;
  final double width = 235; //290-235 = 55/2 = 27.5
  double? height; //230

  SubContainer(
      {Key? key, required this.labelText, required this.container, this.height})
      : super(key: key);
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
          bottom: height! - 20,
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
