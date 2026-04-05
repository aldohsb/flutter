Buatkan panduan materi flutter di bawah ini, beserta file proyek terkait

materi dengan bahasa yang mudah dimengerti, tambahkan tips trik industri terkait materi jika ada, tambahkan tanya jawab pendalaman materi.
proyek yang dibuat setiap file di tulis di masing-masing artifact agar mudah di copy berikan komentar penjelasan code setiap baris
jangan gunakan syntax code yang sudah deprecated di 2026, versi library yang paling up to date mulai dari inisialisasi proyek sertakan code bash touch mkdir untuk membuat struktur file lengkap semua file termasuk di root.
buatkan juga artifact tersendiri untuk penjelasan algoritma dan logika code utama proyek di atas, penjelasan untuk pemula, mengapa sebuah code ditulis, apa logikanya, untuk apa dan mengapa.

buatkan quiz pilihan ganda, 15 soal, pilihan jawaban ada 8, pilihan e. benar semua, f. salah semua, g yang benar a dan c, pilihan h yang benar b dan d
tulis di chat bukan html

# 🚀 Kurikulum Flutter 300 Hari — Berbasis Proyek

## Part 1: Hari 1–60 | Fondasi & Aplikasi Pertama

> **Filosofi**: Langsung terjun ke Flutter. Dart diperkenalkan secara alami sesuai kebutuhan proyek. Setiap hari = satu langkah nyata menuju aplikasi yang bisa dipakai.

---

## 🟢 FASE 1 — DASAR FLUTTER (Hari 1–30)

### _"Dari Nol ke Aplikasi Pertama"_

---

### Hari 1 : Mengenal Flutter & Setup Environment

- Install Flutter SDK dan Android Studio / VS Code
- Setup emulator Android dan/atau iOS simulator
- Jalankan perintah `flutter doctor` dan atasi error yang muncul
- Pahami struktur folder project Flutter (`lib/`, `pubspec.yaml`, `main.dart`)
- Jalankan app default Flutter dan lihat hasilnya di emulator

**Proyek terkait materi : HelloFlutter**
Buat aplikasi satu layar sederhana yang menampilkan nama kamu dan foto profil di tengah layar dengan latar belakang warna favorit. Latihan pertama untuk memahami widget `Scaffold`, `Center`, `Column`, `Text`, dan `Image.asset`. Tujuannya adalah memastikan environment berjalan sempurna dan kamu nyaman dengan alur edit-save-hot reload.

---

### Hari 2 : Widget Dasar — Text, Container, Icon

- Memahami konsep "Everything is a Widget" di Flutter
- Menggunakan widget `Text` beserta properti style (fontSize, fontWeight, color)
- Menggunakan widget `Container` dengan padding, margin, warna, dan border radius
- Menggunakan widget `Icon` dari material icons
- Dart dasar: variabel `String`, `int`, `double`, dan `bool`

**Proyek terkait materi : NameCard**
Buat kartu nama digital pribadi yang menampilkan nama lengkap, jabatan/profesi, nomor telepon, email, dan ikon media sosial. Semua disusun menggunakan `Column` dan `Container` dengan styling manual. Latihan pertama memahami properti `BoxDecoration` untuk memberi efek kartu yang rapi dan profesional.

---

### Hari 3 : Layout — Row, Column, Stack

- Memahami axis utama dan cross-axis di `Row` dan `Column`
- Properti `mainAxisAlignment` dan `crossAxisAlignment`
- Widget `Stack` dan `Positioned` untuk elemen yang bertumpuk
- Widget `Expanded` dan `Flexible` untuk pembagian ruang
- Dart: tipe data `List` dan cara membuat list sederhana

**Proyek terkait materi : ProfileCard**
Buat layar profil bergaya aplikasi sosial media — ada foto besar di atas, nama dan bio di bawahnya, lalu tiga kolom statistik (posts, followers, following) sejajar. Praktikkan `Stack` untuk menempatkan tombol kamera di atas foto profil. Hasil akhir mirip halaman profil Instagram versi sederhana.

---

### Hari 4 : Gambar & Asset

- Menambahkan gambar lokal ke folder `assets/` dan mendaftarkan di `pubspec.yaml`
- Menggunakan `Image.asset()` dan `Image.network()`
- Widget `CircleAvatar` untuk foto bulat
- Widget `ClipRRect` untuk gambar dengan sudut melengkung
- Dart: `const` vs `final` vs `var`

**Proyek terkait materi : FoodSnap**
Buat galeri makanan dengan 4–6 card makanan. Setiap card berisi foto makanan (dari asset lokal), nama makanan, dan harga. Latihan mengatur ukuran gambar, `fit` property (`BoxFit.cover`, `BoxFit.contain`), dan menyusun card dalam `Column` yang bisa di-scroll. Ini fondasi untuk aplikasi food delivery nanti.

---

### Hari 5 : Scaffold, AppBar & NavigationBar

- Anatomi `Scaffold`: appBar, body, bottomNavigationBar, floatingActionButton
- Kustomisasi `AppBar`: title, actions, leading, backgroundColor
- Widget `BottomNavigationBar` dengan minimal 3 tab
- `FloatingActionButton` dan cara memposisikannya
- Dart: fungsi sederhana dan `void` function

