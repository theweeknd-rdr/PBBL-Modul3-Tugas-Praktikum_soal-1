import 'package:flutter/foundation.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _layananDiajukan = [];

  List<String> get layananDiajukan => List.unmodifiable(_layananDiajukan);

  int get totalPengajuan => _layananDiajukan.length;

  void tambahPengajuan(String namaLayanan) {
    _layananDiajukan.add(namaLayanan);
    notifyListeners();
  }

  void hapusPengajuan(String namaLayanan) {
    _layananDiajukan.remove(namaLayanan);
    notifyListeners();
  }
}
