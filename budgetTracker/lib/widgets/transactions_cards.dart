// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:budgetmap/utils/icons_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'transactions_card.dart';

class TransactionsCard extends StatelessWidget {
   TransactionsCard({
    super.key}
   
  );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
            Row(
              children: [
                Text("Recent Transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
      RecentTransactionsList()
        ],
      ),
    );
  }
}

class RecentTransactionsList extends StatelessWidget {
   RecentTransactionsList({
    super.key,
  });
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection("transaction")
      .orderBy('timestamp', descending: true)
      .limit(20)
      .snapshots(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No transactions found."),); // 1:30:46 ended here
        }



var data = snapshot.data!.docs;
    return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index){
      var cardData = data[index];
    return TransactionCard(
      data: cardData,
          ); //1:27.32 ended here
       });
    });
  }
}

