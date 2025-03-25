import 'package:flutter/material.dart';
import 'signup_PDER.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page 1"), backgroundColor: Colors.purple),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is Page 1", style: TextStyle(fontSize: 20, color: Colors.purple)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Text("Go to Sign-Up Page", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
