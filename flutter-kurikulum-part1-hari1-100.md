# 🐣 Flutter Kurikulum — Part 1: Hari 1–100
### Level: Absolute Beginner → Beginner
> Pace sangat lambat di awal. Fokus pada pondasi, bukan kecepatan.

---

## 🗓️ FASE 1 — Mengenal Dunia Flutter (Hari 1–20)
> Tujuan: Bisa install, paham konsep dasar, dan nyaman dengan lingkungan Flutter

---

### Hari 1 : Apa Itu Flutter & Dart?
* Mengenal Flutter — framework apa ini dan kenapa populer
* Perbedaan Flutter vs React Native vs native Android/iOS
* Mengenal bahasa Dart — kenapa Flutter pakai Dart
* Melihat contoh-contoh aplikasi yang dibuat dengan Flutter

**Project terkait : `flutter_explore`** *(bukan project koding, project riset)*
- Buka YouTube, cari 3 video demo aplikasi Flutter yang kamu suka
- Screenshot UI-nya, simpan di folder, dan tulis catatan: "Saya ingin bisa bikin ini"
- Tujuan: Membangun motivasi dengan visualisasi tujuan akhir

---

### Hari 2 : Instalasi Flutter & Setup Environment
* Install Flutter SDK (ikuti flutter.dev resmi)
* Install Android Studio & setup Android Emulator
* Install VS Code + ekstensi Flutter & Dart
* Menjalankan `flutter doctor` dan memahami outputnya

**Project terkait : `hello_setup`**
- Buat project Flutter pertama dengan `flutter create hello_setup`
- Jalankan di emulator — lihat counter app default muncul
- Tujuan: Memastikan environment benar-benar berjalan

---

### Hari 3 : Struktur Folder Project Flutter
* Memahami folder `lib/`, `android/`, `ios/`, `pubspec.yaml`
* Mengenal file `main.dart` — titik awal semua Flutter app
* Apa itu `pubspec.yaml` — tempat mendaftarkan dependency & asset
* Memahami `runApp()` dan fungsinya

**Project terkait : `struktur_explorer`**
- Buka project `hello_setup` kemarin
- Buka setiap folder dan baca isinya satu per satu
- Tulis di Notion/notes: "Folder ini fungsinya untuk apa"
- Hapus semua komentar di `main.dart` agar kode terlihat lebih bersih

---

### Hari 4 : Dart Basics — Variabel & Tipe Data
* Tipe data dasar: `int`, `double`, `String`, `bool`
* Deklarasi variabel: `var`, `final`, `const`
* Perbedaan `final` dan `const` (sangat penting di Flutter!)
* String interpolation: `"Halo $nama"`

**Project terkait : `dart_playground`**
- Buat file `main.dart` kosong, tulis 10 variabel berbeda tipe data
- Print semua variabel ke konsol menggunakan `print()`
- Coba ubah nilai variabel `final` — lihat error apa yang muncul
- Tujuan: Familiar dengan error message Dart

---

### Hari 5 : Dart Basics — Operator & Kondisi
* Operator aritmatika, perbandingan, dan logika
* `if`, `else if`, `else`
* Ternary operator: `kondisi ? jika_ya : jika_tidak`
* `switch - case`

**Project terkait : `kalkulator_konsol`**
- Buat program di `main.dart` yang mensimulasikan kalkulator sederhana
- Gunakan `if-else` untuk memilih operasi (+, -, *, /)
- Print hasil ke konsol
- Tujuan: Latihan logika sebelum masuk Flutter UI

---

### Hari 6 : Dart Basics — List & Loop
* Membuat dan mengakses `List`
* Loop: `for`, `for-in`, `while`
* Method list dasar: `.add()`, `.remove()`, `.length`
* `forEach` dan lambda sederhana

**Project terkait : `daftar_mimpi`**
- Buat List berisi 10 hal yang ingin kamu capai tahun ini
- Loop list tersebut dan print setiap item dengan nomor urut
- Filter hanya item yang panjang karakternya > 10 menggunakan `if` di dalam loop

---

### Hari 7 : Dart Basics — Map & Function
* Membuat `Map<String, dynamic>`
* Mengakses value map dengan key
* Membuat function sederhana dengan parameter dan return value
* Mengenal `void` function

**Project terkait : `kartu_identitas`**
- Buat Map yang berisi data dirimu: nama, umur, kota, hobi
- Buat function `printIdentitas(Map data)` yang print semua data rapi
- Tambahkan function `sapa(String nama)` yang return String "Halo, $nama!"

---

### Hari 8 : Dart — Null Safety Dasar
* Apa itu null safety dan kenapa Dart memakainya
* Nullable vs non-nullable: `String?` vs `String`
* Null-aware operator: `??`, `?.`
* Cara menangani nilai yang mungkin null

**Project terkait : `null_detective`**
- Buat 5 variabel nullable dan 5 non-nullable
- Coba print sebelum diisi nilai — lihat apa yang terjadi
- Gunakan `??` untuk memberi nilai default jika null
- Tujuan: Memahami konsep yang sering jadi sumber bug Flutter

---

### Hari 9 : Dart — OOP Dasar (Class & Object)
* Membuat `class` sederhana
* Constructor dasar
* Property dan method dalam class
* Membuat object dari class

**Project terkait : `class_karakter_game`**
- Buat class `Karakter` dengan property: nama, hp, level, senjata
- Buat constructor untuk mengisi semua property
- Buat method `serang()` yang print "karakter menyerang dengan senjata"
- Buat 3 object Karakter berbeda dan panggil method `serang()`

---

### Hari 10 : Dart — OOP Lanjut (Inheritance & Interface)
* Konsep inheritance: `extends`
* Override method
* Abstract class dasar
* Kenapa OOP penting untuk Flutter (Widget adalah Class!)

**Project terkait : `rpg_class_system`**
- Buat abstract class `Hero` dengan method `skill()`
- Buat 3 subclass: `Warrior`, `Mage`, `Archer` — masing-masing override `skill()`
- Buat list berisi ketiga hero, loop dan panggil `skill()` semua
- Tujuan: Memahami polymorphism yang nanti sering dipakai di Flutter

---

### Hari 11 : Widget Pertamamu — Hello Flutter UI!
* Apa itu Widget di Flutter (EVERYTHING is a widget)
* Perbedaan `StatelessWidget` vs `StatefulWidget` (pengantar)
* `MaterialApp` dan `Scaffold`
* Widget `Text`, `Center`, `Container`

**Project terkait : `kartu_nama_digital`**
- Buat app yang menampilkan kartu nama dirimu di layar
- Tampilkan: Nama besar, jabatan, dan kota
- Gunakan `Container` untuk memberi warna latar berbeda
- Tujuan: Output visual pertamamu!

