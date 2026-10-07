import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/layanan_model.dart';
import '../models/pengajuan_model.dart';

class DetailLayananPage extends StatefulWidget {
  const DetailLayananPage({
    super.key,
    required this.layanan,
  });

  final LayananModel layanan;

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool _sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    if (_sedangMengirim) return;

    setState(() {
      _sedangMengirim = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    context.read<PengajuanModel>().tambahPengajuan(widget.layanan.nama);

    setState(() {
      _sedangMengirim = false;
    });

    Navigator.pop(context, widget.layanan.nama);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.layanan.nama),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Icon(
                widget.layanan.icon,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                widget.layanan.nama,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Center(
                child: Chip(label: Text(widget.layanan.bidang)),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.layanan.deskripsi,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _sedangMengirim ? null : _ajukanPermohonan,
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _sedangMengirim
                      ? 'Sedang mengirim...'
                      : 'Ajukan Permohonan',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
