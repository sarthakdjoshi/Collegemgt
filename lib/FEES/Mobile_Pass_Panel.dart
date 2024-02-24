import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/FEES/Mobile_Pass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_Pass_Panel extends StatefulWidget {
  const Mobile_Pass_Panel({super.key});

  @override
  State<Mobile_Pass_Panel> createState() => _Mobile_Pass_PanelState();
}

class _Mobile_Pass_PanelState extends State<Mobile_Pass_Panel> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');
  var abc = FirebaseFirestore.instance.collection('Students').get();
  var search = TextEditingController();
  var fees_detail = "";
  var fee_lable = true;
  var lable = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Pass"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.8,
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(labelText: "Search Name"),
                ),
              ),
              CupertinoButton(
                  child: const Text("Search"),
                  onPressed: () {
                    if (search.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Enter Name"),
                        duration: Duration(seconds: 2),
                      ));
                    } else {
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
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
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
                          SingleChildScrollView(
                            child: ListTile(
                              title: Text(data['name']),
                              subtitle: Text(data['Course']),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(data['photo']),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  try {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Mobile_Pass(data['email']),
                                        ));
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: const Text("Mobile Pass Certificate"),
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
          ),
        ],
      ),
    );
  }
}