---

### Hari 12 : Layout Dasar — Column & Row
* Widget `Column` — menyusun widget secara vertikal
* Widget `Row` — menyusun widget secara horizontal
* `mainAxisAlignment` dan `crossAxisAlignment`
* Padding menggunakan `SizedBox`

**Project terkait : `profil_sederhana`**
- Buat halaman profil dengan Column berisi: foto placeholder (Container bulat), nama, bio singkat
- Tambahkan Row berisi 3 angka statistik: Posts, Followers, Following
- Tujuan: Mulai memahami susun-menyusun layout

---

### Hari 13 : Styling Widget — Color, Font, Padding
* `TextStyle`: ukuran font, warna, bold, italic
* `EdgeInsets` untuk padding dan margin
* `BoxDecoration` pada Container: warna, border radius, shadow
* Warna di Flutter: `Colors.xxx` dan hex `Color(0xFF...)`

**Project terkait : `quote_card`**
- Buat sebuah kartu kutipan motivasi yang indah
- Kartu punya background gradient, teks kutipan besar, nama author kecil
- Buat 3 kartu dengan warna berbeda menggunakan Column
- Tujuan: Latihan styling yang ekspresif

---

### Hari 14 : Image & Icon
* Menampilkan icon dengan `Icon` widget
* Menampilkan gambar dari internet: `Image.network()`
* Menampilkan gambar lokal: `Image.asset()`
* Daftarkan asset di `pubspec.yaml`

**Project terkait : `galeri_hewan`**
- Buat app dengan 5 gambar hewan lucu dari internet (pakai Image.network)
- Di bawah setiap gambar tampilkan nama hewan dan icon yang relevan
- Susun dalam Column yang bisa di-scroll (ListView — pengantar)

---

### Hari 15 : Button & Interaksi Pertama
* `ElevatedButton`, `TextButton`, `OutlinedButton`
* `onPressed` callback — reaksi pertama terhadap aksi user
* `IconButton`
* Menampilkan `SnackBar` sederhana saat tombol ditekan

**Project terkait : `tombol_ajaib`**
- Buat halaman dengan 5 tombol berbeda warna
- Setiap tombol ditekan menampilkan SnackBar berbeda
- Tombol terakhir: ganti warna background halaman saat ditekan (intro StatefulWidget)
- Tujuan: Pertama kalinya app "bereaksi" terhadap input user!

---

### Hari 16 : StatefulWidget — State Pertamamu
* Apa itu State? Kenapa UI perlu berubah?
* Membuat `StatefulWidget` dari awal
* `setState()` — cara memberitahu Flutter untuk rebuild UI
* Contoh: counter, toggle, kondisi tampil/sembunyi

**Project terkait : `mood_tracker_mini`**
- Buat app 5 tombol emoji mood (😊😐😢😡🥳)
- Ketika ditekan, mood yang terpilih ditampilkan besar di tengah layar
- Warna background berubah sesuai mood yang dipilih
- Tujuan: Memahami setState secara nyata

---

### Hari 17 : TextField & Input User
* Widget `TextField` untuk menerima teks dari user
* `TextEditingController` untuk mengambil nilai input
* `onChanged` vs `onSubmitted`
* Validasi input sederhana (cek apakah kosong)

**Project terkait : `generator_sapaan`**
- Buat app dengan TextField untuk input nama user
- Ada tombol "Sapa Aku!"
- Setelah tombol ditekan, muncul sapaan personal: "Halo [nama], selamat datang di Flutter! 🎉"
- Tambahkan validasi: jika nama kosong, tampilkan pesan error

---

### Hari 18 : ListView — Daftar Item
* `ListView` vs `ListView.builder`
* Kapan pakai yang mana (performa)
* `ListTile` widget
* `Divider` sebagai pemisah

**Project terkait : `daftar_film_favorit`**
- Buat List berisi minimal 15 film favoritmu (judul, genre, tahun)
- Tampilkan dalam `ListView.builder` menggunakan `ListTile`
- Setiap ListTile punya icon genre, judul film, dan subtitle tahun
- Tujuan: Memahami rendering list yang efisien

---

### Hari 19 : Navigator — Pindah Halaman
* Konsep routing di Flutter
* `Navigator.push()` dan `Navigator.pop()`
* Membuat halaman kedua (halaman detail)
* Mengirim data antar halaman lewat constructor

**Project terkait : `ensiklopedia_planet`**
- Halaman utama: daftar 8 planet tata surya dalam ListView
- Ketika planet ditekan, pindah ke halaman detail planet
- Halaman detail menampilkan nama planet, deskripsi singkat, dan warna khas planet
- Tujuan: Multi-halaman pertamamu!

---

### Hari 20 : Review & Mini Project Penutup Fase 1
* Review semua konsep Hari 1–19
* Perbaiki pemahaman yang masih bingung
* Refactor kode yang sudah dibuat agar lebih rapi
* Persiapan untuk fase berikutnya

**Project terkait : `app_perkenalan_diri`**
- Buat app 3 halaman: Halaman Splash (nama + tagline), Halaman Profil (info diri + foto), Halaman Hobi (list hobi dalam ListView)
- Navigasi antar halaman dengan tombol
- Ini adalah "kartu nama digital" versi lengkap milikmu
- Gunakan semua yang sudah dipelajari di Fase 1

---

## 🗓️ FASE 2 — Membangun UI yang Lebih Kaya (Hari 21–50)
> Tujuan: Bisa membuat UI yang layak dan rapi, mulai memahami widget-widget penting

---

### Hari 21 : AppBar & Bottom Navigation
* `AppBar`: title, actions, leading
* `BottomNavigationBar` dasar
* Mengatur halaman aktif dengan state
* `SafeArea` — menghindari notch dan status bar

**Project terkait : `app_cuaca_shell`** *(hanya UI, belum ada data nyata)*
- Buat shell app dengan 4 tab bawah: Beranda, Cari, Favorit, Profil
- Setiap tab menampilkan halaman kosong dengan teks nama halaman
- AppBar berubah judul sesuai tab aktif
- Tujuan: Belajar struktur navigasi tab

---

### Hari 22 : Stack & Positioned
* Widget `Stack` — menumpuk widget
* `Positioned` untuk mengatur posisi dalam Stack
* Kasus penggunaan: overlay teks di atas gambar
* `Align` widget

**Project terkait : `kartu_game_pokemon_style`**
- Buat kartu dengan gambar latar (Container berwarna)
- Tumpuk di atasnya: nama karakter di pojok atas, HP di pojok kanan atas, badge tipe di pojok bawah
- Buat 3 kartu berbeda dalam Row
- Tujuan: Belajar layout yang lebih kompleks dan kreatif

