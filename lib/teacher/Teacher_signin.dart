import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Teacher_Siginin extends StatefulWidget {
  @override
  State<Teacher_Siginin> createState() => _Teacher_SigininState();
}

class _Teacher_SigininState extends State<Teacher_Siginin> {
  var email = TextEditingController();
  var pass = TextEditingController();
  var abc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Login"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const Text(
            "Teacher Login Here",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.cyanAccent),
          ),
          SizedBox(
              height: 200, child: Image.asset("assets/images/teacher.png")),
          TextField(
            controller: email,
            maxLength: 10,
            decoration: const InputDecoration(labelText: "Enter Your Email.",
            prefixIcon: Icon(Icons.email),
              prefixIconColor: Colors.indigoAccent,
          ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: pass,
            obscureText: abc,
            obscuringCharacter: "*",
            decoration: InputDecoration(
              label: const Text("Enter Password"),
              prefixIcon: IconButton(
                onPressed: () {
                  abc = !abc;
                  setState(() {});
                },
                icon: const Icon(Icons.password),
              ),
              prefixIconColor: Colors.cyan,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Login"))
        ],
      ),
    );
  }
}
