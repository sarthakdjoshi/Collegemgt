import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Student_Bonafied extends StatefulWidget {
  final String u_email;

  const Student_Bonafied(this.u_email, {super.key});

  @override
  State<Student_Bonafied> createState() => _Student_BonafiedState();
}

class _Student_BonafiedState extends State<Student_Bonafied> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Bonafied Certificate"),
        centerTitle: true,
        backgroundColor: Colors.purple,
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
            return Column(
                  children: [
                    Text("Bonafide Certificate",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.blueAccent.shade200),),
                    const Divider(height: 20,),
                    Text("This Is certify that Mr./Mrs.${data['name'].toString()}    S/O OR D/O Of MR./MRS.${data['parentsname'].toString()} Is Student Of________(Year)___________Course name-${data['Course'.toString()]} For Academic Year_____________________________.He/She Is Bonafide Student Of SSCCM ",style: const TextStyle(fontSize: 18),),
                    const Divider(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Date Generate",style: TextStyle(fontSize: 24),),
                        const Text(":-"),
                        Text(DateFormat('yyyy-MM-dd').format(DateTime.now()),style: const TextStyle(fontSize: 20),),
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
                        Text("Principal Stamp",style: TextStyle(fontSize: 24),),

                      ],
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