---

### Hari 23 : Expanded & Flexible
* `Expanded` dalam Row/Column
* `Flexible` dan perbedaannya dengan Expanded
* `flex` property untuk mengatur proporsi
* Kombinasi dengan `SizedBox`

**Project terkait : `dashboard_statistik_mini`**
- Buat layout dashboard dengan Row yang berisi 3 kartu statistik
- Kartu pertama dan ketiga masing-masing punya flex:1, kartu tengah flex:2
- Setiap kartu punya angka besar, label kecil, dan ikon
- Tujuan: Layout proporsional seperti app nyata

---

### Hari 24 : Wrap & GridView
* `Wrap` — layout yang otomatis wrap ke baris baru
* `GridView.count` — grid dengan jumlah kolom tetap
* `GridView.builder` — grid yang efisien untuk banyak item
* `crossAxisSpacing` dan `mainAxisSpacing`

**Project terkait : `toko_stiker_emoji`**
- Buat list 30+ emoji/stiker dalam GridView (4 kolom)
- Ada label kategori di atas setiap grup
- Ketika stiker ditekan, tampilkan SnackBar "Kamu memilih [emoji]"
- Tujuan: Familiar dengan layout grid

---

### Hari 25 : CustomScrollView & Slivers (Dasar)
* Konsep Sliver di Flutter
* `CustomScrollView` dengan `SliverList` dan `SliverGrid`
* `SliverAppBar` — AppBar yang collapse saat scroll
* Kapan menggunakan Sliver

**Project terkait : `halaman_resep_masakan`**
- Buat halaman resep dengan SliverAppBar berisi foto makanan besar
- Saat scroll ke bawah, foto mengecil dan AppBar muncul
- Di bawahnya SliverList berisi langkah-langkah memasak
- Tujuan: Membuat scrolling effect yang profesional

---

### Hari 26 : Card & Decoration Lanjut
* Widget `Card` dan propertinya
* `BoxDecoration` lanjut: gradient, border, shadow
* `ClipRRect` untuk memotong widget menjadi rounded
* `InkWell` vs `GestureDetector` (pengantar)

**Project terkait : `app_berita_mini`** *(data statis)*
- Buat 5 kartu berita dengan gambar thumbnail, judul, sumber, dan tanggal
- Gunakan Card dengan shadow dan border radius yang elegan
- Ketika kartu ditekan, InkWell memberikan efek ripple
- Tujuan: Membuat komponen yang terlihat profesional

---

### Hari 27 : GestureDetector & Interaksi Sentuh
* `GestureDetector` — mendeteksi berbagai gesture
* `onTap`, `onDoubleTap`, `onLongPress`
* `onPanUpdate` — drag sederhana
* Kapan pakai GestureDetector vs InkWell

**Project terkait : `like_button_instagram_style`**
- Buat gambar besar yang bisa di-double tap untuk "like"
- Saat double tap: muncul icon hati animasi di tengah gambar (gunakan Stack)
- Long press: tampilkan opsi "Simpan" atau "Bagikan" via SnackBar
- Tujuan: Gesture kompleks seperti app nyata

---

### Hari 28 : AnimatedContainer & Animasi Implisit
* Animasi implisit vs eksplisit
* `AnimatedContainer` — container yang smooth saat berubah
* `AnimatedOpacity` — fade in/out
* `AnimatedCrossFade` — transisi antara dua widget
* `duration` dan `curve`

**Project terkait : `toggle_dark_mode`**
- Buat app dengan tombol toggle dark/light mode
- Saat toggle: background berubah smooth (AnimatedContainer)
- Teks dan icon juga fade (AnimatedOpacity)
- Tujuan: Animasi pertama yang terasa "smooth"

---

### Hari 29 : Hero Animation
* Apa itu Hero Animation
* Menggunakan widget `Hero` dengan `tag`
* Transisi halaman yang menarik
* Best practice: pastikan tag unik

**Project terkait : `galeri_foto_dengan_detail`**
- Halaman grid berisi 9 foto (Image.network)
- Ketika foto ditekan: Hero animation — foto "terbang" ke halaman detail
- Halaman detail menampilkan foto lebih besar dengan deskripsi
- Tujuan: Animasi navigasi yang mengesankan

---

### Hari 30 : Form & Validasi
* Widget `Form` dan `GlobalKey<FormState>`
* `TextFormField` dengan validator
* `form.validate()`, `form.save()`, `form.reset()`
* Tipe keyboard: `TextInputType.email`, `.number`, dll

**Project terkait : `form_pendaftaran_kelas`**
- Buat form pendaftaran dengan field: Nama, Email, Nomor HP, Pilih Kelas (dropdown)
- Validasi: email harus valid, HP harus angka, nama minimal 3 karakter
- Tombol daftar: jika valid tampilkan dialog konfirmasi, jika tidak tampilkan error
- Tujuan: Form handling yang benar seperti di app nyata

---

### Hari 31 : DropdownButton & Checkbox & Radio
* `DropdownButton` dan `DropdownMenuItem`
* `Checkbox` dan `CheckboxListTile`
* `Radio` dan `RadioListTile`
* Mengelola state beberapa input sekaligus

**Project terkait : `survey_selera_musik`**
- Buat form survei: pilih genre musik favorit (Dropdown), pilih mood mendengarkan (Radio: Santai/Fokus/Olahraga), checklist fitur yang diinginkan dari app musik (Checkbox)
- Tampilkan rangkuman pilihan di bawah form
- Tujuan: Mengelola banyak input state sekaligus

---

### Hari 32 : Slider & Switch
* `Slider` widget
* `RangeSlider`
* `Switch` dan `SwitchListTile`
* Update UI real-time saat slider bergerak

**Project terkait : `pengaturan_alarm_tidur`**
- Buat UI pengaturan alarm dengan Slider jam tidur (1–12 jam)
- Switch untuk: vibrate, notifikasi, mode weekend
- Tampilkan waktu bangun yang dihitung otomatis: "Jika tidur sekarang pukul 22:00, kamu bangun pukul 06:00"
- Tujuan: UI pengaturan yang fungsional

---

### Hari 33 : Dialog & BottomSheet
* `AlertDialog` dan customisasinya
* `showDialog()`
* `ModalBottomSheet` — panel dari bawah
* `showModalBottomSheet()`
* `SimpleDialog` untuk pilihan

