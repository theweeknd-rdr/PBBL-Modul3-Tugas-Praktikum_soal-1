import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/layanan_data.dart';
import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'pages/detail_layanan_page.dart';
import 'pages/halaman_utama.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
      ],
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanUtama(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail-layanan') {
          final namaLayanan = settings.arguments as String;
          final layanan = semuaLayanan.firstWhere(
            (item) => item.nama == namaLayanan,
          );

          return MaterialPageRoute(
            builder: (_) => DetailLayananPage(layanan: layanan),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
