import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lapor_book_12764/components/status_dialog.dart';
import 'package:lapor_book_12764/components/styles.dart';
import 'package:lapor_book_12764/components/vars.dart';
import 'package:lapor_book_12764/models/akun.dart';
import 'package:lapor_book_12764/models/laporan.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future launch(String url) async {
    if (url == '') return;
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Tidak dapat memanggil $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Akun akun = arguments['akun'];
    final Laporan laporan = arguments['laporan'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Detail Laporan",
          style: headerStyle(
            level: 3,
            dark: false,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  laporan.judul,
                  style: headerStyle(level: 2),
                ),
                SizedBox(
                  height: 15,
                ),
                laporan.gambar != ''
                    ? Image.network(laporan.gambar!)
                    : Image.asset(
                        'assets/bg-default.png',
                      ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStatus(
                      laporan.status,
                      laporan.status == 'Posted'
                          ? warnaStatus[0] : laporan.status == 'Process'
                          ? warnaStatus[1] : warnaStatus[2],
                      Colors.white
                    ),
                    textStatus(laporan.instansi, Colors.white, Colors.black)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  title: Text("Nama Pelapor"),
                  subtitle: Text(laporan.nama),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text("Tanggal Laporan"),
                  subtitle:
                      Text(DateFormat('dd MMMM yyyy').format(laporan.tanggal)),
                  leading: Icon(Icons.date_range),
                  trailing: IconButton(
                    onPressed: () {
                      launch(laporan.maps);
                    },
                    icon: Icon(Icons.location_on),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Deskripsi",
                  style: headerStyle(level: 2),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(laporan.deskripsi ?? ''),
                SizedBox(
                  height: 50,
                ),
                if (akun.role == 'admin')
                  Container(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatusDialog(
                              laporan: laporan,
                            );
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Ubah Status"),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container textStatus(String text, var bgColor, var fgColor) {
    return Container(
      alignment: Alignment.center,
      width: 150,
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: 1, color: primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Text(
        text,
        style: TextStyle(
          color: fgColor,
        ),
      ),
    );
  }
}
