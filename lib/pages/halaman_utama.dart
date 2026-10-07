import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_shell.dart';
import '../data/layanan_data.dart';
import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../models/layanan_model.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _index = 0;

  final _titles = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _ubahHalaman(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      BerandaPage(onOpenPage: _ubahHalaman),
      const LayananPage(),
      const WargaPage(),
    ];

    return NavigationShell(
      currentIndex: _index,
      title: _titles[_index],
      onDestinationSelected: _ubahHalaman,
      child: IndexedStack(
        index: _index,
        children: pages,
      ),
    );
  }
}

class BerandaPage extends StatelessWidget {
  const BerandaPage({
    super.key,
    required this.onOpenPage,
  });

  final ValueChanged<int> onOpenPage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nusantara Cerdas Mobile',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Portal layanan warga untuk menemukan dan mengajukan layanan publik dengan lebih mudah.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Akses Cepat',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ActionChip(
              avatar: const Icon(Icons.search),
              label: const Text('Cari Layanan'),
              onPressed: () => onOpenPage(1),
            ),
            ActionChip(
              avatar: const Icon(Icons.person),
              label: const Text('Layanan Favorit'),
              onPressed: () => onOpenPage(2),
            ),
          ],
        ),
      ],
    );
  }
}

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bidang = ['Perizinan', 'Kesehatan', 'Transportasi'];

    return DefaultTabController(
      length: bidang.length,
      child: Column(
        children: [
          const Material(
            child: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Perizinan'),
                Tab(text: 'Kesehatan'),
                Tab(text: 'Transportasi'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: bidang
                  .map((namaBidang) => _DaftarLayanan(bidang: namaBidang))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DaftarLayanan extends StatelessWidget {
  const _DaftarLayanan({required this.bidang});

  final String bidang;

  @override
  Widget build(BuildContext context) {
    final layanan = semuaLayanan
        .where((item) => item.bidang == bidang)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: layanan.length,
      itemBuilder: (context, index) {
        final item = layanan[index];
        return LayananCard(layanan: item);
      },
    );
  }
}

class LayananCard extends StatelessWidget {
  const LayananCard({super.key, required this.layanan});

  final LayananModel layanan;

  @override
  Widget build(BuildContext context) {
    final isFavorit = context.watch<FavoritModel>().isFavorit(layanan.nama);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(layanan.icon),
        ),
        title: Text(
          layanan.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(layanan.deskripsi),
        trailing: IconButton(
          tooltip: isFavorit ? 'Batal favorit' : 'Tandai favorit',
          onPressed: () {
            final favorit = context.read<FavoritModel>();
            if (isFavorit) {
              favorit.batalTandai(layanan.nama);
            } else {
              favorit.tandai(layanan.nama);
            }
          },
          icon: Icon(
            isFavorit ? Icons.star : Icons.star_border,
            color: isFavorit
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
        ),
        onTap: () async {
          await Navigator.pushNamed(
            context,
            '/detail-layanan',
            arguments: layanan.nama,
          );
        },
      ),
    );
  }
}

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Profil Warga',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Warga Nusantara'),
            subtitle: Text('Akun warga aktif'),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Layanan Favorit',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        const _LayananFavorit(),
        const SizedBox(height: 24),
        Text(
          'Keranjang Pengajuan',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        const _DaftarPengajuan(),
      ],
    );
  }
}

class _LayananFavorit extends StatelessWidget {
  const _LayananFavorit();

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritModel>(
      builder: (context, favorit, child) {
        final daftar = semuaLayanan
            .where((item) => favorit.isFavorit(item.nama))
            .toList();

        if (daftar.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Belum ada layanan favorit. Tandai layanan dengan ikon bintang.',
              ),
            ),
          );
        }

        return Column(
          children: daftar
              .map(
                (layanan) => Card(
                  child: ListTile(
                    leading: Icon(layanan.icon),
                    title: Text(layanan.nama),
                    subtitle: Text(layanan.bidang),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/detail-layanan',
                      arguments: layanan.nama,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _DaftarPengajuan extends StatelessWidget {
  const _DaftarPengajuan();

  @override
  Widget build(BuildContext context) {
    return Consumer<PengajuanModel>(
      builder: (context, pengajuan, child) {
        if (pengajuan.layananDiajukan.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('Belum ada layanan yang diajukan.'),
            ),
          );
        }

        return Card(
          child: Column(
            children: [
              ...pengajuan.layananDiajukan.map(
                (nama) => ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(nama),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PengajuanBadgeIcon extends StatelessWidget {
  const PengajuanBadgeIcon({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final total = context.select<PengajuanModel, int>(
      (model) => model.totalPengajuan,
    );

    return Badge(
      isLabelVisible: total > 0,
      label: Text('$total'),
      child: Icon(icon),
    );
  }
}
