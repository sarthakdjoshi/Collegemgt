import 'package:cms/FEES/Fees_Panel.dart';
import 'package:cms/admin/Admin_Panel.dart';
import 'package:cms/student/profile_stud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      checkerboardOffscreenLayers: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var e_mail = TextEditingController();
  var pass = TextEditingController();
  var abc = true;

  void singin() async {
    try {
      String email = e_mail.text.toString();
      String password = pass.text.toString();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile_Stud(email),
          ));
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      if (e.code.toString() == "invalid-credential") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Username or password is NotCorrect"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "channel-error") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email or Password Must Be Filled"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "user-disabled") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your Account Has Been Lock  Contact Your Principal"),
          duration: Duration(seconds: 2),
        ));
      }
      if (e.code.toString() == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Provide Valid Email "),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Student Login Here",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.cyanAccent),
            ),
            SizedBox(height: 200, child: Image.asset("assets/images/l-1.jpg")),
            TextField(
              controller: e_mail,
              decoration: const InputDecoration(
                label: Text("Enter Email"),
                prefixIcon: Icon(Icons.email),
                prefixIconColor: Colors.indigoAccent,
              ),
            ),
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
            ElevatedButton(
                onPressed: () {
                  if (e_mail.text.toString() == "admin" &&
                      pass.text.toString() == "admin") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Admin_Panel(),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Admin Logged in"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (e_mail.text.toString() == "fees" &&
                      pass.text.toString() == "fees") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Fees_panel(),
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Fees_Department Logged in"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Wait"),
                      duration: Duration(seconds: 2),
                    ));
                    singin();
                  }
                },
                child: const Text("Login")),
            Row(
              children: [
                CupertinoButton(
                    onPressed: () {
                      try {
                        if (e_mail.text == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Enter Email "),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          print(e_mail.text.toString());
                          String email = e_mail.text.toString();
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Reset Link Has Sent To Your Email"),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e.code.toString());
                      }
                    },
                    child: const Text("Forgot Password"))
              ],
            )
          ],
        )),
      ),
    );
  }
}