**Project terkait : `app_catatan_mini`**
- Buat list catatan sederhana (data statis)
- Long press catatan: muncul AlertDialog "Hapus catatan ini?"
- Tombol tambah (+): muncul BottomSheet dengan TextField untuk catatan baru
- Tujuan: Dialog pattern yang umum di semua app

---

### Hari 34 : Snackbar, Toast & Notification UI
* `ScaffoldMessenger.of(context).showSnackBar()`
* Snackbar dengan action button
* Custom snackbar dengan warna dan icon
* `OverlayEntry` — pengantar overlay

**Project terkait : `sistem_notifikasi_ui`**
- Buat halaman dengan berbagai tombol yang trigger notifikasi berbeda
- Snackbar success (hijau), warning (kuning), error (merah)
- Snackbar dengan tombol "Undo"
- Tujuan: Feedback UI yang profesional

---

### Hari 35 : Theme & ThemeData
* `ThemeData` — mengatur tema global app
* `primaryColor`, `colorScheme`, `textTheme`
* Menggunakan tema di seluruh widget otomatis
* `Theme.of(context)` untuk membaca tema

**Project terkait : `app_multi_tema`**
- Buat app yang punya 3 pilihan tema: Default (biru), Alam (hijau), Senja (oranye)
- Ganti tema dari halaman pengaturan
- Seluruh warna app berubah mengikuti tema yang dipilih
- Tujuan: Sistem tema yang scalable

---

### Hari 36 : Custom Font & Google Fonts
* Menambahkan font custom via `pubspec.yaml`
* Package `google_fonts`
* Menerapkan font ke seluruh app via ThemeData
* Kombinasi beberapa font (display + body)

**Project terkait : `blog_personal_ui`**
- Buat halaman artikel blog dengan tipografi yang indah
- Judul artikel: font display besar (misal Playfair Display)
- Body artikel: font baca yang nyaman (misal Lora)
- Sidebar: font sans-serif modern
- Tujuan: Tipografi adalah setengah dari desain yang bagus

---

### Hari 37 : Responsive Layout Dasar
* `MediaQuery` — mendapatkan ukuran layar
* `LayoutBuilder` — layout berdasarkan constraint
* Perbedaan layout di HP kecil vs HP besar vs tablet
* Breakpoint sederhana

**Project terkait : `dashboard_adaptif`**
- Buat dashboard yang di HP kecil: list vertikal; di HP besar/tablet: grid 2 kolom
- Gunakan `LayoutBuilder` untuk switch layout
- Uji di berbagai ukuran emulator
- Tujuan: App yang tidak rusak di semua device

---

### Hari 38 : Cupertino Widgets (iOS Style)
* `CupertinoApp` vs `MaterialApp`
* `CupertinoButton`, `CupertinoTextField`
* `CupertinoNavigationBar`
* Kapan pakai Cupertino vs Material

**Project terkait : `app_ios_style_calculator`**
- Buat kalkulator dengan tampilan iOS style menggunakan Cupertino widgets
- Tombol bulat hitam/abu/oranye seperti Kalkulator iPhone asli
- Fungsional: bisa hitung +, -, *, /
- Tujuan: Mengenal dua design language di Flutter

---

### Hari 39 : Clipper & Custom Shape
* `ClipOval`, `ClipRRect`, `ClipPath`
* Membuat custom shape dengan `CustomClipper`
* Diagonal section, wave clipper
* Penggunaan kreatif untuk header/card

**Project terkait : `halaman_onboarding_keren`**
- Buat 3 halaman onboarding dengan shape unik
- Halaman 1: wave clipper di bagian atas
- Halaman 2: diagonal clipper
- Halaman 3: oval shape besar di tengah
- Navigasi antar halaman dengan tombol Next
- Tujuan: UI yang beda dari template biasa

---

### Hari 40 : CustomPainter Dasar
* Apa itu `CustomPainter`
* `Canvas` dan `Paint` object
* Menggambar: garis, lingkaran, persegi, arc
* `CustomPaint` widget

**Project terkait : `analog_clock`**
- Buat jam analog yang menggambar jarum jam/menit/detik menggunakan CustomPainter
- Gunakan `Timer.periodic` untuk update setiap detik
- Lingkaran luar, titik-titik menit, dan jarum berwarna berbeda
- Tujuan: Menggambar custom graphics pertamamu

---

### Hari 41 : Future & Async/Await Dasar
* Apa itu asynchronous programming
* `Future<T>` — hasil yang akan datang
* `async` dan `await`
* `then()` dan `catchError()`

**Project terkait : `simulasi_loading_data`**
- Buat app yang simulasikan loading data (gunakan `Future.delayed`)
- Tampilkan CircularProgressIndicator saat menunggu
- Setelah 2 detik, tampilkan list data
- Tangani kondisi error dengan pesan "Gagal memuat data"
- Tujuan: Pola loading yang ada di setiap app nyata

---

### Hari 42 : FutureBuilder
* `FutureBuilder` — widget yang reaktif terhadap Future
* `ConnectionState`: none, waiting, active, done
* Menangani `snapshot.hasError` dan `snapshot.hasData`
* Kapan pakai FutureBuilder vs setState manual

**Project terkait : `app_trivia_pertanyaan`**
- Buat Future yang return list pertanyaan trivia (hard-coded dalam delay)
- Tampilkan menggunakan FutureBuilder
- State waiting: loading spinner + teks "Memuat pertanyaan..."
- State done: tampilkan pertanyaan dalam card
- State error: tampilkan ikon error dan tombol retry

---

### Hari 43 : HTTP Request Pertama
* Tambahkan package `http` di pubspec.yaml
* `http.get()` untuk request sederhana
* Parse JSON response: `jsonDecode()`
* Tampilkan data dari API nyata

**Project terkait : `app_fakta_acak`**
- Gunakan API gratis: `https://uselessfacts.jsph.pl/api/v2/facts/random`
- Tampilkan fakta random dalam kartu besar
- Tombol "Fakta Baru" untuk fetch fakta berikutnya
- Tampilkan loading saat fetch berlangsung
- Tujuan: Pertama kali terhubung ke internet yang nyata!

---

### Hari 44 : JSON Parsing & Model Class
* Membuat Model class dari JSON
* `fromJson()` factory constructor
* `toJson()` method
* List of objects dari JSON array

**Project terkait : `app_universitas_indonesia`**
- Gunakan API: `https://api.kawal.id/univ` (atau mock JSON lokal)
- Buat class `Universitas` dengan fromJson
- Tampilkan list universitas dalam ListView
- Setiap item: nama universitas, kota, akreditasi
- Tujuan: Cara yang benar dalam handle data dari API

---

