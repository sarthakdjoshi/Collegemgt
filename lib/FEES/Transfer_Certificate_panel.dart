import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/FEES/Transfer_Certificate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transfer_certificate_panel extends StatefulWidget {
  const Transfer_certificate_panel({super.key});

  @override
  State<Transfer_certificate_panel> createState() =>
      _Transfer_certificate_panelState();
}

class _Transfer_certificate_panelState
    extends State<Transfer_certificate_panel> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = FirebaseFirestore.instance.collection('Students').get();
  var search=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer Certificate "),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: abc,
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
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: (MediaQuery.of(context).size.width)*0.8,
                          child: TextField(
                            controller: search,
                            decoration: const InputDecoration(
                                labelText: "Search Name"
                            ),
                          ),
                        ),
                        CupertinoButton(
                            child: const Text("Search"),
                            onPressed: () {
                              if(search.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Name"),duration: Duration(seconds: 2),));
                              }else{


                                abc = FirebaseFirestore.instance
                                    .collection('Students')
                                    .where("name",
                                    isEqualTo: search.text.trim().toString())
                                    .get();

                                setState(() {});
                                search.clear();
                              }
                            })
                      ],
                    ),
                    SingleChildScrollView(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['Course']),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['photo']),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            print(data['fees']);
                            try {
                              if (data['fees'] == "paid") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Transfer_Certificate(data['email']),
                                    ));
                              } else if (data['fees'] == "unpaid") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Please Pay Fees First"),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: const Text("Transfer Certificate"),
                        ),
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
