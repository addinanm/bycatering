import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  _HomeCustomer createState() => _HomeCustomer();
}

class _HomeCustomer extends State<Customer>
    with SingleTickerProviderStateMixin {
  late TabController _tabcController;

  final _formkey = GlobalKey<FormState>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _tabcController = TabController(vsync: this, length: 7);
    super.initState();
  }

  @override
  void dispose() {
    _tabcController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        textTheme: TextTheme(),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text(
          'Catering Delivery',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Vacela',
          ),
          textAlign: TextAlign.start,
        ),
        bottom: TabBar(
          controller: _tabcController,
          indicatorColor: Colors.white,
          labelColor: Colors.lightBlue[800],
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          unselectedLabelColor: Color(0xFFCDCDCD),
          tabs: [
            Tab(
              child: Text('Semua',
                  style: TextStyle(
                    fontFamily: 'Vacela',
                    fontSize: 16.0,
                  )),
            ),
            Tab(
              child: Text('Rekomendasi',
                  style: TextStyle(
                    fontFamily: 'Vacela',
                    fontSize: 16.0,
                  )),
            ),
            Tab(
              child: Text('Promo',
                  style: TextStyle(
                    fontFamily: 'Vacela',
                    fontSize: 16.0,
                  )),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('produk').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ItemProduk(
              listProduk: snapshot.data.documents,
            );
          },
        ),
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final List<DocumentSnapshot> listProduk;

  const ItemProduk({Key? key, required this.listProduk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: listProduk == null ? 0 : listProduk.length,
      itemBuilder: (BuildContext context, int index) {
        var snapshot;
        var data = snapshot.data.documents as Map;
        //String idProduk = listProduk[index].data["id_produk"].toString();

        return Text(
          data["id_produk"],
        );
      },
    );
  }
}

// class Customer extends StatelessWidget {
//   const Customer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("Ini adalah halaman  Student"),
//     );
//   }
// }