### Hari 45 : Error Handling & Loading State Pattern
* Try-catch dalam async function
* Membuat enum State: `loading`, `success`, `error`
* Menampilkan UI berbeda untuk setiap state
* Best practice: pisahkan logika dan UI

**Project terkait : `weather_state_machine`**
- Buat app cuaca dengan 3 state UI yang jelas
- Loading: Animasi awan bergerak (gunakan AnimatedContainer sederhana)
- Success: Tampilkan data cuaca (mock data)
- Error: Ilustrasi error + tombol retry
- Tujuan: State management manual yang rapi

---

### Hari 46 : SharedPreferences — Simpan Data Lokal
* Apa itu `SharedPreferences`
* Menyimpan dan membaca: String, int, bool, double
* Kapan menggunakan SharedPreferences
* Batasan SharedPreferences (bukan untuk data kompleks)

**Project terkait : `app_kebiasaan_harian`**
- Buat tracker 5 kebiasaan harian (minum air, olahraga, baca buku, dll)
- User bisa centang kebiasaan yang sudah dilakukan
- Data tersimpan di SharedPreferences — tidak hilang saat app ditutup
- Saat buka app lagi, state checklist tetap tersimpan
- Tujuan: Data persistence pertama!

---

### Hari 47 : Package Manajemen & pub.dev
* Cara mencari package di pub.dev
* Memahami: likes, pub points, popularity
* Membaca dokumentasi package
* Menghapus package yang tidak diperlukan

**Project terkait : `eksplorasi_package`**
- Jelajahi pub.dev, temukan 5 package menarik yang belum kamu kenal
- Install masing-masing dan buat demo kecil di app terpisah
- Contoh: `flutter_svg`, `cached_network_image`, `intl`
- Tulis catatan: "Package ini berguna untuk..."
- Tujuan: Tahu cara cari alat yang tepat

---

### Hari 48 : Image Picker & Kamera
* Package `image_picker`
* Pilih gambar dari galeri
* Ambil foto dari kamera
* Menampilkan gambar yang dipilih

**Project terkait : `app_ganti_foto_profil`**
- Buat halaman profil dengan foto avatar
- Tombol "Ganti Foto": pilih dari galeri atau kamera (BottomSheet dengan 2 opsi)
- Tampilkan foto yang dipilih di avatar
- Tambahkan border bulat yang cantik di sekitar foto

---

### Hari 49 : Intl & Format Tanggal
* Package `intl`
* Format tanggal: `DateFormat('dd MMMM yyyy')`
* Format angka: mata uang, desimal
* Locale untuk Bahasa Indonesia

**Project terkait : `app_pengingat_ulang_tahun`**
- Buat list teman dengan tanggal ulang tahun
- Tampilkan tanggal dalam format Indonesia: "15 Agustus 1998"
- Hitung berapa hari lagi sampai ulang tahun
- Urutkan berdasarkan yang paling dekat
- Tujuan: Kerja dengan tanggal yang benar

---

### Hari 50 : Review & Project Milestone Fase 2
* Review semua widget dan konsep Hari 21–49
* Refactor dan perbaiki project-project sebelumnya
* Identifikasi area yang masih lemah

**Project terkait : `app_resep_masakan_lengkap`**
- Buat app resep dengan: GridView resep di halaman utama, Filter berdasarkan kategori (Sarapan/Makan Siang/Makan Malam/Cemilan), Detail resep dengan SliverAppBar, Form tambah resep baru, Data tersimpan di SharedPreferences, Hero animation dari grid ke detail
- Ini project terbesar pertamamu — gunakan semua yang sudah dipelajari!

---

## 🗓️ FASE 3 — State Management & Arsitektur (Hari 51–80)
> Tujuan: Menulis kode yang terstruktur, scalable, dan mudah di-maintain

---

### Hari 51–52 : Provider — State Management Pertama
*(2 hari untuk project yang lebih dalam)*

**Hari 51:**
* Masalah apa yang diselesaikan state management?
* Apa itu Provider dan InheritedWidget
* `ChangeNotifier` dan `notifyListeners()`
* `ChangeNotifierProvider`

**Hari 52:**
* `Consumer<T>` dan `Provider.of<T>(context)`
* `context.watch()` vs `context.read()`
* Multi-provider setup
* Kapan setState masih cukup vs perlu Provider

**Project terkait (2 hari) : `app_keranjang_belanja`**
- Halaman produk: list produk dengan tombol "Tambah ke Keranjang"
- Halaman keranjang: list produk yang dipilih, total harga
- Provider sebagai "toko" global: `CartProvider` dengan ChangeNotifier
- Badge angka di icon keranjang di AppBar update otomatis
- Tujuan: Pertama kali state bisa "dibagi" antar halaman

---

### Hari 53–54 : Provider Lanjut — Multiple Providers & ProxyProvider

**Hari 53:**
* Mengelola beberapa Provider sekaligus
* `MultiProvider`
* Provider untuk user authentication state (simulasi)

**Hari 54:**
* `ProxyProvider` — provider yang bergantung pada provider lain
* `FutureProvider` dan `StreamProvider`
* Memisahkan logika ke service class terpisah

**Project terkait (2 hari) : `app_todo_dengan_auth`**
- Simulasi login/logout dengan `AuthProvider`
- Setelah "login", halaman berubah ke halaman todo
- `TodoProvider` hanya aktif saat user login
- Logout: semua data todo hilang dan kembali ke halaman login
- Tujuan: Memahami auth flow yang nyata

---

### Hari 55 : Riverpod — Perkenalan
* Apa perbedaan Riverpod vs Provider
* `StateProvider` — state sederhana
* `ref.watch()` dan `ref.read()`
* `ConsumerWidget` dan `ConsumerStatefulWidget`

**Project terkait : `counter_riverpod_style`**
- Rebuild app counter klasik tapi menggunakan Riverpod
- Bandingkan dengan versi setState — mana yang lebih rapi?
- Tambahkan fitur: reset counter, set angka spesifik
- Tujuan: Kenali Riverpod sebelum masuk lebih dalam

---

### Hari 56–57 : Riverpod — Provider Types Lanjut

**Hari 56:**
* `Provider` (read-only, computed value)
* `StateNotifierProvider` — state yang lebih kompleks
* `StateNotifier<T>` class

**Hari 57:**
* `FutureProvider` — async data
* `StreamProvider` — real-time data
* `.family` modifier — provider dengan parameter
* `.autoDispose` modifier

**Project terkait (2 hari) : `app_berita_riverpod`**
- Fetch berita dari API menggunakan FutureProvider
- Filter kategori berita: setiap kategori adalah FutureProvider.family
- Bookmark berita menggunakan StateNotifierProvider
- AutoDispose agar data lama di-clear saat tidak dipakai
- Tujuan: Riverpod untuk app yang lebih nyata

