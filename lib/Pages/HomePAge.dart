import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_with_goggle/Services_auth/Auth_service.dart';
import 'package:provider/provider.dart';

import 'ChatPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut()
  {
    final authService =Provider.of<AuthService>(context,listen: false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          IconButton(onPressed: signOut,
              icon: Icon(Icons.login_rounded))
        ],
      ),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context,snapshot)
      {
             if(snapshot.hasError)
               {
                 return Text('Error');
               }
             if(snapshot.connectionState == ConnectionState.waiting)
               {
                 return Text('Waiting');
               }
             return ListView(
               children: snapshot.data!.docs
                   .map<Widget>((doc)=>_buildUserListItem(doc))
                   .toList(),
             );
      },
    );
  }
  Widget _buildUserListItem(DocumentSnapshot document)
  {
   Map<String,dynamic> data = document.data()!
        as Map<String,dynamic>;
   if (_auth.currentUser != null && _auth.currentUser!.email != data["email"])
   {
       return ListTile(
         title: Text(data["email"]),
         onTap: ( )
         {
           Navigator.push(context,MaterialPageRoute(builder:(context) =>ChatPage(
             reciverUserEmail: data["email"],
             reciverUserID: data["uid"],
           )
           )
           );
         }
       );
     }
   else
     {
       return Container();
     }
  }


}
