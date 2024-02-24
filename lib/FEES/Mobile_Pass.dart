import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Mobile_Pass extends StatefulWidget {
  final String u_email;

  const Mobile_Pass(this.u_email, {super.key});

  @override
  State<Mobile_Pass> createState() => _Mobile_PassState();
}

class _Mobile_PassState extends State<Mobile_Pass> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = FirebaseFirestore.instance.collection('Students').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile_Pass"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: users.where("email", isEqualTo: widget.u_email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data =
                    documents[index].data() as Map<String, dynamic>;
                String documentId = documents[index].id;
                String gen="";
                if (data['gender'] == "Male") {
                  gen = "He";
                } else if (data['gender'] == "Female") {
                  gen = "She";
                }
                return Column(
                  children: [
                    Image.network(
                      data['photo'],
                      width: 200,
                      height: 200,
                    ),
                    Text(
                      "Mobile Pass",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueAccent.shade200),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Text(
                      "This Is certify that Mr./Mrs.${data['name'].toString()}    S/O OR D/O Of MR./MRS.${data['parentsname'].toString()} Course name-${data['Course'.toString()]} And Semester-${data['CurrentSem']} ${gen.toString()} Has Permit To Allow Mobile Inside The College Premise ",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Date Generate",
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(":-"),
                        Text(
                          data['mobile_pass_gen_date'],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(""),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(""),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Principal Stamp",
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: (data['mobilepass'] == "no") ? true : false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                await users.doc(documentId).update({
                                  'mobile_pass_gen_date':
                                      DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now()),
                                  'mobilepass': 'yes',
                                });
                                setState(() {});
                              },
                              child: const Text("Allow For Mobile"))
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