---

### Hari 58 : GetX — Perkenalan & Perbandingan
* Apa itu GetX — state, navigation, dependency injection
* `GetxController` dan `obs` variables
* `Obx()` widget
* `Get.to()` untuk navigasi tanpa context

**Project terkait : `konverter_mata_uang_getx`**
- Buat konverter mata uang sederhana (IDR ke USD, EUR, JPY)
- Gunakan GetxController untuk menyimpan nilai input dan hasil konversi
- Update hasil otomatis saat input berubah menggunakan `obs`
- Tujuan: Rasakan kemudahan GetX — lalu pertimbangkan trade-off-nya

---

### Hari 59 : Clean Architecture Pengantar
* Apa itu Clean Architecture dan kenapa penting
* Layers: Presentation, Domain, Data
* Separation of Concerns
* Folder structure yang scalable

**Project terkait : `refactor_app_berita`**
- Ambil app berita dari sebelumnya
- Refactor ke struktur: `features/news/data/`, `features/news/domain/`, `features/news/presentation/`
- Pisahkan: Repository, UseCase, ViewModel
- Tujuan: Bukan menambah fitur, tapi belajar menulis kode yang benar

---

### Hari 60 : Repository Pattern
* Apa itu Repository Pattern
* Interface (Abstract class) sebagai kontrak
* Implementasi repository
* Dependency injection manual

**Project terkait : `app_buku_harian_clean`**
- Buat `JurnalRepository` abstract class
- Implementasikan `LocalJurnalRepository` (simpan ke SharedPreferences)
- Presentation layer tidak tahu cara simpan data — hanya panggil repository
- Tujuan: Kode yang mudah diganti implementasinya

---

### Hari 61–63 : Dio — HTTP Client yang Powerful

**Hari 61:**
* Apa kelebihan Dio vs package http biasa
* Setup Dio instance dengan BaseOptions
* GET, POST, PUT, DELETE request

**Hari 62:**
* Dio Interceptor — untuk logging, auth token
* Error handling dengan DioException
* Timeout dan retry

**Hari 63:**
* Upload file dengan FormData
* Download file
* Cancel request

**Project terkait (3 hari) : `app_jurnal_online`**
- Gunakan mock API (JSONPlaceholder atau buat sendiri di Mocky.io)
- CRUD lengkap: Create jurnal baru (POST), baca list jurnal (GET), update (PUT), hapus (DELETE)
- Interceptor untuk log setiap request ke konsol
- Loading state yang proper untuk setiap operasi
- Tujuan: HTTP client yang siap untuk production

---

### Hari 64 : Hive — Local Database
* Mengapa perlu database lokal vs SharedPreferences
* Setup Hive, `HiveBox`, `TypeAdapter`
* CRUD operasi di Hive
* `@HiveType` dan code generation

**Project terkait : `app_koleksi_buku`**
- Simpan koleksi buku yang kamu miliki di Hive
- Field: judul, penulis, halaman, sudah dibaca/belum, rating
- CRUD lengkap: tambah, edit, hapus, lihat detail
- Filter: tampilkan hanya buku yang belum dibaca
- Tujuan: Database lokal yang benar-benar persistent dan cepat

---

### Hari 65 : Isar atau SQLite — Database Relasional Lokal
* Perkenalan SQLite dengan package `sqflite`
* Atau Isar database (lebih modern)
* Membuat tabel/schema
* Query sederhana: SELECT, INSERT, UPDATE, DELETE

**Project terkait : `app_keuangan_pribadi`**
- Catat pemasukan dan pengeluaran
- Database: tabel transaksi (id, judul, jumlah, kategori, tanggal, tipe)
- Tampilkan list transaksi, filter per bulan
- Hitung total saldo, total pemasukan, total pengeluaran
- Tujuan: Database relasional untuk data yang lebih kompleks

---

### Hari 66–67 : Firebase Setup & Authentication

**Hari 66:**
* Setup project Firebase
* Tambahkan Flutter ke Firebase (FlutterFire CLI)
* `firebase_core` initialization
* `firebase_auth` — setup

**Hari 67:**
* Email/password sign up dan sign in
* Google Sign In
* Mengelola auth state dengan `authStateChanges()` stream
* Sign out

**Project terkait (2 hari) : `app_komunitas_mini`**
- Halaman login: Email/password + tombol Google Sign In
- Setelah login: halaman home dengan nama user dan foto profil dari Google
- Tombol logout
- Simpan info user ke Firestore setelah register pertama kali

---

### Hari 68–70 : Firestore — Cloud Database

**Hari 68:**
* Apa itu Firestore (NoSQL, real-time)
* Struktur: Collections dan Documents
* Read: `get()` dan `snapshots()` stream

**Hari 69:**
* Write: `add()`, `set()`, `update()`
* Delete: `delete()`
* Query: `where()`, `orderBy()`, `limit()`

**Hari 70:**
* Real-time listener dengan StreamBuilder
* Batch writes dan transactions
* Security rules dasar

**Project terkait (3 hari) : `app_komunitas_diskusi`**
- Lanjutan dari project auth — sekarang tambahkan fitur diskusi
- User bisa post pertanyaan (simpan ke Firestore)
- List pertanyaan real-time (StreamBuilder — update otomatis tanpa refresh)
- Bisa reply ke pertanyaan (sub-collection)
- Tampilkan nama dan foto profil pembuat post
- Tujuan: App pertama yang benar-benar real-time dan multi-user!

---

### Hari 71 : Firebase Storage
* Upload file/gambar ke Firebase Storage
* Download URL setelah upload
* Progress upload
* Aturan keamanan Storage

**Project terkait : `update_foto_profil_firebase`**
- Lanjutan app komunitas: tambahkan fitur ganti foto profil
- Pick gambar dari galeri → upload ke Firebase Storage → simpan URL di Firestore
- Tampilkan foto profil baru di seluruh app
- Tujuan: File storage cloud yang terintegrasi

---

### Hari 72–74 : Bloc Pattern

**Hari 72:**
* Apa itu BLoC (Business Logic Component)
* Event, State, Bloc
* `bloc` dan `flutter_bloc` package
* Setup BLoC pertama

**Hari 73:**
* `BlocBuilder`, `BlocListener`, `BlocConsumer`
* Mengelola state yang kompleks
* Sealed classes untuk Events dan States

**Hari 74:**
* Cubits — versi sederhana dari BLoC
* Kapan pakai Cubit vs BLoC penuh
* Testing dengan BLoC (pengantar)

