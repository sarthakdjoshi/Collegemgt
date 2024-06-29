import 'dart:ui';
import 'package:cms_student/splash%20Screen.dart';
import 'package:cms_student/student/profile_stud.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
      home: const Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var e_mail = TextEditingController();
  var pass = TextEditingController();
  var abc = true;

  void singin() async {
    try {
      String email = e_mail.text.trim().toString();
      String password = pass.text.trim().toString();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Profile_Stud(email),
          ));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Student Loggedin")));
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
      if (e.code.toString() == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Internet Connection Is Not Found"),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are You Sure?'),
            content: const Text('Do You Want To Exit The App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Login"),
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
              SizedBox(
                  height: 200, child: Image.asset("assets/images/l-1.jpg")),
              TextField(
                controller: e_mail,
                keyboardType: TextInputType.emailAddress,
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
              CupertinoButton(
                  child: const Text("Clear"),
                  onPressed: () {
                    e_mail.clear();
                    pass.clear();
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please Wait"),
                            duration: Duration(seconds: 2),
                          ));
                          singin();
                        },
                                           style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
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
                              content:
                                  Text("Reset Link Has Sent To Your Email"),
                              duration: Duration(seconds: 2),
                            ));
                          }
                        } on FirebaseAuthException catch (e) {
                          print(e.code.toString());
                        }
                      },
                      child: const Text("Forgot Password")),
                  Expanded(
                    child: CupertinoButton(
                        child: const Text("Contact Admin"),
                        onPressed: () {

                        }),
                  )
                ],
              ),
            ],
          )),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.indigo,
          child: SizedBox(
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Developed By Sarthak Joshi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
