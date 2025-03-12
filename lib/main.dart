import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DocumentProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.blueGrey.shade800),
        ),
      ),
      home: DocumentPromptPage(),
    );
  }
}

class DocumentProvider extends ChangeNotifier {
  String? selectedPrompt;

  void selectPrompt(String prompt) {
    selectedPrompt = prompt;
    notifyListeners();
  }
}

class DocumentPromptPage extends StatelessWidget {
  const DocumentPromptPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DocumentProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("📜 AI Document Assistant"),
        backgroundColor: Colors.lightBlue.shade300,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose an action or enter a prompt!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              children: [
                "📄 Summarize the document",
                "🔒 Generate NDA Document"
              ].map((text) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.lightBlue.shade300, width: 2),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  elevation: 0,
                ),
                onPressed: () {
                  provider.selectPrompt(text);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoadingPage()));
                },
                child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800)),
              )).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "💬 Enter your custom request",
                hintStyle: TextStyle(color: Colors.blueGrey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.lightBlue.shade300),
                ),
              ),
              onSubmitted: (value) {
                provider.selectPrompt(value);
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoadingPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/loading3.gif', width: 150),
            SizedBox(height: 20),
            Text(
              "✨ Processing your request...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
