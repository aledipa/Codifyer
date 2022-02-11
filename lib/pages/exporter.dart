import 'package:flutter/material.dart';
import 'package:flutter_codify/main.dart';


class ExportPage extends StatelessWidget {
  final String inputText;
  const ExportPage({Key? key, required this.inputText}) : super(key: key);

  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Exporting Page",
        ),

      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                            style: const TextStyle(
                              color: Color(0xFFFFBB55), //lightorange
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
                    onPressed: () {
                      try {
                        Codify.copyToClipboard(inputText);
                      } catch(e) {
                        Codify.showErrorPage("Export", "${e.runtimeType.toString()} Error", context);
                      }
                    },
                    child: const Text(
                      "< Save >",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF6AD2FF), //lightblue
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        Codify.showManualPage("Export", context);
                      } catch(e) {
                        Codify.showErrorPage("Export", "${e.runtimeType.toString()} Error", context);
                      }
                    },
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
      ),
    );
  }
}