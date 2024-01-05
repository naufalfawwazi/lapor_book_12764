import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:lapor_book_12764/components/styles.dart';
import 'package:lapor_book_12764/components/vars.dart';
import 'package:lapor_book_12764/models/akun.dart';
import 'package:lapor_book_12764/models/laporan.dart';

class ListItem extends StatefulWidget {
  final Laporan laporan;

  const ListItem({super.key, required this.laporan});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.laporan.gambar != ''
              ? Image.network(
                  widget.laporan.gambar!,
                  width: 130,
                  height: 130,
                )
              : Image.asset(
                  'assets/bg-default.png',
                  width: 130,
                  height: 130,
                ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              border: Border.symmetric(horizontal: BorderSide(width: 2)),
            ),
            child: Text(
              widget.laporan.judul,
              style: headerStyle(level: 4),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      color: widget.laporan.status == 'Posted'
                      ? warnaStatus[0] : widget.laporan.status == 'Process'
                      ? warnaStatus[1] : warnaStatus[2],
                      border: Border(
                        right: BorderSide(width: 2),
                      ),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(8))),
                  child: Text(
                    widget.laporan.status,
                    style: headerStyle(level: 5, dark: false),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(widget.laporan.tanggal),
                    style: headerStyle(level: 5, dark: false),
                  ),
                  decoration: BoxDecoration(
                      color: successColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}