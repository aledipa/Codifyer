import 'package:flutter/material.dart';
// import 'package:alert/alert.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_codify/main.dart';
// import 'package:flutter_codify/pages/formatter.dart';


class ExportPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final String inputText;
  ExportPage({required this.inputText});
  // const ExportPage({Key? key}) : super(key: key);


  @override 
  Widget build(BuildContext context) {
    void copyToClipboard(String link) {
      Clipboard.setData(ClipboardData(text: link));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Codifyer Export",
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
              labelText: "Export", 
              container: Container(
                width: 290, 
                height: 510,
                child: Column(
                  children: <Widget> [
                    const Padding(padding: EdgeInsets.only(top: 70)),
                    SubContainer(
                      labelText: "Output",
                      container: Container(
                        width: 240, 
                        height: 250,
                        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                        child: Scrollbar(
                          child: SingleChildScrollView (
                            scrollDirection: Axis.vertical,
                            child: Text(
                              inputText,
                              // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                              style: const TextStyle(
                                color: Color(0xFFFFBB55),
                              ),
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
                      onPressed: () {copyToClipboard(inputText);},
                      child: const Text(
                        "< Save >",
                        style: TextStyle(
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