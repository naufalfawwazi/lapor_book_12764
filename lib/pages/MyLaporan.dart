import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book_12764/components/list_item.dart';
import 'package:lapor_book_12764/models/akun.dart';
import 'package:lapor_book_12764/models/laporan.dart';

class MyLaporan extends StatefulWidget {
  final Akun akun;

  MyLaporan({super.key, required this.akun});

  @override
  State<MyLaporan> createState() => _MyLaporanState();
}

class _MyLaporanState extends State<MyLaporan> {
  final _db = FirebaseFirestore.instance;

  List<Laporan> listLaporan = [];

  void getLaporan() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _db.collection('laporan').where('uid', isEqualTo: widget.akun.uid).get();

      setState(() {
        listLaporan.clear();
        for (var documents in querySnapshot.docs) {
          Laporan currentLaporan = Laporan(
              uid: documents.data()['uid'],
              docId: documents.data()['docId'],
              judul: documents.data()['judul'],
              instansi: documents.data()['instansi'],
              nama: documents.data()['nama'],
              status: documents.data()['status'],
              tanggal: documents.data()['tanggal'].toDate(),
              maps: documents.data()['maps'],
              deskripsi: documents.data()['deskripsi'],
              gambar: documents.data()['gambar']
          );

          currentLaporan.likeUid = [];
          if (documents.data().containsKey('likeUid')) {
            for (var uid in documents.data()['likeUid']) {
              currentLaporan.likeUid?.add(uid);
            }
          }

          currentLaporan.likeTimestamp = [];
          if (documents.data().containsKey('likeTimestamp')) {
            for (var timestamp in documents.data()['likeTimestamp']) {
              Timestamp currentTimestamp = timestamp;
              currentLaporan.likeTimestamp?.add(currentTimestamp.toDate());
            }
          }

          listLaporan.add(currentLaporan);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getLaporan();
  }

  @override
  Widget build(BuildContext context) {
    getLaporan();
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(20),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1/1.232
            ),
            itemCount: listLaporan.length,
            itemBuilder: (context, index) {
              return ListItem(
                akun: widget.akun,
                laporan: listLaporan[index],
                isLaporanku: true,
              );
            }),
      ),
    );
  }
}
