import 'package:flutter/material.dart';

class LayananModel {
  const LayananModel({
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.icon,
  });

  final String nama;
  final String bidang;
  final String deskripsi;
  final IconData icon;
}
