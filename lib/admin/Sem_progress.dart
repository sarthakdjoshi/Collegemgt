import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/admin/sem_prg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sem_Progress extends StatefulWidget {
  const Sem_Progress({super.key});

  @override
  State<Sem_Progress> createState() => _Sem_ProgressState();
}

class _Sem_ProgressState extends State<Sem_Progress> {
  var search = TextEditingController();
  var abc = FirebaseFirestore.instance.collection('Students').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sem_Progerss"),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
                          width: (MediaQuery.of(context).size.width) * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: search,
                                decoration: const InputDecoration(
                                    labelText: "Enter Name"),
                              )),
                            ],
                          ),
                        ),
                        CupertinoButton(
                            child: const Text("Search"),
                            onPressed: () {
                              abc = FirebaseFirestore.instance
                                  .collection('Students')
                                  .where('name',
                                      isEqualTo: search.text.toString())
                                  .get();
                              setState(() {});
                            })
                      ],
                    ),
                    SingleChildScrollView(
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text("Current Sem Is ${data['CurrentSem']}"),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['photo']),
                        ),
                        trailing: CupertinoButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => sem_prg(
                                      data['name'], documentId, data['photo']),
                                ));
                          },
                          child: const Text("Change Sem"),
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