**Proyek terkait materi : AppShell**
Buat kerangka (shell) aplikasi lengkap dengan AppBar berisi judul dan ikon notifikasi di kanan, BottomNavigationBar dengan 4 tab (Home, Search, Favorite, Profile), dan FloatingActionButton di tengah bottom bar. Setiap tab menampilkan teks berbeda. Ini adalah shell yang akan dipakai berulang di proyek-proyek berikutnya.

---

### Hari 6 : Button & Interaksi Pertama

- Widget `ElevatedButton`, `TextButton`, `OutlinedButton`
- Widget `GestureDetector` dan `InkWell` untuk area klik custom
- Memahami callback `onPressed`
- Konsep StatelessWidget vs StatefulWidget (pengenalan)
- Dart: fungsi dengan parameter dan return value

**Proyek terkait materi : TapCounter**
Buat aplikasi counter yang bisa tambah dan kurang angka, dengan tombol reset. Tambahkan animasi sederhana — angka berubah warna saat menekan tombol. Ini adalah proyek pertama yang benar-benar interaktif dan pengenalan pertama `setState()`. Sangat sederhana tapi fundamental.

---

### Hari 7 : StatefulWidget & setState

- Perbedaan mendalam `StatelessWidget` vs `StatefulWidget`
- Siklus hidup widget: `initState()`, `build()`, `dispose()`
- Cara menggunakan `setState()` dengan benar
- Kapan memilih Stateless vs Stateful
- Dart: kondisional `if-else` dan operator ternary

**Proyek terkait materi : MoodTracker**
Buat aplikasi pelacak mood harian. Tampilkan 5 emoji mood (😊😐😢😡😴). Saat emoji diklik, layar berubah warna sesuai mood yang dipilih dan teks di bawah menggambarkan mood tersebut. Praktikkan `setState()` untuk mengubah UI secara dinamis. Simpel tapi langsung terasa "hidup".

---

### Hari 8 : TextField & Input User

- Widget `TextField` dan `TextFormField`
- Menggunakan `TextEditingController` untuk membaca input
- Properti: `hintText`, `labelText`, `prefixIcon`, `obscureText`
- `InputDecoration` untuk styling input field
- Dart: String interpolation dan metode `.trim()`

**Proyek terkait materi : GreetMe**
Buat aplikasi yang meminta nama pengguna melalui TextField, lalu saat tombol "Sapa" ditekan, menampilkan pesan sambutan personal yang dinamis di bawahnya. Tambahkan validasi sederhana — jika nama kosong, tampilkan pesan error. Ini adalah interaksi form pertama yang nyata.

---

### Hari 9 : ListView & Scroll

- Widget `ListView` dan `ListView.builder`
- Perbedaan `ListView` biasa vs `ListView.builder` (performa)
- Widget `ListTile` untuk baris daftar yang rapi
- `ScrollController` dasar
- Dart: `List` operations — `.add()`, `.remove()`, `.length`, `.map()`

**Proyek terkait materi : TodoList**
Buat aplikasi to-do list klasik: input tugas di TextField atas, tekan tombol tambah, dan tugas muncul di `ListView.builder` di bawah. Setiap item bisa dicentang (selesai) atau dihapus. Praktikkan operasi list di Dart secara langsung dalam konteks UI yang nyata. Proyek ini bisa dipakai betulan!

---

### Hari 10 : GridView & Tampilan Kisi

- Widget `GridView.count` dan `GridView.builder`
- Properti `crossAxisCount`, `mainAxisSpacing`, `crossAxisSpacing`
- `childAspectRatio` untuk mengatur proporsi item
- Memilih kapan pakai ListView vs GridView
- Dart: `Map` dasar — key-value pair

**Proyek terkait materi : EmojiGallery**
Buat galeri emoji yang ditampilkan dalam grid 4 kolom. Setiap item berisi emoji besar dan nama kategorinya. Saat item diklik, tampilkan snackbar dengan nama emoji tersebut. Latihan `GridView.builder` dengan data list yang sudah dibuat sebelumnya. Sederhana tapi visual dan menyenangkan.

---

### Hari 11 : Navigator & Multi-Halaman

- Konsep navigation stack di Flutter
- `Navigator.push()` dan `Navigator.pop()`
- Membuat halaman baru dengan `MaterialPageRoute`
- Meneruskan data antar halaman (passing arguments)
- Dart: constructor class sederhana

**Proyek terkait materi : BookShelf**
Buat aplikasi daftar buku — halaman pertama menampilkan list judul buku, saat diklik navigasi ke halaman detail yang menampilkan info lengkap buku (judul, penulis, sinopsis, cover). Praktikkan passing data dari halaman list ke halaman detail. Ini pola navigasi yang paling sering dipakai di aplikasi nyata.

---

### Hari 12 : Named Routes & Route Management

- Mendefinisikan named routes di `MaterialApp`
- Navigasi dengan `Navigator.pushNamed()`
- Mengirim dan menerima argumen di named routes
- `Navigator.pushReplacementNamed()` untuk mengganti halaman
- Dart: `Map<String, dynamic>` untuk data arguments

**Proyek terkait materi : QuizApp**
Buat aplikasi kuis 5 soal dengan 3 halaman: halaman selamat datang, halaman soal, dan halaman hasil. Gunakan named routes untuk navigasi antar halaman. Passing skor dari halaman soal ke halaman hasil. Mulai kenalkan logika if-else lebih kompleks untuk mengecek jawaban benar/salah.

---

