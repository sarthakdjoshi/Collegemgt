import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Id_Card extends StatefulWidget{
final String u_mail;

Id_Card(this.u_mail);

  @override
  State<Id_Card> createState() => _Id_CardState();
}

class _Id_CardState extends State<Id_Card> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(
       title: Text("Id Card"),
       centerTitle: true,
       backgroundColor: Colors.indigoAccent,

     ),
     body:  FutureBuilder<QuerySnapshot>(
       future: FirebaseFirestore.instance.collection('Students').where("email",isEqualTo: widget.u_mail).get(),
       builder: (context, snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return const CircularProgressIndicator();
         } else if (snapshot.hasError) {
           return Text('Error: ${snapshot.error}');
         } else {
           // Process the documents
           List<DocumentSnapshot> documents = snapshot.data!.docs;
           return ListView.builder(
             itemCount: documents.length,
             itemBuilder: (context, index) {
               // Access data from each document using documents[index].data()
               Map<String, dynamic> data =
               documents[index].data() as Map<String, dynamic>;
               String documentId = documents[index].id;
               return SingleChildScrollView(
                 child: Center(
                   child: Card(
                     margin: EdgeInsets.all(16.0),
                     child: Padding(
                       padding: EdgeInsets.all(16.0),
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text("College Name",style: TextStyle(fontSize: 24),),
                           CircleAvatar(
                             radius: 50.0,
                             backgroundImage: NetworkImage(data['photo']) // Replace with your image
                           ),
                           SizedBox(height: 16.0),
                           Text(
                             'Name:${data['name']}',
                             style: TextStyle(
                               fontSize: 20.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           SizedBox(height: 8.0),
                           Text(
                             'App ID: ${documentId}',
                             style: TextStyle(fontSize: 16.0),
                           ),
                           SizedBox(height: 8.0),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Icon(Icons.email),
                               SizedBox(width: 8.0),
                               Text(data['email'], style: TextStyle(fontSize: 16.0)),
                             ],
                           ),
                           SizedBox(height: 16.0),
                           Text(
                             'Stream: ${data['Course']}',
                             style: TextStyle(fontSize: 16.0),
                           ),
                         SizedBox(height: 16.0),
                           Text(
                             'CurrentSem: ${data['CurrentSem']}',
                             style: TextStyle(fontSize: 16.0),
                           ),
                         ],
                       ),
                     ),
                   ),
                 )
               );
             },
           );
         }
       },
     ),
   );
  }
}
