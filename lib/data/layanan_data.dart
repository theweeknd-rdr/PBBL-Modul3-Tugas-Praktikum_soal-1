import 'package:flutter/material.dart';
import '../models/layanan_model.dart';

const List<LayananModel> semuaLayanan = [
  LayananModel(
    nama: 'Izin Usaha Mikro',
    bidang: 'Perizinan',
    deskripsi: 'Pengajuan izin usaha mikro secara digital dan terarah.',
    icon: Icons.business,
  ),
  LayananModel(
    nama: 'Kartu Keluarga',
    bidang: 'Perizinan',
    deskripsi: 'Informasi dan pengajuan layanan administrasi kartu keluarga.',
    icon: Icons.family_restroom,
  ),
  LayananModel(
    nama: 'Puskesmas Terdekat',
    bidang: 'Kesehatan',
    deskripsi: 'Informasi layanan puskesmas dan kebutuhan kesehatan warga.',
    icon: Icons.local_hospital,
  ),
  LayananModel(
    nama: 'Vaksinasi Warga',
    bidang: 'Kesehatan',
    deskripsi: 'Pengajuan dan informasi jadwal vaksinasi warga.',
    icon: Icons.vaccines,
  ),
  LayananModel(
    nama: 'Kartu Transportasi',
    bidang: 'Transportasi',
    deskripsi: 'Layanan informasi dan pengajuan kartu transportasi kota.',
    icon: Icons.directions_bus,
  ),
  LayananModel(
    nama: 'Pengaduan Jalan',
    bidang: 'Transportasi',
    deskripsi: 'Laporkan kerusakan jalan atau fasilitas transportasi.',
    icon: Icons.add_road,
  ),
];