### Hari 13 : Dart OOP — Class & Object

- Membuat class di Dart dengan properties dan methods
- Constructor positional dan named constructor
- Getter dan setter
- `toString()` override
- Menggunakan object dari class dalam widget

**Proyek terkait materi : ContactBook**
Refactor proyek TodoList atau buat ulang sebagai contact book menggunakan class `Contact` dengan properties: `name`, `phone`, `email`, `isFavorite`. Buat list of objects, tampilkan di ListView, dan bisa toggle favorite. Praktik pertama OOP Dart dalam konteks Flutter yang nyata.

---

### Hari 14 : Dart — List Lanjutan & Functional

- `.map()`, `.where()`, `.forEach()`, `.reduce()`
- `where()` untuk filtering data
- `sort()` dan custom comparator
- Spread operator `...`
- Dart: `null safety` dan operator `?`, `!`, `??`

**Proyek terkait materi : ProductFilter**
Buat halaman daftar produk (minimal 10 item) dengan fitur filter berdasarkan kategori (pakai Row of chips di atas) dan sort berdasarkan harga. Saat chip diklik, list langsung difilter menggunakan `.where()`. Praktik langsung null safety Dart karena data produk mungkin ada field yang null.

---

### Hari 15 : Image Network & Loading State

- `Image.network()` dengan placeholder dan error handler
- Widget `CircularProgressIndicator` dan `LinearProgressIndicator`
- Mengelola loading state dengan boolean di StatefulWidget
- `FadeInImage` untuk transisi gambar yang halus
- Dart: `async`/`await` pengenalan pertama

**Proyek terkait materi : PhotoWall**
Buat galeri foto yang mengambil gambar dari internet (gunakan URL Unsplash statis). Tampilkan loading spinner saat gambar sedang dimuat, dan gambar placeholder jika gagal load. Susun dalam GridView 2 kolom. Ini pengenalan pertama konsep asynchronous loading dalam UI.

---

### Hari 16 : Snackbar, Dialog & BottomSheet

- `ScaffoldMessenger.showSnackBar()` dengan action
- `showDialog()` dan `AlertDialog`
- `showModalBottomSheet()` untuk sheet dari bawah
- Menunggu hasil dari dialog (return value)
- Dart: `Future<T>` dasar

**Proyek terkait materi : DeleteGuard**
Upgrade proyek TodoList: tambahkan konfirmasi dialog sebelum menghapus item ("Yakin ingin menghapus?"), snackbar setelah item berhasil ditambahkan, dan BottomSheet yang muncul saat long-press item untuk pilihan aksi (edit/hapus/pin). Ini UI pattern yang sangat umum di aplikasi produksi.

---

### Hari 17 : Form & Validasi

- Widget `Form` dan `GlobalKey<FormState>`
- `TextFormField` dengan `validator`
- `form.validate()`, `form.save()`, `form.reset()`
- Validasi email, password strength, required field
- Dart: RegExp untuk validasi pattern

**Proyek terkait materi : RegisterForm**
Buat form registrasi lengkap: nama lengkap, email, nomor HP, password, konfirmasi password. Setiap field punya validasi yang bermakna. Saat submit, tampilkan dialog sukses dengan data yang dimasukkan. Ini form produksi pertama kamu — pola yang akan dipakai di hampir semua aplikasi.

---

### Hari 18 : Tema & Warna Konsisten

- `ThemeData` di `MaterialApp`
- `ColorScheme` dan cara menggunakannya
- `TextTheme` untuk typography konsisten
- `Theme.of(context)` untuk akses tema
- Dark mode: `darkTheme` dan `themeMode`

**Proyek terkait materi : ThemeSwitch**
Upgrade AppShell dari hari 5: tambahkan toggle dark/light mode di AppBar. Semua widget harus mengikuti tema (tidak ada hardcoded color). Buat setidaknya 2 halaman yang merespons perubahan tema dengan mulus. Pelajari betapa pentingnya design system yang konsisten.

---

### Hari 19 : Custom Widget & Reusability

- Memecah UI menjadi widget-widget kecil
- Membuat widget custom dengan parameter
- `const` constructor untuk performa
- Widget composition pattern
- Dart: optional named parameters dengan default value

**Proyek terkait materi : UIKit**
Buat library widget custom sederhana: `CustomButton`, `CustomTextField`, `ProductCard`, `AvatarWidget`, `SectionHeader`. Setiap widget punya parameter yang fleksibel. Buat satu halaman showcase yang menampilkan semua widget ini. Ini adalah fondasi design system pribadi kamu.

---

### Hari 20 : Padding, Margin & Sizing

- Widget `Padding` dan penggunaannya
- `SizedBox` untuk memberi jarak dan ukuran tetap
- `Spacer` dalam Row/Column
- `MediaQuery` untuk responsive sizing dasar
- Dart: `const EdgeInsets` variants

**Proyek terkait materi : PixelPerfect**
Ambil satu desain UI dari Dribbble atau Figma community (yang sederhana), lalu coba implementasikan persis sama di Flutter. Fokus pada spacing yang tepat, proporsi yang benar, dan ukuran font yang sesuai. Ini latihan "pixel matching" yang mengasah kepekaan desain.

---

### Hari 21 : Wrap & Flow Layout

