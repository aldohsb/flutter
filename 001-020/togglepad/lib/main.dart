import 'package:flutter/material.dart';                            // framework Flutter — wajib ada di setiap file dart yang pakai widget

void main() => runApp(const TogglepadApp());                       // titik masuk app — arrow function karena isinya 1 ekspresi

class TogglepadApp extends StatelessWidget {                       // root widget — tidak perlu state, hanya konfigurasi MaterialApp
  const TogglepadApp({super.key});                                 // super.key diteruskan ke parent agar Flutter bisa identifikasi widget di tree

  @override
  Widget build(BuildContext context) {                             // build dipanggil sekali — StatelessWidget tidak pernah rebuild sendiri
    return MaterialApp(
      title: 'Togglepad',                                          // nama app — muncul di task switcher
      debugShowCheckedModeBanner: false,                           // hilangkan banner merah "DEBUG" di pojok kanan atas
      theme: ThemeData(                                            // konfigurasi tema visual seluruh app
        colorScheme: ColorScheme.fromSeed(                         // buat color scheme dari satu warna benih
          seedColor: const Color(0xFF00897B),                      // hijau teal sebagai warna benih tema
        ),
        useMaterial3: true,                                        // aktifkan Material Design 3 — komponen dan shape terbaru
      ),
      home: const ToggleScreen(),                                  // layar pertama yang tampil saat app dibuka
    );
  }
}

class ToggleScreen extends StatefulWidget {                        // StatefulWidget — menyimpan state bool dari setiap toggle
  const ToggleScreen({super.key});                                 // teruskan key ke parent

  @override
  State<ToggleScreen> createState() => _ToggleScreenState();       // buat objek state yang akan menyimpan data
}

class _ToggleScreenState extends State<ToggleScreen> {
  bool _darkMode    = false;                                       // state toggle 1 — apakah dark mode aktif
  bool _boldText    = false;                                       // state toggle 2 — apakah teks tebal aktif
  bool _largeText   = false;                                       // state toggle 3 — apakah teks besar aktif
  bool _showBorder  = false;                                       // state toggle 4 — apakah border kartu terlihat
  bool _roundedCard = true;                                        // state toggle 5 — apakah kartu sudut bulat (default true)
  bool _showShadow  = true;                                        // state toggle 6 — apakah kartu punya bayangan (default true)

