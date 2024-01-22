import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Upload_Assignmnet extends StatefulWidget {
  const Upload_Assignmnet({super.key});

  @override
  State<Upload_Assignmnet> createState() => _Upload_AssignmnetState();
}

class _Upload_AssignmnetState extends State<Upload_Assignmnet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Your Assignments"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
          },
          child: SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.8,
            height: (MediaQuery.of(context).size.height) * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(FontAwesomeIcons.upload,
                    size: ((MediaQuery.of(context).size.width) * 0.8) * 0.5),
                const Text(
                  "Upload Your Assignment",
                  style: TextStyle(fontSize: 29, color: Colors.purple),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
