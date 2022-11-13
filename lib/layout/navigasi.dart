import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;
import 'package:bmnav_null_safety/bmnav_null_safety.dart';
import 'homecustomer.dart';
import 'akun.dart';
import 'transaksi.dart';

class Navigasi extends StatefulWidget {
  @override
  _NavigasiState createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  late int _currentIndex;
  var page;

  @override
  void initState() {
    _currentIndex = 0;
    page = Customer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: page,
      bottomNavigationBar: bmnav.BottomNav(
        color: Colors.white,
        labelStyle: bmnav.LabelStyle(
          visible: true,
          showOnSelect: false,
          onSelectTextStyle: TextStyle(
            color: Colors.grey,
            height: 1.8,
          ),
        ),
        iconStyle: bmnav.IconStyle(
          color: Colors.grey[400],
          onSelectSize: 22.0,
          size: 22.0,
        ),
        elevation: 6.0,
        onTap: (i) {
          _currentIndex = i;
          _currentPage(i);
        },
        index: _currentIndex,
        items: [
          bmnav.BottomNavItem(
            Icons.home,
            label: 'Home',
          ),
          bmnav.BottomNavItem(
            Icons.home,
            label: 'Transaksi',
          ),
          bmnav.BottomNavItem(
            Icons.person,
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  void _currentPage(int i) {
    if (i == 0) {
      setState(() {
        page = Customer();
      });
    } else if (i == 1) {
      setState(() {
        page = Transaksi();
      });
    } else {
      setState(() {
        page = Akun();
      });
    }
  }
}