- Widget `Wrap` untuk elemen yang bisa wrap ke baris berikutnya
- Properti `spacing`, `runSpacing`, `alignment`
- Widget `Chip` dan `FilterChip`
- `ChoiceChip` untuk pilihan tunggal
- Dart: enum dasar

**Proyek terkait materi : TagExplorer**
Buat halaman artikel/blog dengan sistem tag. Di bagian atas ada `Wrap` berisi chip kategori yang bisa diklik untuk filter. Artikel ditampilkan di bawahnya dalam Card. Saat chip diklik, artikel difilter sesuai tag. Praktik `Wrap` sangat umum untuk tag, skill badge, dan filter UI.

---

### Hari 22 : Card & Elevation

- Widget `Card` dan propertinya
- `elevation` dan `shadowColor`
- `shape` dengan `RoundedRectangleBorder`
- `InkWell` di dalam Card untuk efek ripple
- `ListTile` di dalam Card

**Proyek terkait materi : RecipeCard**
Buat halaman daftar resep masakan dengan card yang menarik — setiap card berisi foto makanan (atas), nama resep, waktu memasak, difficulty badge, dan rating bintang. Saat card diklik, navigasi ke halaman detail resep. Fokus pada card design yang bagus dan konsisten.

---

### Hari 23 : Scroll Behavior Lanjutan

- `SingleChildScrollView` untuk konten panjang
- `CustomScrollView` dan `Slivers` pengenalan
- `SliverAppBar` yang collapse saat scroll
- `SliverList` dan `SliverGrid`
- Dart: mixin pengenalan

**Proyek terkait materi : StoreFront**
Buat halaman toko dengan `CustomScrollView`: SliverAppBar yang memiliki gambar banner besar dan collapse saat scroll ke bawah, diikuti section kategori dalam SliverGrid, lalu daftar produk dalam SliverList. Ini adalah pola halaman utama e-commerce yang profesional.

---

### Hari 24 : Animasi Dasar — AnimatedContainer

- `AnimatedContainer` dan properti yang bisa dianimasikan
- `Curves` untuk easing function
- `AnimatedOpacity` untuk fade
- `AnimatedCrossFade` untuk transisi antar widget
- Dart: `Duration` class

**Proyek terkait materi : AnimCard**
Buat 4–5 card yang bisa di-expand/collapse saat diklik. Saat expand, card membesar dengan animasi smooth dan menampilkan konten tambahan. Gunakan `AnimatedContainer` untuk animasi ukuran dan `AnimatedOpacity` untuk konten yang muncul. Animasi sederhana tapi membuat aplikasi terasa premium.

---

### Hari 25 : Hero Animation

- `Hero` widget dan cara kerjanya
- `tag` property yang unik
- Navigasi dengan hero animation
- Custom hero flight path
- Dart: `Key` dan `ValueKey`

**Proyek terkait materi : PhotoDetail**
Buat galeri foto sederhana: grid foto kecil di halaman utama, saat diklik foto terbang (hero animation) ke halaman detail yang menampilkan foto penuh layar. Tambahkan gesture pinch-to-zoom di halaman detail. Hero animation adalah salah satu fitur paling keren yang membuat Flutter apps terasa smooth.

---

### Hari 26 : PageView & Onboarding

- Widget `PageView` untuk swipe antar halaman
- `PageController` untuk kontrol programatik
- Indikator halaman (dot indicator)
- `onPageChanged` callback
- Dart: `List.generate()`

**Proyek terkait materi : OnboardPro**
Buat layar onboarding 3 halaman yang muncul pertama kali user buka aplikasi. Setiap halaman berisi ilustrasi (bisa emoji besar), judul, dan deskripsi. Ada dot indicator di bawah, tombol "Skip" di pojok kanan atas, dan tombol "Next"/"Mulai" di bawah. Ini adalah fitur onboarding standar semua aplikasi mobile.

---

### Hari 27 : SharedPreferences — Simpan Data Lokal

- Package `shared_preferences`
- Simpan dan baca data: String, int, bool, List
- `SharedPreferences.getInstance()`
- Menghapus data tersimpan
- Dart: `async`/`await` lebih dalam

**Proyek terkait materi : RememberMe**
Upgrade proyek OnboardPro: setelah onboarding selesai, simpan flag "sudah lihat onboarding" di SharedPreferences. Saat aplikasi dibuka lagi, cek flag tersebut — jika sudah, langsung ke halaman home. Tambahkan juga fitur simpan nama pengguna yang diinput saat onboarding. Ini adalah state persistence pertama.

---

### Hari 28 : FutureBuilder & Async UI

- `FutureBuilder<T>` dan cara kerjanya
- State: `ConnectionState.waiting`, `done`, `error`
- Menampilkan loading, error, dan data
- Membuat fake API call dengan `Future.delayed()`
- Dart: `Future.value()`, `Future.error()`

**Proyek terkait materi : FakeStore**
Buat halaman produk yang "loading dari server" — gunakan `Future.delayed()` untuk simulasi network call 2 detik, lalu tampilkan data produk yang sudah disiapkan di kode. Tampilkan shimmer loading (skeleton) saat menunggu, tampilkan error dengan tombol retry jika gagal. Ini fondasi untuk integrasi API nyata.

---

### Hari 29 : HTTP Request & API Pertama

- Package `http`
- `http.get()` dan parsing response
- `json.decode()` dari `dart:convert`
- Membuat model class dari JSON
- Error handling: try-catch untuk network error

