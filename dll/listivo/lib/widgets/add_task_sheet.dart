// lib/widgets/add_task_sheet.dart
// Bottom sheet berisi form TextField untuk menambahkan tugas baru

import 'package:flutter/material.dart'; // TextField, FilledButton, dsb
import '../constants/app_constants.dart'; // padding standar

class AddTaskSheet extends StatefulWidget {
  // Callback dipanggil membawa teks judul saat pengguna menekan tombol tambah
  final ValueChanged<String> onSubmit;

  const AddTaskSheet({super.key, required this.onSubmit});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  // Controller untuk membaca dan mengosongkan isi TextField
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // dibuat sekali saat sheet pertama muncul
  }

  @override
  void dispose() {
    _controller.dispose(); // wajib dispose agar tidak memory leak
    super.dispose();
  }

  // Dipanggil saat tombol "Tambah tugas" ditekan, atau keyboard "done" ditekan
  void _handleSubmit() {
    final text = _controller.text.trim(); // buang spasi kosong di awal/akhir
    if (text.isEmpty) return; // batalkan submit jika pengguna tidak mengetik apa pun
    widget.onSubmit(text); // kirim judul tugas baru ke HomeScreen
    Navigator.of(context).pop(); // tutup bottom sheet setelah berhasil submit
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding bawah mengikuti tinggi keyboard agar TextField tidak tertutup
      padding: EdgeInsets.only(
        left: AppConstants.paddingLarge,
        right: AppConstants.paddingLarge,
        top: AppConstants.paddingLarge,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppConstants.paddingLarge,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // sheet hanya setinggi isinya
        crossAxisAlignment: CrossAxisAlignment.stretch, // tombol melebar penuh
        children: [
          Text('Tugas baru', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12), // jarak antara judul sheet dan input
          TextField(
            controller: _controller,
            autofocus: true, // langsung fokus agar pengguna bisa langsung mengetik
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _handleSubmit(), // submit lewat tombol enter keyboard
            decoration:
                const InputDecoration(hintText: 'Contoh: Belajar Flutter'),
          ),
          const SizedBox(height: 16), // jarak antara input dan tombol
          FilledButton(
            onPressed: _handleSubmit,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Tambah tugas'),
            ),
          ),
        ],
      ),
    );
  }
}