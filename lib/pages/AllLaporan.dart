import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lapor_book_12764/models/akun.dart';
import 'package:lapor_book_12764/models/laporan.dart';

class AllLaporan extends StatefulWidget {
  final Akun akun;
  AllLaporan({super.key, required this.akun});

  @override
  State<AllLaporan> createState() => _AllLaporanState();
}

class _AllLaporanState extends State<AllLaporan> {
  final _firestore = FirebaseFirestore.instance;

  List<Laporan> listLaporan = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 1.234,
            ),
            itemCount: 1,
            itemBuilder: (context, index) {
              // return ListItem(
              //   laporan: listLaporan[index],
              //   akun: widget.akun,
              //   isLaporanku: false,
              // );
            }),
      ),
    );
  }
}