**Proyek terkait materi : CoinWatch**
Buat aplikasi pelacak harga cryptocurrency menggunakan CoinGecko API (free, no auth). Tampilkan daftar top 10 coin dengan nama, logo, harga saat ini, dan persentase perubahan 24 jam. Harga hijau jika naik, merah jika turun. Pull-to-refresh untuk update data. API pertama yang nyata!

---

### Hari 30 : Review & Proyek Mini Pertama

- Review semua konsep hari 1–29
- Refactoring kode yang sudah dibuat
- Menambahkan fitur ke proyek yang sudah ada
- Debugging dengan Flutter DevTools
- Dart: review null safety dan OOP

**Proyek terkait materi : WeatherNow**
Buat aplikasi cuaca lengkap menggunakan OpenWeatherMap API (free tier). Fitur: cari kota, tampilkan suhu saat ini, kondisi cuaca (cerah/hujan/berawan), kelembaban, kecepatan angin, dan prakiraan 3 hari. Ada background yang berubah sesuai kondisi cuaca. Ini adalah proyek review komprehensif yang menggabungkan: API call, FutureBuilder, animasi, tema, dan navigasi.

---

## 🟡 FASE 2 — MENUJU INTERMEDIATE (Hari 31–60)

### _"State Management & Arsitektur"_

---

### Hari 31 : Provider — State Management Dasar

- Konsep state management dan mengapa dibutuhkan
- Install dan setup package `provider`
- `ChangeNotifier` dan `notifyListeners()`
- `ChangeNotifierProvider` di widget tree
- `Consumer<T>` dan `Provider.of<T>()`

**Proyek terkait materi : CartState**
Refactor aplikasi belanja sederhana menggunakan Provider. Buat `CartProvider` yang menyimpan list item keranjang. Halaman produk dan halaman cart terhubung melalui provider — saat item ditambah dari halaman produk, icon cart di AppBar langsung update jumlahnya. Ini adalah "aha moment" state management.

---

### Hari 32 : Provider Lanjutan — MultiProvider

- `MultiProvider` untuk beberapa provider
- `ProxyProvider` untuk provider yang bergantung satu sama lain
- `Selector<T, S>` untuk rebuild yang lebih efisien
- `context.watch<T>()`, `context.read<T>()`, `context.select<T, S>()`
- Dart: `late` keyword

**Proyek terkait materi : ShopApp**
Buat aplikasi toko dengan dua provider: `ProductProvider` (data produk dari API) dan `CartProvider` (keranjang belanja). Halaman: product list, product detail, cart, checkout form. Practikkan `MultiProvider` dan perbedaan `context.watch` vs `context.read` — yang pertama rebuild widget, yang kedua tidak.

---

### Hari 33 : Dart — Future & Stream

- `Stream<T>` vs `Future<T>` — kapan pakai yang mana
- `StreamController` dan `StreamBuilder`
- `async*` dan `yield`
- `Stream.periodic()` untuk data berkala
- Dart: `StreamSubscription` dan cara cancel

**Proyek terkait materi : LiveTimer**
Buat aplikasi stopwatch dan countdown timer menggunakan `Stream.periodic()`. Stopwatch bisa start, pause, reset. Countdown timer bisa diset durasi dan berbunyi/bergetar saat habis. Tambahkan tampilan lap time untuk stopwatch. Ini adalah penggunaan Stream yang sangat konkret dan visual.

---

### Hari 34 : Riverpod — Modern State Management

- Perbedaan Provider vs Riverpod
- Install `flutter_riverpod`
- `Provider`, `StateProvider`, `FutureProvider`
- `ConsumerWidget` dan `ref.watch()`, `ref.read()`
- Dart: extension methods

**Proyek terkait materi : NoteRiv**
Buat aplikasi catatan sederhana menggunakan Riverpod. `StateProvider` untuk list notes, `StateProvider` untuk filter (all/active/done). Fitur: tambah catatan, edit, hapus, tandai selesai, filter catatan. Bandingkan rasanya dengan Provider biasa — Riverpod lebih type-safe dan tidak perlu `BuildContext`.

---

### Hari 35 : Riverpod Lanjutan — AsyncNotifier

- `AsyncNotifier` dan `AsyncNotifierProvider`
- `ref.invalidate()` untuk refresh
- `FamilyModifier` untuk provider dengan parameter
- Error handling di Riverpod
- Dart: `sealed class` pengenalan

**Proyek terkait materi : NewsReader**
Buat aplikasi berita menggunakan NewsAPI. Provider: `newsProvider` (FutureProvider untuk fetch berita), `categoryProvider` (StateProvider untuk kategori terpilih). Gunakan `FamilyModifier` untuk fetch berita per kategori. Pull-to-refresh dengan `ref.invalidate()`. Halaman detail berita dengan WebView sederhana.

---

### Hari 36 : SQLite & Database Lokal

- Package `sqflite` dan `path`
- Membuat database dan tabel
- CRUD: insert, query, update, delete
- Primary key dan auto-increment
- Dart: `async`/`await` dengan database operations

**Proyek terkait materi : ExpenseTracker**
Buat aplikasi pencatat pengeluaran harian dengan SQLite. Setiap pengeluaran punya: tanggal, kategori, jumlah, catatan. Fitur: tambah/edit/hapus pengeluaran, lihat riwayat per bulan, total pengeluaran per kategori dalam chart sederhana. Data tersimpan permanen di device. Aplikasi yang langsung berguna!

