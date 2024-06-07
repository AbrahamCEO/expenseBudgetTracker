import 'package:budgetmap/screens/login_screen.dart';
import 'package:budgetmap/widgets/add_transaction_form.dart';
import 'package:budgetmap/widgets/hero_card.dart';
import 'package:budgetmap/widgets/transactions_cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  String username = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          username = userDoc.data()?['username'] ?? "User";
        });
      }
    } catch (e) {
      print("Failed to fetch username: $e");
      setState(() {
        username = "Failed to load username";
      });
    }
  }

  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
    setState(() {
      isLogoutLoading = false;
    });
  }

  _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: AddTransactionForm(),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          _dialogBuilder(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Hello, $username", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(Icons.exit_to_app),
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
            TransactionsCard(),
          ],
        ),
      ),
    );
  }
}
