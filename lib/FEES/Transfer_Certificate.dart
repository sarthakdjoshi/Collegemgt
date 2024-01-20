import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Transfer_Certificate extends StatefulWidget {
  final String u_email;

  const Transfer_Certificate(this.u_email, {super.key});

  @override
  State<Transfer_Certificate> createState() => _Transfer_CertificateState();
}

class _Transfer_CertificateState extends State<Transfer_Certificate> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Certificate "),
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
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Transfer Certificate"),
                      Image.network(
                        data['photo'],
                        width: 200,
                        height: 200,
                      ),
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "APP_ID",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              documentId,
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Name",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['name'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Stream",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['Course'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Sem",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['CurrentSem'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Email",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(child: Text(data['email'])),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Gender",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['gender'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Address",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['address'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Addharcard No.",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['addharcard'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "city",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['city'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "State",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['state'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Date Of Birth",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['dob'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "fees",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: Text(
                              data['fees'],
                              style: const TextStyle(fontSize: 24),
                            )),
                          ]),
                          TableRow(children: [
                            const TableCell(
                                child: Text(
                              "Sure To Delete Student",
                              style: TextStyle(fontSize: 24),
                            )),
                            TableCell(
                                child: ElevatedButton(
                              onPressed: () {
                                users.doc(documentId).delete();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Student Deleted SuccessFully"),
                                  duration: Duration(seconds: 2),
                                ));
                                abc = true;
                                setState(() {});
                              },
                              child: const Text("Delete"),
                            )),
                          ]),
                        ],
                      ),
                      Visibility(
                        visible: abc,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.download),
                                Text("Download Transfer Certificate")
                              ],
                            )),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