---

### Hari 37 : Hive — NoSQL Database Lokal

- Package `hive_flutter`
- `HiveObject` dan `TypeAdapter`
- `Hive.openBox()` dan operasi CRUD
- Reactive Hive dengan `ValueListenableBuilder`
- Perbandingan Hive vs SQLite — kapan pakai yang mana

**Proyek terkait materi : JournalApp**
Buat aplikasi jurnal harian menggunakan Hive. Setiap entri: tanggal, judul, isi, suasana hati (enum), foto opsional. Tampilkan list entri diurutkan berdasarkan tanggal. Halaman detail entry dengan format teks yang rapi. Hive dipilih karena lebih cocok untuk document-style data seperti jurnal.

---

### Hari 38 : Image Picker & File Handling

- Package `image_picker`
- Memilih gambar dari galeri atau kamera
- Menyimpan path gambar ke database lokal
- Menampilkan gambar dari local file path
- Permission handling di Android dan iOS

**Proyek terkait materi : PhotoJournal**
Upgrade JournalApp: tambahkan fitur upload foto ke setiap entri jurnal. User bisa ambil foto dari kamera atau pilih dari galeri. Foto disimpan di local storage dan ditampilkan di halaman detail. Tambahkan fitur melihat semua foto dalam grid view. Praktik permission handling yang sangat penting untuk aplikasi produksi.

---

### Hari 39 : REST API Lanjutan — CRUD

- `http.post()`, `http.put()`, `http.delete()`
- Headers dan authentication token
- Membuat API service class yang terorganisir
- JSON serialization dengan `json_serializable`
- Dart: `factory constructor` dan `fromJson`/`toJson`

**Proyek terkait materi : PostHub**
Buat aplikasi CRUD menggunakan JSONPlaceholder API (free fake API). Fitur: lihat daftar post, lihat detail post + komentar, buat post baru, edit post, hapus post. Buat `ApiService` class yang bersih untuk semua network call. Praktik HTTP methods lengkap dalam satu proyek.

---

### Hari 40 : Dio & HTTP Interceptor

- Package `dio` vs `http` — mengapa Dio lebih powerful
- `BaseOptions`, `interceptors`
- Request/response interceptor untuk logging
- Retry interceptor untuk error handling
- Dio dengan cancel token

**Proyek terkait materi : ApiPro**
Refactor proyek PostHub atau CoinWatch menggunakan Dio. Tambahkan: logging interceptor (print request/response di debug mode), auth interceptor (tambahkan token ke semua request), retry interceptor (auto-retry saat error 5xx). Buat `DioClient` singleton yang bisa dipakai seluruh aplikasi.

---

### Hari 41 : Clean Architecture Dasar

- Konsep separation of concerns
- Layer: Presentation, Domain, Data
- Repository pattern
- Use case / interactor
- Dart: `abstract class` dan `interface`

**Proyek terkait materi : CleanNews**
Refactor NewsReader menggunakan clean architecture. Buat folder structure: `features/news/data/`, `features/news/domain/`, `features/news/presentation/`. Repository interface di domain, implementasinya di data. Use case `GetNewsUseCase`. Presenter/ViewModel di presentation. Ini adalah fondasi arsitektur untuk proyek besar.

---

### Hari 42 : BLoC Pattern — Dasar

- Konsep BLoC (Business Logic Component)
- Package `flutter_bloc`
- `Cubit` — versi sederhana BLoC
- `BlocBuilder`, `BlocListener`, `BlocConsumer`
- Dart: `Stream` lebih dalam

**Proyek terkait materi : CounterBloc**
Mulai dari yang sederhana: buat counter app menggunakan Cubit. Lalu upgrade ke BLoC penuh dengan Events dan States. Buat `CounterBloc` dengan events: `CounterIncremented`, `CounterDecremented`, `CounterReset`. States: `CounterInitial`, `CounterUpdated`. Pahami betul perbedaan Cubit vs BLoC.

---

### Hari 43 : BLoC Lanjutan — Async & API

- `BlocProvider` dan `MultiBlocProvider`
- `BlocObserver` untuk debugging
- BLoC dengan async event (fetch API)
- `Equatable` untuk state comparison
- Error state dan loading state pattern

**Proyek terkait materi : MovieBloc**
Buat aplikasi pencari film menggunakan TMDB API (free). Implementasikan dengan BLoC: `MovieBloc` dengan events `SearchMovies`, `LoadMoreMovies`, dan states `MovieInitial`, `MovieLoading`, `MovieLoaded`, `MovieError`. Fitur search dengan debounce, infinite scroll (load more), dan halaman detail film. BLoC yang benar-benar production-ready.

---

### Hari 44 : Animasi Lanjutan — AnimationController

- `AnimationController` dan `Tween`
- `AnimatedBuilder` untuk kontrol penuh
- `CurvedAnimation` dan berbagai `Curves`
- Chaining animasi dengan `SequenceAnimation`
- Dart: `mixin` dengan `TickerProviderStateMixin`

**Proyek terkait materi : AnimLab**
Buat "lab animasi" berisi 6 contoh animasi: bounce ball, rotating logo, progress bar animasi, typing text effect, pulse animation, dan slide-in card. Setiap animasi bisa di-trigger dengan tombol. Ini adalah referensi animasi yang bisa kamu pakai ulang di proyek lain. Animasi custom adalah pembeda UI yang besar.

