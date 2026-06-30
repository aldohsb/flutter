// lib/features/home/widgets/change_name_dialog.dart
// ─────────────────────────────────────────────────────────
// INTI pembelajaran Part 2:
//   → Form + GlobalKey<FormState>: cara kerja form di Flutter
//   → TextFormField: TextField yang terintegrasi dengan Form
//   → FocusNode: kontrol fokus & keyboard secara programatik
//   → StatefulWidget di dalam Dialog
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// services: diperlukan untuk LengthLimitingTextInputFormatter

import 'package:hellow/core/theme/app_colors.dart';
import 'package:hellow/core/utils/validators.dart';

// ── Fungsi helper untuk memanggil dialog ──────────────────
// Pola ini: logika "kapan tampil" tetap di luar widget dialog
Future<String?> showChangeNameDialog({
  required BuildContext context,
  required String currentName,
}) {
  return showDialog<String>(
    // showDialog<String>: dialog ini akan me-return nilai String (nama baru)
    // atau null jika user cancel
    context: context,
    barrierDismissible: false,
    // barrierDismissible: false → klik di luar dialog tidak menutupnya
    // Ini memaksa user membuat pilihan eksplisit (Confirm/Cancel)
    builder: (_) => ChangeNameDialog(currentName: currentName),
    // Underscore (_) untuk parameter context yang tidak dipakai
  );
}

// ── Widget Dialog ─────────────────────────────────────────
class ChangeNameDialog extends StatefulWidget {
  // StatefulWidget karena dialog ini punya state sendiri:
  // - nilai karakter yang sudah diketik (untuk counter)
  // - state validasi form

  const ChangeNameDialog({super.key, required this.currentName});

  final String currentName;

  @override
  State<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {
  // ── Key & Controller & Focus ───────────────────────────
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // GlobalKey<FormState>: kunci unik untuk mengidentifikasi Form di widget tree
  // Digunakan untuk memanggil _formKey.currentState!.validate()

  late final TextEditingController _controller;
  // late: variabel ini akan diinisialisasi sebelum dipakai (di initState)
  // Tidak bisa langsung = TextEditingController() karena butuh widget.currentName

  late final FocusNode _focusNode;
  // FocusNode: objek untuk mengontrol fokus input secara programatik
  // Seperti "remote control" untuk TextField

  int _charCount = 0;
  // Counter karakter yang diketik, ditampilkan real-time

  // ── Lifecycle: initState ──────────────────────────────
  @override
  void initState() {
    super.initState();
    // super.initState() WAJIB dipanggil pertama sebelum kode lain

    _controller = TextEditingController(text: widget.currentName);
    // widget.currentName: akses parameter dari StatefulWidget
    // Inisialisasi dengan nama saat ini sebagai nilai awal

    _focusNode = FocusNode();
    // Buat FocusNode baru

    _charCount = widget.currentName.length;
    // Set counter awal sesuai panjang nama yang sudah ada

    _controller.addListener(_onTextChanged);
    // addListener: setiap kali teks berubah, panggil _onTextChanged
    // Ini adalah observer pattern — controller "diamati" oleh listener
  }

  // ── Lifecycle: dispose ────────────────────────────────
  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    // Hapus listener sebelum dispose untuk mencegah memory leak
    _controller.dispose();
    _focusNode.dispose();
    // FocusNode juga harus di-dispose
    super.dispose();
  }

  // ── Listener: update karakter counter ─────────────────
  void _onTextChanged() {
    setState(() {
      _charCount = _controller.text.length;
      // Update _charCount setiap kali teks berubah
      // setState di sini hanya merender ulang counter, bukan seluruh dialog
    });
  }

  // ── Method: submit form ───────────────────────────────
  void _submit() {
    final bool isValid = _formKey.currentState!.validate();
    // validate(): jalankan semua validator di Form ini
    // Return true jika semua valid, false jika ada yang gagal
    // ! (bang operator): kita yakin currentState tidak null di sini

    if (!isValid) {
      _focusNode.requestFocus();
      // requestFocus(): paksa TextField mendapat fokus kembali
      // Berguna agar user langsung bisa mengetik perbaikan
      return;
    }

    final String newName = _controller.text.trim();
    Navigator.of(context).pop(newName);
    // pop(value): tutup dialog DAN kembalikan nilai
    // Nilai ini diterima oleh showDialog<String> sebagai Future result
  }

  // ── Build ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      // Padding custom agar layout dialog lebih rapi

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What\'s your name?',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            'Enter a name between ${Validators.nameMinLength}–${Validators.nameMaxLength} characters',
            // Pakai konstanta dari Validators agar konsisten
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),

      content: Form(
        key: _formKey,
        // key: hubungkan Form dengan GlobalKey
        // Form adalah widget "wadah" yang mengkoordinasi validasi semua field di dalamnya
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // onUserInteraction: validasi hanya berjalan setelah user mulai mengetik
        // (bukan langsung saat dialog terbuka)
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisSize.min: Column hanya setinggi isinya (tidak full height)
          children: [
            TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              // Hubungkan FocusNode ke TextFormField
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              inputFormatters: [
                LengthLimitingTextInputFormatter(Validators.nameMaxLength),
                // Batasi input langsung di level OS/keyboard
                // User tidak bisa mengetik melebihi batas karakter
              ],
              validator: Validators.validateName,
              // validator: fungsi yang dipanggil saat form.validate()
              // Signature: String? Function(String?)
              decoration: InputDecoration(
                hintText: 'e.g. Hanna, John Doe',
                prefixIcon: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.teal,
                  size: 20,
                ),
                // prefixIcon: ikon di sisi kiri TextField
                suffixText: '$_charCount/${Validators.nameMaxLength}',
                // suffixText: teks di sisi kanan, counter karakter real-time
                suffixStyle: TextStyle(
                  fontSize: 12,
                  color: _charCount > Validators.nameMaxLength * 0.8
                      ? AppColors.coral
                      : AppColors.textSecondary,
                  // Warna berubah ke coral jika sudah mendekati batas
                  // Ternary operator: kondisi ? nilaiJika_true : nilaiJika_false
                ),
              ),
              onFieldSubmitted: (_) => _submit(),
              // onFieldSubmitted: dipanggil saat user tekan Enter/Done
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          // pop() tanpa nilai → return null → caller tahu user cancel
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
          child: const Text('Cancel'),
        ),
        FilledButton(
          // FilledButton: Material 3, lebih tegas dari ElevatedButton
          onPressed: _submit,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.teal,
            foregroundColor: AppColors.textOnDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}