  @override
  Widget build(BuildContext context) {
    final Color bgColor   = _darkMode                              // warna latar — berubah berdasarkan _darkMode
        ? const Color(0xFF121212)                                  // abu sangat gelap saat dark mode aktif
        : const Color(0xFFF5FFFE);                                 // biru muda sangat pucat saat mode terang
    final Color cardColor = _darkMode                              // warna kartu — ikut dark mode
        ? const Color(0xFF1E1E1E)                                  // abu gelap untuk kartu saat dark mode
        : Colors.white;                                            // putih untuk kartu saat mode terang
    final Color textColor = _darkMode                              // warna teks — kontras dengan latar
        ? Colors.white                                             // putih saat gelap agar terbaca
        : const Color(0xFF1A1A1A);                                 // hitam pekat saat terang
    final Color accentColor = _darkMode                            // warna aksen — disesuaikan dengan mode
        ? const Color(0xFF4DB6AC)                                  // teal lebih terang saat dark mode
        : const Color(0xFF00897B);                                 // teal standar saat mode terang

    return Scaffold(
      backgroundColor: bgColor,                                    // latar Scaffold mengikuti state _darkMode
      body: SafeArea(                                              // hindari konten tertutup status bar / notch
        child: SingleChildScrollView(                              // bungkus dengan scroll agar tidak overflow di layar kecil
          padding: const EdgeInsets.all(20),                       // padding 20px di semua sisi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,          // rata kiri — lebih natural untuk teks dan list
            children: [
              _buildHeader(textColor, accentColor),                // bagian judul di atas
              const SizedBox(height: 24),                          // jarak vertikal 24px antara header dan preview
              _buildPreviewCard(                                   // kartu preview yang bereaksi ke semua toggle
                cardColor: cardColor,
                textColor: textColor,
                accentColor: accentColor,
              ),
              const SizedBox(height: 28),                          // jarak antara preview dan panel kontrol
              _buildControlPanel(textColor, accentColor),          // panel daftar toggle
            ],
          ),
        ),
      ),
    );
  }

  // ─── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader(Color textColor, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Togglepad',                                             // judul app
          style: TextStyle(
            fontSize: 32,                                          // ukuran besar — heading utama
            fontWeight: FontWeight.w700,                           // tebal — heading harus menonjol
            color: accentColor,                                    // pakai warna aksen agar berkarakter
          ),
        ),
        const SizedBox(height: 4),                                 // jarak kecil antara judul dan subjudul
        Text(
          'Aktifkan toggle dan lihat kartu berubah',               // deskripsi singkat fungsi app
          style: TextStyle(
            fontSize: 14,                                          // kecil — subjudul tidak perlu besar
            color: textColor.withOpacity(0.55),                    // redup — teks sekunder kurang menonjol
          ),
        ),
      ],
    );
  }

  // ─── PREVIEW CARD ────────────────────────────────────────────────────────────

  Widget _buildPreviewCard({
    required Color cardColor,                                      // required — wajib diisi saat memanggil method ini
    required Color textColor,
    required Color accentColor,
  }) {
    final double fontSize = _largeText ? 17.0 : 14.0;             // ukuran font — besar jika _largeText aktif
    final FontWeight fontWeight = _boldText                        // ketebalan font — tebal jika _boldText aktif
        ? FontWeight.w700
        : FontWeight.w400;

    return AnimatedContainer(                                      // AnimatedContainer — semua perubahan properti dianimasikan otomatis
      duration: const Duration(milliseconds: 300),                 // durasi transisi 300ms — cukup terlihat tapi tidak lambat
      curve: Curves.easeInOut,                                     // kurva accelerate lalu decelerate — terasa natural
      width: double.infinity,                                      // lebar penuh mengikuti parent
      padding: const EdgeInsets.all(20),                           // padding dalam kartu
      decoration: BoxDecoration(
        color: cardColor,                                          // warna kartu beranimasi saat dark mode toggle
        borderRadius: BorderRadius.circular(                       // radius sudut — bulat atau kotak tergantung toggle
          _roundedCard ? 20.0 : 4.0,                              // 20px = bulat, 4px = hampir kotak
        ),
        border: _showBorder                                        // border tampil atau tidak tergantung toggle
            ? Border.all(color: accentColor, width: 2)             // border berwarna aksen saat aktif
            : null,                                                // null = tidak ada border
        boxShadow: _showShadow                                     // bayangan tampil atau tidak tergantung toggle
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),           // bayangan hitam 10% opacity — halus
                  blurRadius: 16,                                  // radius blur bayangan
                  offset: const Offset(0, 4),                      // bayangan 4px ke bawah
                ),
              ]
            : null,                                                // null = tidak ada bayangan
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(                                        // avatar lingkaran — placeholder foto profil
                radius: 22,                                        // radius 22 → diameter 44px
                backgroundColor: accentColor.withOpacity(0.20),   // latar lingkaran — warna aksen transparan
                child: Text(
                  'A',                                             // inisial nama di dalam avatar
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: accentColor,                            // warna huruf = warna aksen
                  ),
                ),
              ),
              const SizedBox(width: 12),                           // jarak antara avatar dan teks nama
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDefaultTextStyle(                        // animasi perubahan style teks secara otomatis
                    duration: const Duration(milliseconds: 250),   // durasi animasi style teks
                    style: TextStyle(
                      fontSize: fontSize,                          // ukuran font bereaksi ke _largeText
                      fontWeight: fontWeight,                      // ketebalan bereaksi ke _boldText
                      color: textColor,                            // warna bereaksi ke _darkMode
                    ),
                    child: const Text('Arya Pratama'),             // nama — konten tetap, hanya style yang berubah
                  ),
                  const SizedBox(height: 2),                       // jarak kecil antara nama dan jabatan
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: fontSize - 2,                      // ukuran jabatan 2pt lebih kecil dari nama
                      fontWeight: fontWeight,
                      color: textColor.withOpacity(0.55),          // redup — jabatan adalah teks sekunder
                    ),
                    child: const Text('Flutter Developer'),        // jabatan — konten tetap
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),                              // jarak antara header kartu dan body teks
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              height: 1.55,                                        // line height 1.55x — nyaman dibaca
            ),
            child: const Text(                                     // teks contoh — konten tidak berubah, style yang berubah
              'Kartu ini bereaksi terhadap semua toggle di bawah. '
              'Coba aktifkan satu per satu untuk melihat efeknya secara langsung.',
            ),
          ),
          const SizedBox(height: 16),                              // jarak sebelum row badge
          Row(
            children: [
              _buildBadge('Flutter', accentColor),                 // badge label teknologi
              const SizedBox(width: 8),
              _buildBadge('Dart', accentColor),
              const SizedBox(width: 8),
              _buildBadge('Mobile', accentColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // padding horizontal lebih besar dari vertikal
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.12),                     // latar badge — warna aksen sangat transparan
        borderRadius: BorderRadius.circular(20),                   // sudut sangat bulat — bentuk pill
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,                                            // kecil — badge adalah label sekunder
          fontWeight: FontWeight.w600,                             // sedikit tebal agar terbaca
          color: accentColor,                                      // warna teks badge = warna aksen
        ),
      ),
    );
  }

  // ─── CONTROL PANEL ───────────────────────────────────────────────────────────

  Widget _buildControlPanel(Color textColor, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kontrol',                                               // judul bagian panel toggle
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor.withOpacity(0.45),                    // redup — label section lebih subtle
            letterSpacing: 1.5,                                    // spasi huruf lebar — efek label kategori
          ),
        ),
        const SizedBox(height: 12),                               // jarak antara label dan daftar toggle
        _buildToggleItem(                                          // setiap toggle dibuat lewat satu method helper
          icon: Icons.dark_mode_rounded,                           // ikon moon — mewakili dark mode
          label: 'Dark Mode',
          description: 'Ubah skema warna ke gelap',               // deskripsi singkat fungsi toggle
          value: _darkMode,                                        // nilai bool saat ini
          onChanged: (v) => setState(() => _darkMode = v),         // v = nilai baru dari Switch — simpan ke state
          textColor: textColor,
          accentColor: accentColor,
        ),
        _buildToggleItem(
          icon: Icons.format_bold_rounded,                         // ikon B tebal
          label: 'Teks Tebal',
          description: 'Ubah font weight menjadi bold',
          value: _boldText,
          onChanged: (v) => setState(() => _boldText = v),
          textColor: textColor,
          accentColor: accentColor,
        ),
        _buildToggleItem(
          icon: Icons.text_increase_rounded,                       // ikon A besar
          label: 'Teks Besar',
          description: 'Perbesar ukuran font di kartu',
          value: _largeText,
          onChanged: (v) => setState(() => _largeText = v),
          textColor: textColor,
          accentColor: accentColor,
        ),
        _buildToggleItem(
          icon: Icons.border_all_rounded,                          // ikon kotak berborder
          label: 'Tampilkan Border',
          description: 'Tambahkan garis tepi pada kartu',
          value: _showBorder,
          onChanged: (v) => setState(() => _showBorder = v),
          textColor: textColor,
          accentColor: accentColor,
        ),
        _buildToggleItem(
          icon: Icons.rounded_corner_rounded,                      // ikon sudut bulat
          label: 'Sudut Bulat',
          description: 'Toggle antara sudut bulat dan kotak',
          value: _roundedCard,
          onChanged: (v) => setState(() => _roundedCard = v),
          textColor: textColor,
          accentColor: accentColor,
        ),
        _buildToggleItem(
          icon: Icons.layers_rounded,                              // ikon lapisan — mewakili shadow/kedalaman
          label: 'Tampilkan Bayangan',
          description: 'Aktifkan efek drop shadow pada kartu',
          value: _showShadow,
          onChanged: (v) => setState(() => _showShadow = v),
          textColor: textColor,
          accentColor: accentColor,
          showDivider: false,                                       // item terakhir — tidak perlu divider di bawah
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required IconData icon,                                        // ikon di kiri label
    required String label,                                         // teks label utama toggle
    required String description,                                   // teks deskripsi kecil di bawah label
    required bool value,                                           // nilai bool toggle saat ini
    required ValueChanged<bool> onChanged,                         // callback saat toggle digeser — terima bool baru
    required Color textColor,
    required Color accentColor,
    bool showDivider = true,                                       // parameter opsional dengan default true
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),       // padding atas-bawah tiap item
          child: Row(
            children: [
              Container(
                width: 38,                                         // kotak ikon berukuran tetap
                height: 38,
                decoration: BoxDecoration(
                  color: value                                      // latar ikon — berwarna jika aktif, abu jika tidak
                      ? accentColor.withOpacity(0.15)
                      : textColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),         // sudut membulat
                ),
                child: Icon(
                  icon,
                  size: 20,                                        // ukuran ikon 20px — pas untuk kotak 38px
                  color: value ? accentColor : textColor.withOpacity(0.40), // ikon berwarna aksen jika aktif
                ),
              ),
              const SizedBox(width: 14),                           // jarak antara ikon dan teks
              Expanded(                                            // Expanded agar teks mengisi sisa ruang sebelum Switch
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,               // sedikit tebal — label utama
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 1),                     // jarak tipis antara label dan deskripsi
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,                              // kecil — deskripsi adalah teks sekunder
                        color: textColor.withOpacity(0.50),        // redup
                      ),
                    ),
                  ],
                ),
              ),
              Switch(                                              // widget toggle bawaan Flutter
                value: value,                                      // status saat ini — true = aktif, false = nonaktif
                onChanged: onChanged,                              // fungsi yang dipanggil saat user menggeser
                activeThumbColor: accentColor,                          // warna thumb (lingkaran) saat aktif
                activeTrackColor: accentColor.withOpacity(0.30),   // warna track (latar) saat aktif
              ),
            ],
          ),
        ),
        if (showDivider)                                           // tampilkan divider hanya jika bukan item terakhir
          Divider(
            height: 1,                                             // tinggi total widget Divider (bukan tebal garis)
            thickness: 0.5,                                        // tebal garis divider
            color: textColor.withOpacity(0.08),                    // sangat transparan — hampir tidak terlihat
          ),
      ],
    );
  }
}