---

### Hari 45 : Rive & Lottie — Animasi Kompleks

- Package `rive` untuk animasi interaktif
- Package `lottie` untuk animasi JSON
- Mengintegrasikan file .riv dan .json ke Flutter
- Trigger state machine di Rive
- Memilih Rive vs Lottie untuk kasus berbeda

**Proyek terkait materi : AnimatedLogin**
Buat halaman login yang keren dengan karakter Rive (tersedia gratis di rive.app community). Saat user mengetik password, mata karakter menutup. Saat login berhasil, ada Lottie animation "checkmark" yang muncul. Ini adalah jenis "wow factor" yang membuat aplikasi diingat pengguna.

---

### Hari 46 : Custom Painter — Grafis Custom

- `CustomPainter` dan `Canvas`
- Menggambar: garis, lingkaran, persegi, path
- `Paint` object: color, strokeWidth, style
- Membuat chart/grafik custom
- Dart: `math` library — sin, cos, pi

**Proyek terkait materi : ChartPainter**
Buat 3 chart custom menggunakan CustomPainter: line chart untuk tracking data mingguan, bar chart untuk perbandingan kategori, dan donut chart untuk persentase. Setiap chart bisa dianimasikan (data muncul dari 0). Ini adalah skill langka yang membedakan Flutter developer biasa dengan yang advanced.

---

### Hari 47 : Responsive Design

- `MediaQuery` — screen size dan orientation
- `LayoutBuilder` untuk responsive berdasarkan parent
- Breakpoint system (mobile, tablet, desktop)
- `Flexible` dan `Expanded` untuk adaptive layout
- Dart: extension on `BuildContext` untuk helper

**Proyek terkait materi : AdaptiveUI**
Buat aplikasi yang terlihat bagus di 3 ukuran: phone (single column), tablet (2 column), desktop/web (sidebar + main content). Gunakan `LayoutBuilder` untuk mendeteksi ukuran dan switch layout. Minimal 3 halaman yang semuanya adaptive. Semakin penting seiring Flutter berkembang ke multi-platform.

---

### Hari 48 : Firebase Setup & Authentication

- Membuat Firebase project dan konfigurasi Flutter
- Install `firebase_core` dan `firebase_auth`
- Email/password sign up dan sign in
- `FirebaseAuth.instance.currentUser`
- Auth state listener dengan StreamBuilder

**Proyek terkait materi : AuthFlow**
Buat sistem autentikasi lengkap: halaman splash → cek auth state → jika belum login: halaman login/register → jika sudah: halaman home. Fitur: register dengan email, login, logout, dan reset password via email. Tambahkan validasi form yang kuat. Ini adalah auth flow yang siap pakai di aplikasi nyata.

---

### Hari 49 : Firestore — Database Cloud

- `cloud_firestore` package
- Collection, document, dan field
- CRUD: `add()`, `set()`, `update()`, `delete()`
- Real-time updates dengan `snapshots()`
- `StreamBuilder` dengan Firestore stream

**Proyek terkait materi : CloudNotes**
Upgrade NoteRiv atau buat ulang: aplikasi catatan yang tersinkronisasi ke Firestore. Setiap user punya notes-nya sendiri (berdasarkan UID). Catatan real-time — jika buka di 2 device, perubahan langsung sync. Fitur: tambah/edit/hapus/cari catatan. Data tidak hilang walau uninstall.

---

### Hari 50 : Firestore Lanjutan & Security Rules

- Query Firestore: `where()`, `orderBy()`, `limit()`
- Compound query dan indexing
- Pagination dengan `startAfterDocument()`
- Firestore Security Rules dasar
- Dart: `QuerySnapshot` dan `DocumentSnapshot`

**Proyek terkait materi : SocialFeed**
Buat feed sosial sederhana: user bisa posting teks/foto, lihat feed dari semua user (timeline), like postingan. Implementasikan pagination — load 10 postingan, scroll ke bawah load 10 lagi. Security rules: user hanya bisa edit/hapus postingan sendiri. Ini adalah fondasi aplikasi sosial media.

---

### Hari 51 : Firebase Storage

- `firebase_storage` package
- Upload file dari device ke Storage
- `UploadTask` dan progress tracking
- Download URL untuk menampilkan file
- Delete file dari Storage

**Proyek terkait materi : AvatarUpload**
Upgrade AuthFlow + SocialFeed: tambahkan fitur upload foto profil ke Firebase Storage. Progress bar saat upload berlangsung. Setelah upload, URL foto disimpan ke Firestore profile user dan ditampilkan di semua tempat yang menampilkan avatar user. Ini adalah fitur yang ada di hampir semua aplikasi sosial.

---

### Hari 52 : Push Notification dengan FCM

- Firebase Cloud Messaging setup
- `firebase_messaging` package
- Handling notifikasi saat app: foreground, background, terminated
- `flutter_local_notifications` untuk notifikasi lokal
- Deep link dari notifikasi ke halaman tertentu

**Proyek terkait materi : NotifPush**
Integrasikan push notification ke SocialFeed: kirim notifikasi saat ada yang like postingan. Implementasikan local notification untuk reminder harian menggunakan `flutter_local_notifications`. Saat notifikasi diklik, langsung navigasi ke halaman yang relevan (deep link). Notifikasi adalah fitur retensi user yang kritis.