**Project terkait (3 hari) : `app_pencarian_film`**
- Gunakan TMDB API (gratis) untuk mencari film
- BLoC dengan Events: `SearchFilm`, `LoadMore`, `ClearSearch`
- States: `FilmInitial`, `FilmLoading`, `FilmLoaded`, `FilmError`
- UI: search bar, list hasil, loading, error state
- Pagination: Load More saat scroll ke bawah
- Tujuan: BLoC untuk app yang benar-benar kompleks

---

### Hari 75–77 : Testing Dasar

**Hari 75:**
* Mengapa testing penting
* Unit test dengan `flutter_test`
* Test fungsi dan class Dart murni
* `expect()`, `test()`, `group()`

**Hari 76:**
* Widget test — test komponen UI
* `WidgetTester`, `pumpWidget()`, `find`
* `tap()`, `enterText()`, `pump()`

**Hari 77:**
* Integration test — test flow lengkap
* Mock dengan `mockito`
* Code coverage

**Project terkait (3 hari) : `testing_app_kalkulator`**
- Buat kalkulator sederhana dengan logika yang jelas
- Unit test: test semua operasi aritmatika
- Widget test: test tombol dan tampilan hasil
- Mock: test dengan input yang tidak valid
- Tujuan: Menulis kode yang bisa diuji

---

### Hari 78 : Isolates & Compute
* Apa itu Isolate di Dart
* Kenapa UI bisa freeze saat proses berat
* `compute()` function untuk background processing
* Kasus penggunaan: parse JSON besar, kompresi gambar

**Project terkait : `app_kompresi_gambar`**
- User pilih gambar besar dari galeri
- Kompres gambar di background Isolate (gunakan `compute`)
- UI tidak freeze saat kompresi berlangsung
- Tampilkan: ukuran asli vs ukuran setelah kompres

---

### Hari 79 : Platform Channels
* Apa itu Platform Channel
* Memanggil native Android (Kotlin) dari Flutter
* Memanggil native iOS (Swift) dari Flutter
* Kapan perlu Platform Channel vs pakai package

**Project terkait : `app_info_device`**
- Buat Platform Channel sederhana untuk mendapatkan info device
- Android: dapatkan model device via native Kotlin
- Tampilkan info: nama device, versi OS, kapasitas baterai
- Tujuan: Tahu bahwa Flutter bisa akses native kapanpun diperlukan

---

### Hari 80 : Review & Project Milestone Fase 3
* Review state management yang dipelajari
* Pilih satu approach yang paling nyaman
* Review Firebase, database lokal, testing

**Project terkait : `app_expense_tracker_lengkap`**
- App tracking pengeluaran dengan Firebase backend
- Auth: Google Sign In
- Firestore: simpan transaksi per user
- State management: Riverpod atau Provider (pilih yang paling nyaman)
- CRUD transaksi: tambah, edit, hapus
- Chart sederhana: pie chart pengeluaran per kategori
- Tujuan: App fullstack pertamamu yang bisa dipakai sungguhan!

---

## 🗓️ FASE 4 — Fitur Lanjut & Polish (Hari 81–100)
> Tujuan: Tambahkan fitur-fitur yang membuat app terasa profesional

---

### Hari 81 : Push Notification dengan FCM
* Setup Firebase Cloud Messaging
* Foreground & background notification
* Notification payload dan deep link
* Local notification dengan `flutter_local_notifications`

**Project terkait : `sistem_notif_pengingat`**
- Buat app pengingat dengan local notification
- User set waktu pengingat — notifikasi muncul tepat waktu
- Notifikasi bisa dibedakan tipe: info, warning, penting

---

### Hari 82 : Deep Linking & Dynamic Links
* Apa itu deep link
* Setup URL scheme untuk Flutter
* Firebase Dynamic Links (atau App Links / Universal Links)
* Handle deep link saat app terbuka maupun tertutup

**Project terkait : `share_konten_dengan_link`**
- Lanjutan app sebelumnya
- Setiap konten punya link yang bisa dibagikan
- Buka link di HP → langsung membuka halaman konten tersebut di dalam app

---

### Hari 83 : Animasi Lanjut — AnimationController
* `AnimationController` dan `Ticker`
* `Tween<T>` — animasi dari nilai A ke B
* `CurvedAnimation`
* Lifecycle animasi: forward, reverse, repeat

**Project terkait : `loading_screen_animasi`**
- Buat splash screen dengan animasi loading yang keren
- Logo app muncul dengan fade + scale animation
- Loading bar animasi
- Text "memuat..." dengan dots animasi
- Tujuan: Kesan pertama yang memukau

---

### Hari 84 : Lottie Animations
* Package `lottie` untuk animasi JSON
* Download animasi gratis dari LottieFiles.com
* Mengontrol animasi: play, pause, loop
* Trigger animasi berdasarkan event

**Project terkait : `app_onboarding_lottie`**
- 3 halaman onboarding dengan animasi Lottie yang relevan
- Halaman 1: animasi roket (mulai perjalanan)
- Halaman 2: animasi chart (track progres)  
- Halaman 3: animasi celebrate (capai tujuan)
- Animasi berputar terus di setiap halaman

---

### Hari 85 : Shimmer Loading Effect
* Package `shimmer`
* Buat skeleton screen saat loading
* Ganti shimmer dengan konten nyata saat data tiba
* Kapan shimmer lebih baik dari spinner

**Project terkait : `app_artikel_dengan_shimmer`**
- List artikel dengan shimmer skeleton saat loading
- Shimmer sesuai bentuk card artikel (gambar placeholder + 3 baris teks)
- Setelah data tiba: smooth transition dari shimmer ke konten

---

### Hari 86 : Infinite Scroll & Pagination
* Konsep cursor-based vs offset-based pagination
* `ScrollController` untuk deteksi scroll ke bawah
* Load more data saat mendekati bottom
* Tampilkan loading di bottom saat fetch halaman berikutnya

**Project terkait : `feed_foto_infinite`**
- Feed foto dengan gambar dari Unsplash API (gratis)
- Infinite scroll: saat scroll ke bawah, load 10 foto berikutnya
- Loading indicator kecil di bagian bawah list
- Pull-to-refresh untuk kembali ke awal

---

### Hari 87 : Pull to Refresh
* `RefreshIndicator` widget
* `onRefresh` callback
* Kombinasi dengan FutureBuilder/StreamBuilder
* Custom refresh indicator

**Project terkait : `app_feed_update_realtime`**
- Lanjutan dari project infinite scroll
- Tambahkan pull-to-refresh yang reset list ke awal dan fetch ulang
- Visual feedback yang smooth saat refresh

---

