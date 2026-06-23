import 'package:flutter/material.dart';                            // import framework Flutter
import '../models/slider_config.dart';                             // import SliderConfig dan sliderConfigs
import '../widgets/preview_box.dart';                              // import widget PreviewBox

class SliderScreen extends StatefulWidget {                        // StatefulWidget — menyimpan nilai tiap slider
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  late Map<String, double> _values;                                // Map id → nilai slider saat ini — late karena diisi di initState

  @override
  void initState() {
    super.initState();                                             // panggil super sebelum kode sendiri — wajib
    _values = {                                                    // inisialisasi nilai tiap slider dari defaultValue di model
      for (final config in sliderConfigs)                          // for-in dalam Map literal — buat entry untuk setiap config
        config.id: config.defaultValue,                            // key = id slider, value = nilai default
    };
  }

  double _get(String id) => _values[id]!;                         // helper getter — ! aman karena semua id diisi di initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,     // warna latar dari tema — konsisten dengan Material 3
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),                                        // bagian judul di atas
            _buildPreviewArea(),                                   // area preview kotak di tengah
            _buildSliderPanel(),                                   // panel semua slider di bawah
          ],
        ),
      ),
    );
  }

  // ─── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),          // padding: kiri 24, atas 24, kanan 24, bawah 0
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'sizeSlider',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,        // warna teal dari tema
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Geser untuk mengubah tampilan kotak',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurface       // warna teks utama dari tema
                  .withOpacity(0.50),                              // redup — teks sekunder
            ),
          ),
        ],
      ),
    );
  }

  // ─── PREVIEW AREA ───────────────────────────────────────────────────────────

  Widget _buildPreviewArea() {
    return Expanded(                                               // Expanded — area preview mengambil semua sisa ruang vertikal
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest // warna abu sangat muda dari Material 3
                .withOpacity(0.50),
            borderRadius: BorderRadius.circular(20),               // sudut bulat pada area preview
          ),
          child: PreviewBox(                                       // widget preview — terima semua nilai dari state
            size: _get('size'),                                    // ambil nilai slider 'size'
            radius: _get('radius'),                                // ambil nilai slider 'radius'
            opacity: _get('opacity'),                              // ambil nilai slider 'opacity'
            elevation: _get('elevation'),                          // ambil nilai slider 'elevation'
          ),
        ),
      ),
    );
  }

  // ─── SLIDER PANEL ───────────────────────────────────────────────────────────

  Widget _buildSliderPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,              // warna permukaan dari tema
        borderRadius: const BorderRadius.vertical(                 // BorderRadius.vertical — hanya atas yang bulat
          top: Radius.circular(28),                                // pojok kiri-atas dan kanan-atas bulat
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),                 // bayangan sangat tipis di atas panel
            blurRadius: 12,
            offset: const Offset(0, -3),                           // offset negatif Y = bayangan ke atas
          ),
        ],
      ),
      child: Column(
        children: [
          for (final config in sliderConfigs)                      // for-in langsung di dalam children — buat slider per config
            _buildSliderItem(config),
        ],
      ),
    );
  }

  Widget _buildSliderItem(SliderConfig config) {
    final double currentValue = _get(config.id);                   // nilai slider saat ini untuk config ini
    final Color primary = Theme.of(context).colorScheme.primary;   // warna aksen dari tema

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),                  // jarak bawah antar item slider
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,      // label di kiri, nilai di kanan
            children: [
              Text(
                config.label,                                       // label slider dari model, misal "Ukuran Kotak"
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(               // padding chip nilai
                    horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.10),                 // latar chip — transparan
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${currentValue.toInt()}${config.unit}',          // tampilkan nilai + satuan, misal "120px"
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primary,                                  // teks chip warna aksen
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),                               // jarak kecil antara label dan slider
          SliderTheme(                                              // SliderTheme — kustomisasi visual Slider
            data: SliderTheme.of(context).copyWith(                // copyWith — salin tema slider saat ini lalu ubah sebagian
              activeTrackColor: primary,                           // warna track kiri (sudah diisi)
              inactiveTrackColor: primary.withOpacity(0.15),       // warna track kanan (belum diisi) — redup
              thumbColor: primary,                                  // warna bulatan thumb
              overlayColor: primary.withOpacity(0.12),             // warna lingkaran transparan saat thumb ditekan
              trackHeight: 4,                                       // tebal track 4px
              thumbShape: const RoundSliderThumbShape(             // bentuk thumb
                enabledThumbRadius: 8,                             // radius thumb 8px — tidak terlalu besar
              ),
            ),
            child: Slider(
              value: currentValue,                                  // nilai saat ini dari state
              min: config.min,                                      // batas minimum dari model
              max: config.max,                                      // batas maksimum dari model
              divisions: config.divisions,                          // jumlah langkah dari model
              onChanged: (double newValue) {                        // dipanggil setiap kali thumb digeser
                setState(() {
                  _values[config.id] = newValue;                   // update nilai di Map — Flutter rebuild preview
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}