---

### Hari 53 : Google Sign In & Social Auth

- Package `google_sign_in`
- Integrasi dengan Firebase Auth
- `signInWithCredential()` dengan Google credential
- Menyimpan info profile Google ke Firestore
- Handling re-authentication

**Proyek terkait materi : SocialLogin**
Upgrade AuthFlow: tambahkan tombol "Masuk dengan Google" di halaman login. Setelah login Google berhasil, cek apakah user baru (buat profile di Firestore) atau returning user. Tampilkan nama dan foto dari Google account. Logout dari Google saat user logout dari app. Social login adalah ekspektasi user modern.

---

### Hari 54 : Local Authentication — Biometrik

- Package `local_auth`
- Face ID dan Touch ID/Fingerprint
- Cek ketersediaan biometrik di device
- Fallback ke PIN/password
- Menyimpan token aman dengan `flutter_secure_storage`

**Proyek terkait materi : SecureVault**
Buat aplikasi "password manager" sederhana: simpan password dalam encrypted storage, terlindungi biometrik. Setiap buka app, harus autentikasi dengan fingerprint/face id dulu baru bisa lihat password yang tersimpan. Kombinasi `local_auth` + `flutter_secure_storage` untuk keamanan nyata.

---

### Hari 55 : Deep Linking & Universal Links

- Konsep deep link dan universal link
- Package `go_router` untuk routing yang lebih powerful
- Definisi routes dengan path parameter
- Redirect dan guard dengan `redirect`
- Query parameter di URL

**Proyek terkait materi : RouterPro**
Refactor aplikasi yang sudah dibuat menggunakan `go_router`. Definisikan semua routes secara deklaratif. Implementasikan: auth guard (redirect ke login jika belum auth), nested routes (tab navigation), route dengan parameter (misal: `/product/:id`). Deep link test: buka URL dari browser → langsung ke halaman yang benar di app.

---

### Hari 56 : Testing — Unit Test

- Mengapa testing itu penting
- `flutter_test` package yang sudah built-in
- Menulis unit test untuk fungsi Dart
- Testing repository dan use case
- `test()`, `expect()`, `group()`, `setUp()`

**Proyek terkait materi : TestDrive**
Buat unit test untuk ExpenseTracker atau proyek lain yang sudah ada. Test: kalkulasi total pengeluaran, filter pengeluaran per kategori, validasi input form, fungsi sorting. Target coverage minimal 70% untuk business logic. Belajar "test-driven thinking" — menulis test dulu baru implementasi.

---

### Hari 57 : Testing — Widget Test

- `WidgetTester` dan `testWidgets()`
- `find.byType()`, `find.text()`, `find.byKey()`
- `tester.tap()`, `tester.enterText()`, `tester.pump()`
- `Key` widget untuk memudahkan testing
- Golden test untuk screenshot comparison

**Proyek terkait materi : WidgetTest**
Tulis widget test untuk komponen UI utama: form login (test validasi), list item (test tap dan navigation), dialog konfirmasi (test tombol). Tambahkan golden test untuk card design — jika desain berubah tidak sengaja, test akan gagal. Widget testing adalah jaring pengaman UI yang berharga.

---

### Hari 58 : CI/CD — GitHub Actions

- Konsep Continuous Integration dan Delivery
- Setup GitHub Actions untuk Flutter project
- Workflow: checkout → setup Flutter → test → build
- Build APK/IPA di CI
- Mengirim notifikasi hasil build

**Proyek terkait materi : DevOpsReady**
Setup GitHub Actions untuk salah satu proyek yang sudah ada. Pipeline: setiap push ke `main` → jalankan semua test → jika lulus → build APK → upload sebagai artifact di GitHub. Tambahkan badge status build di README. Ini adalah skill DevOps Flutter yang sangat dicari di perusahaan.

---

### Hari 59 : Performance Optimization

- Flutter DevTools — CPU profiler, Memory
- `const` widget untuk menghindari rebuild tidak perlu
- `RepaintBoundary` untuk isolasi repaint
- `ListView.builder` vs `ListView` — mengapa penting
- Image caching dengan `cached_network_image`

**Proyek terkait materi : PerfAudit**
Ambil salah satu proyek yang sudah dibuat (SocialFeed atau ShopApp), jalankan Flutter DevTools, identifikasi performance bottleneck, lalu perbaiki satu per satu. Dokumentasikan: before vs after — frame rate, memory usage, startup time. Ini adalah proses yang developer senior lakukan secara rutin.

---

### Hari 60 : Review & Proyek Gabungan Fase 2

- Review state management (Provider, Riverpod, BLoC)
- Review arsitektur clean architecture
- Review Firebase ecosystem
- Review performance dan testing
- Perencanaan proyek besar berikutnya

**Proyek terkait materi : TaskFlow** _(3–4 hari pengerjaan)_
Buat aplikasi manajemen tugas tim (seperti Trello mini). Fitur lengkap: autentikasi Firebase (email + Google), buat workspace/project, tambah kolom (To Do, In Progress, Done), tambah task dengan foto attachment, assign task ke anggota tim, real-time sync via Firestore, push notification saat di-assign task, BLoC untuk state management, clean architecture, minimal 50% test coverage. Ini adalah proyek portofolio pertama yang layak ditunjukkan ke employer.

---

_© Kurikulum Flutter 300 Hari | Part 1: Hari 1–60_