### Hari 88 : Connectivity & Offline Mode
* Package `connectivity_plus` untuk cek koneksi internet
* Deteksi perubahan koneksi secara real-time
* Tampilkan banner "Tidak ada koneksi" saat offline
* Cache data saat online, tampilkan cache saat offline

**Project terkait : `app_offline_first`**
- Buat app yang menyimpan data terakhir ke Hive saat online
- Saat offline: tampilkan data cache + banner offline
- Saat kembali online: auto refresh data
- Tujuan: App yang tetap berguna walaupun tanpa internet

---

### Hari 89 : Localization & Multi-bahasa
* Package `flutter_localizations`
* ARB file untuk terjemahan
* Mengganti bahasa di runtime
* Format tanggal dan angka per locale

**Project terkait : `app_bilingual_id_en`**
- Buat app yang punya konten dalam Bahasa Indonesia dan English
- Toggle bahasa di halaman pengaturan
- Seluruh teks berubah tanpa restart app
- Format tanggal dan mata uang ikut menyesuaikan

---

### Hari 90 : Accessibility
* Apa itu accessibility di mobile app
* `Semantics` widget
* Ukuran font yang bisa diubah (TextScaler)
* Kontras warna yang cukup
* Screen reader support

**Project terkait : `audit_accessibility_app`**
- Ambil salah satu app yang sudah dibuat
- Gunakan fitur TalkBack (Android) atau VoiceOver (iOS) — apakah app bisa dipakai?
- Perbaiki semua masalah accessibility yang ditemukan
- Tambahkan Semantics widget di tempat yang perlu

---

### Hari 91–93 : Flavors & Build Configuration

**Hari 91:**
* Apa itu Build Flavors
* Development vs Staging vs Production
* Konfigurasi berbeda per flavor: API URL, app name, ikon

**Hari 92:**
* Setup flavor di Android (`build.gradle`)
* Setup flavor di iOS (scheme dan target)

**Hari 93:**
* Environment variables
* `.env` file dan package `flutter_dotenv`
* Build release APK untuk flavor tertentu

**Project terkait (3 hari) : `app_multi_environment`**
- Ambil salah satu app Firebase yang sudah dibuat
- Setup 2 flavor: dev (pakai Firebase project dev) dan prod (Firebase project prod)
- Nama app berbeda: "MyApp Dev" vs "MyApp"
- Ikon app berbeda (tambahkan label "DEV" di pojok ikon versi dev)

---

### Hari 94 : Performance Profiling
* Flutter DevTools — cara membukanya
* Widget Rebuild Tracker — temukan rebuild berlebihan
* CPU Profiler — temukan kode yang lambat
* Memory Profiler — deteksi memory leak
* `const` keyword untuk performa

**Project terkait : `optimasi_app_resep`**
- Buka app resep yang sudah dibuat di DevTools
- Identifikasi widget yang rebuild terlalu sering
- Tambahkan `const` di tempat yang tepat
- Ukur perbedaan performa sebelum dan sesudah

---

### Hari 95 : Image Optimization & Caching
* Package `cached_network_image` — caching gambar otomatis
* Resize dan compress gambar sebelum upload
* Placeholder dan error widget
* Memory cache vs disk cache

**Project terkait : `galeri_foto_optimized`**
- Buat galeri foto dari Unsplash API
- Gunakan `cached_network_image` dengan placeholder shimmer
- Bandingkan penggunaan memori dengan dan tanpa caching
- Tujuan: App yang hemat data dan cepat

---

### Hari 96 : App Icon & Splash Screen
* Generate app icon dengan package `flutter_launcher_icons`
* Custom splash screen dengan `flutter_native_splash`
* Perbedaan splash screen di Android 12+ vs sebelumnya
* Branding yang konsisten

**Project terkait : `branding_app_lengkap`**
- Pilih salah satu app terbaikmu
- Design icon yang menarik (bisa gunakan Figma atau Canva)
- Setup splash screen dengan logo dan warna brand
- Ganti nama app di Android dan iOS
- Tujuan: App yang siap "dipublikasikan" secara visual

---

### Hari 97 : Store Preparation — Google Play
* Apa saja yang diperlukan untuk publish ke Play Store
* Generate signed APK / App Bundle
* Buat keystore
* Minimal metadata: deskripsi, screenshot, ikon

**Project terkait : `publish_checklist`**
- Buat dokumen checklist publish ke Play Store
- Generate signed APK dari salah satu app
- Buat screenshot app di berbagai ukuran
- Tulis deskripsi app yang menarik (tidak perlu publish sungguhan)

---

### Hari 98 : CI/CD Dasar dengan GitHub Actions
* Apa itu CI/CD
* Setup repository GitHub
* GitHub Actions workflow untuk Flutter: test + build
* Otomatis run test setiap push ke main

**Project terkait : `setup_ci_flutter`**
- Push salah satu app ke GitHub
- Buat `.github/workflows/flutter.yml`
- Workflow: install Flutter, run `flutter test`, run `flutter build apk`
- Lihat hasil di tab Actions GitHub

---

### Hari 99 : Code Review & Best Practices
* Dart linter dan `analysis_options.yaml`
* Penamaan yang konsisten (lowerCamelCase, UpperCamelCase)
* Dokumentasi dengan `///` dartdoc
* Anti-patterns yang harus dihindari
* Code review diri sendiri

**Project terkait : `refactor_besar`**
- Pilih project terbesar yang sudah dibuat
- Baca setiap file dan perbaiki: naming, struktur, komentar, hapus kode mati
- Tambahkan dartdoc di setiap class dan method penting
- Jalankan `flutter analyze` dan selesaikan semua warning

---

### Hari 100 : 🎉 Milestone Besar — Portfolio Project Pertama
* Refleksi perjalanan 100 hari
* Evaluasi: apa yang sudah dikuasai, apa yang perlu diperdalam
* Planning untuk 100 hari berikutnya

**Project terkait : `app_portfolio_tracker` (Mulai hari ini, selesai hari 107)**
- **Konsep:** App untuk mencatat progres belajar coding harian (self-referential!)
- Fitur: Log belajar harian (judul, durasi, catatan), streak tracker (berapa hari berturut belajar), statistik mingguan (total jam belajar), reminder notifikasi harian, dark/light mode, export data ke CSV
- Stack: Flutter + Riverpod + Hive + Local Notification
- Desain: Minimal dan elegan, terinspirasi Notion
- Tujuan: App yang benar-benar berguna untuk dirimu sendiri setiap hari!

---

> **✅ End of Part 1 — Hari 1-100**
> Lanjut ke Part 2 untuk Hari 101-200 (Intermediate Level)
