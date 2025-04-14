import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['Hindi', 'English', 'Marathi'];
  var originLang = 'From';
  var destLang = 'To';
  var output = "";
  TextEditingController langController = TextEditingController();

  // Make translate method asynchronous
  Future<void> translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {
      setState(() {
        output = "Failed to Translate";
      });
      return;
    }

    try {
      GoogleTranslator translator = GoogleTranslator();
      var translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text;
      });
    } catch (e) {
      setState(() {
        output = "Translation Failed: $e";
      });
    }
  }

  String getLanguageCode(String lang) {
    if (lang == "English") {
      return "en";
    } else if (lang == "Hindi") {
      return "hi";
    } else if (lang == "Marathi") {
      return "mr";
    }

    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text("Language Translator"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLang,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLang = value ?? "From";
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.arrow_right_outlined,
                      color: Colors.white, size: 40),
                  const SizedBox(width: 40),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destLang,
                      style: const TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destLang = value ?? "To";
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Please Enter",
                    labelStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    errorStyle:
                        const TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: langController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLang),
                      getLanguageCode(destLang),
                      langController.text,
                    );
                  },
                  child: const Text("Translate"),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                output,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
