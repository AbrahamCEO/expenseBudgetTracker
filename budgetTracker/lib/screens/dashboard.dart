import 'package:budgetmap/screens/home_screen.dart';
import 'package:budgetmap/screens/login_screen.dart';
import 'package:budgetmap/screens/payments.dart';
import 'package:budgetmap/screens/transactions_screen.dart';
import 'package:budgetmap/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budgetmap/screens/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  int currentIndex = 0;
  var pageViewList = [HomeScreen(), TransactionScreen(), Payments(), Profile()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        selectedIndex: currentIndex, 
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
          },),

      body: pageViewList[currentIndex],
    );
  }
}