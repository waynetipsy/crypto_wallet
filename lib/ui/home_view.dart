 // ignore_for_file: avoid_unnecessary_containers, must_call_super
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_view.dart';
import '../net/flutterfire.dart';
 
 class HomeView extends StatefulWidget {
   const HomeView({ Key? key }) : super(key: key);
 
   @override
   _HomeViewState createState() => _HomeViewState();
 }
 
 class _HomeViewState extends State<HomeView> {
    double bitcoin = 0.0;
    double ethereum = 0.0;
    double solana = 0.0;

    @override
    void initState () {
      getValues();
    }

   getValues() async {
   bitcoin = await getPrice('bitcoin');
   ethereum = await getPrice('ethereum');
   solana = await getPrice('solana');
   setState(() {});
   }
  @override
    Widget build(BuildContext context) {
      getValue(String id, double amount) {
        if (id == 'bitcoin') {
          return bitcoin * amount;
        } else if (id == 'ethereum') {
        return ethereum * amount;
      } else {
        return solana * amount;
      }
      }
     return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Coins').snapshots(),
        builder: (BuildContext context,
         AsyncSnapshot <QuerySnapshot> snapshot) {
       if (!snapshot.hasData) {
         return const Center(
           child: CircularProgressIndicator(),
           );
         }
         return ListView(
       children: snapshot.data!.docs.map((documents) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            left: 15.0,
            right: 15.0,
            ),
         child: Container(
    //width: MediaQuery.of(context).size.width / 1.3,
    height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.pink,
        ),
          child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           const SizedBox(
              width: 5.0,
            ),
         Text('Coin Name: ${documents.id}',
       style: const  TextStyle(
         fontSize: 18.0,
           color: Colors.white,
         ),
         ),
         Text(
       '\$${getValue(documents.id, documents.get('Amount')).toStringAsFixed(2)}',
           style: const TextStyle(
             fontSize: 18.0,
             color: Colors.white,
               ),    
                ),
             IconButton(
            icon: Icon(
              Icons.close,
              color:   Colors.blueAccent,
              ),
              onPressed: () async {
            await removeCoin(documents.id);
              },
               ),
               ],
              ),
             )
            );
          }).toList(),
         );
        }
       ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => const AddView()
          ),
        );  
      },
      child: const Icon(
        Icons.add, color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
     );
   }
 }