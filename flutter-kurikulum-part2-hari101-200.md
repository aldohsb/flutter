# 🚀 Flutter Kurikulum — Part 2: Hari 101–200
### Level: Beginner → Intermediate
> Fokus: Build app yang lebih kompleks, UI polished, dan arsitektur yang solid

---

## 🗓️ FASE 5 — Intermediate UI & Animation (Hari 101–130)
> Tujuan: Membuat UI yang benar-benar indah dan animasi yang smooth

---

### Hari 101–107 : Project Portfolio Tracker (Selesai)
*(Lanjutan dari Hari 100 — bangun sampai selesai)*

**Hari 101:** Arsitektur dan setup Riverpod + Hive
**Hari 102:** Fitur log belajar harian — tambah, edit, hapus
**Hari 103:** Streak tracker — logika hitung hari berturut
**Hari 104:** Statistik mingguan + chart bar sederhana
**Hari 105:** Local notification pengingat harian
**Hari 106:** Dark/light mode toggle + polish UI
**Hari 107:** Export ke CSV + final testing dan bug fix

---

### Hari 108 : CustomPainter Lanjut — Path & Bezier
* `Path` object: `moveTo`, `lineTo`, `quadraticBezierTo`, `cubicTo`
* `PathMetrics` — animasi sepanjang path
* Clipping dengan custom path
* Stroke vs fill

**Project terkait : `wave_background_animasi`**
- Buat background dengan gelombang animasi menggunakan CustomPainter
- Gelombang bergerak perlahan (gunakan AnimationController + sine wave)
- Cocok digunakan sebagai background halaman loading atau splash

---

### Hari 109 : Particle Effect & Canvas Animation
* Membuat partikel dengan CustomPainter
* Update posisi partikel di setiap frame
* `Ticker` untuk animasi frame-by-frame
* Performa: hanya repaint area yang berubah dengan `shouldRepaint`

**Project terkait : `konfeti_animasi`**
- Buat efek konfeti yang jatuh dari atas layar
- Konfeti berwarna-warni dengan ukuran dan kecepatan acak
- Trigger animasi saat tombol ditekan
- Tujuan: Celebration effect untuk achievement di app

---

### Hari 110 : Rive Animation
* Apa itu Rive (animasi interaktif yang lebih powerful dari Lottie)
* Package `rive`
* State machine di Rive
* Trigger animasi dari Flutter berdasarkan event

**Project terkait : `karakter_interaktif`**
- Download karakter Rive gratis dari rive.app
- Karakter merespons sentuhan: tap → karakter beranimasi
- Integrasikan state machine: idle → wave → happy
- Tujuan: Animasi interaktif yang terasa hidup

---

### Hari 111–112 : Shader & Visual Effects

**Hari 111:**
* Apa itu Fragment Shader di Flutter
* `FragmentShader` API (Flutter 3.7+)
* Membuat efek visual sederhana dengan GLSL

**Hari 112:**
* Efek: blur, glow, distortion
* Kombinasikan dengan animasi untuk efek dinamis
* Performa shader

**Project terkait (2 hari) : `kartu_holographic`**
- Buat kartu dengan efek holographic shimmer menggunakan shader
- Efek berubah saat kartu digerakkan (gunakan gyroscope atau drag)
- Terinspirasi kartu trading card fisik holographic
- Tujuan: Visual yang benar-benar "wow"

---

### Hari 113 : Drag & Drop
* `Draggable` widget
* `DragTarget` widget
* `LongPressDraggable`
* Feedback widget saat sedang di-drag

**Project terkait : `task_board_kanban`**
- Buat Kanban board dengan 3 kolom: Todo, In Progress, Done
- Task bisa di-drag dari satu kolom ke kolom lain
- Visual feedback saat task sedang di-drag
- Task yang berhasil dipindah berubah posisi di list

---

### Hari 114 : ReorderableListView
* `ReorderableListView` — list yang bisa diurutkan ulang
* `ReorderableListView.builder`
* Callback `onReorder`
* Simpan urutan baru ke storage

**Project terkait : `playlist_musik_reorderable`**
- Buat playlist lagu (data statis)
- User bisa drag lagu untuk mengubah urutan
- Urutan tersimpan ke SharedPreferences
- Tambahkan swipe-to-delete dengan `Dismissible`

---

### Hari 115 : Dismissible & Swipe Actions
* `Dismissible` widget
* Swipe kanan vs swipe kiri: aksi berbeda
* Konfirmasi sebelum hapus
* Undo delete dengan Snackbar

**Project terkait : `inbox_email_gestures`**
- Simulasi inbox email
- Swipe kiri: hapus email (dengan undo)
- Swipe kanan: tandai sudah dibaca (warna berubah)
- Long press: mode seleksi multi-email

---

### Hari 116 : InteractiveViewer & Zoom
* `InteractiveViewer` — pinch to zoom, pan
* Min/max scale
* `TransformationController`
* Kasus penggunaan: map, gambar besar, diagram

**Project terkait : `peta_kampus_interaktif`**
- Buat peta kampus/kota sederhana (gambar statis)
- User bisa pinch zoom dan geser peta
- Marker lokasi (gunakan Stack + Positioned berdasarkan koordinat)
- Tap marker: muncul info popup

---

### Hari 117 : PageView & Carousel
* `PageView` widget
* `PageController` — kontrol halaman secara programmatik
* Dot indicator untuk menunjukkan halaman aktif
* Infinite scroll carousel

**Project terkait : `app_destinasi_wisata`**
- Halaman utama: carousel foto destinasi wisata indah
- Swipe horizontal untuk melihat destinasi berbeda
- Dot indicator di bawah
- Tap foto: pindah ke halaman detail dengan Hero animation

---

### Hari 118 : Stepper & Multi-step Form
* `Stepper` widget — form bertahap
* `StepState`: indexed, editing, complete, disabled
* Validasi per step sebelum lanjut
* Custom stepper design

**Project terkait : `wizard_pembuatan_karakter_game`**
- Multi-step form untuk buat karakter game
- Step 1: Pilih ras (Human, Elf, Dwarf)
- Step 2: Alokasikan skill points
- Step 3: Pilih nama dan warna
- Step 4: Preview karakter + konfirmasi
- Tidak bisa lanjut ke step berikutnya tanpa mengisi yang wajib

---

### Hari 119 : DataTable & Complex Lists
* `DataTable` widget
* `DataColumn` dan `DataRow`
* Sort kolom
* `PaginatedDataTable`

**Project terkait : `leaderboard_game`**
- Tampilkan leaderboard 50 pemain dalam DataTable
- Kolom: Rank, Nama, Skor, Level, Win Rate
- Sort berdasarkan kolom apapun
- Highlight baris pemain saat ini
- Pagination: 10 pemain per halaman

---

### Hari 120 : TabBar & TabBarView
* `TabBar` dan `TabBarView`
* `DefaultTabController`
* Custom tab indicator
* Scrollable TabBar untuk banyak tab

**Project terkait : `app_menu_restoran`**
- Halaman menu restoran dengan TabBar
- Tab: Semua, Makanan, Minuman, Dessert, Promo
- Setiap tab menampilkan grid menu
- Custom tab indicator: warna yang trendi

---

### Hari 121–123 : Custom Widget Library

**Hari 121:**
* Prinsip membuat reusable widget
* Parameter yang fleksibel
* Default values yang masuk akal

**Hari 122:**
* Widget yang komposabel
* Callback dan event dari custom widget
* Dokumentasi widget

**Hari 123:**
* Membuat package lokal (untuk shared widgets)
* Path dependencies di pubspec.yaml

**Project terkait (3 hari) : `design_system_personal`**
- Buat library widget pribadimu: `MyButton`, `MyCard`, `MyTextField`, `MyBadge`, `MyChip`, `MyAvatar`
- Setiap widget punya: variasi size (sm/md/lg), variasi style (primary/secondary/danger), loading state
- Demo app yang menampilkan semua widget
- Tujuan: Design system seperti yang dipakai di perusahaan besar

---

### Hari 124 : Charts & Data Visualization
* Package `fl_chart`
* Line chart, bar chart, pie chart
* Animasi chart saat data berubah
* Interaksi: tap untuk lihat detail nilai

**Project terkait : `dashboard_kesehatan`**
- Dashboard kesehatan pribadi dengan berbagai chart
- Line chart: berat badan 30 hari terakhir
- Bar chart: langkah kaki per hari dalam seminggu
- Pie chart: distribusi waktu tidur, kerja, olahraga
- Data bisa di-edit manual

---

### Hari 125 : Maps Integration
* Package `google_maps_flutter`
* Tampilkan peta dengan custom marker
* Polyline — gambar rute di peta
* Geolocation: dapatkan lokasi user

**Project terkait : `app_jelajah_kuliner`**
- Peta yang menampilkan marker tempat makan di sekitar lokasi user
- Tap marker: muncul card info nama, rating, jarak
- Tombol "Rute ke Sini": tampilkan polyline dari lokasi user ke tujuan
- Filter marker berdasarkan kategori makanan

---

### Hari 126 : WebView Integration
* Package `webview_flutter`
* Tampilkan halaman web dalam app
* Kontrol navigasi: back, forward, reload
* JavaScript channel — komunikasi Flutter ↔ WebView

**Project terkait : `app_browser_mini`**
- Buat browser mini dengan URL bar
- Tombol back, forward, reload, home
- Progress bar saat halaman loading
- Bookmark halaman yang sering dikunjungi (simpan ke Hive)

---

### Hari 127 : Video Player
* Package `video_player`
* Play, pause, seek video
* Custom controls
* Fullscreen mode

**Project terkait : `app_tutorial_memasak_video`**
- List tutorial memasak dengan thumbnail
- Tap tutorial: play video dengan custom controls
- Progress bar yang bisa di-seek
- Tampilkan durasi dan waktu saat ini

---

### Hari 128 : Audio Player
* Package `just_audio` atau `audioplayers`
* Play, pause, stop, seek audio
* Background audio playback
* Playlist management

**Project terkait : `app_meditasi_audio`**
- App meditasi dengan berbagai suara alam (hujan, hutan, laut)
- Play/pause, volume control, timer berapa lama meditasi
- Audio tetap berjalan saat app di-background
- Visual animasi gelombang suara saat audio berjalan

---

### Hari 129 : Biometric Authentication
* Package `local_auth`
* Fingerprint authentication
* Face ID authentication
* Fallback ke PIN jika biometrik tidak tersedia

**Project terkait : `vault_catatan_rahasia`**
- App catatan yang dikunci dengan biometrik
- Buka app: langsung minta fingerprint/face ID
- Jika gagal 3x: minta PIN backup
- Catatan terenkripsi di Hive

---

### Hari 130 : QR Code & Barcode
* Package `qr_flutter` untuk generate QR code
* Package `mobile_scanner` untuk scan QR/barcode
* Decode hasil scan
* Generate QR dari data dinamis

**Project terkait : `kartu_nama_qr`**
- Buat profil digital dengan QR code yang berisi info kontak
- Scan QR: langsung tampilkan info kontak
- Bisa share QR code sebagai gambar
- History QR yang pernah di-scan

---

## 🗓️ FASE 6 — Advanced Architecture & Patterns (Hari 131–165)
> Tujuan: Menulis kode yang maintainable, testable, dan scalable

---

### Hari 131–135 : Domain-Driven Design (DDD) di Flutter

**Hari 131:** Apa itu DDD, Entity, Value Object
**Hari 132:** Aggregates dan Repository interface
**Hari 133:** Domain Events dan Application Services
**Hari 134:** Infrastructure layer: API, Database implementation
**Hari 135:** Presentation layer yang tipis

**Project terkait (5 hari) : `app_manajemen_proyek`**
- App untuk manage proyek tim kecil
- Domain: Project (entity), Task (entity), Member (value object)
- Repository: ProjectRepository, TaskRepository
- Use cases: CreateProject, AssignTask, CompleteTask, GetProjectStats
- UI: list proyek, detail proyek, kanban task board
- Backend: Firestore

---

### Hari 136–138 : Dependency Injection dengan GetIt

**Hari 136:** Apa itu Dependency Injection dan problemnya
**Hari 137:** Setup GetIt — service locator
**Hari 138:** `registerSingleton`, `registerFactory`, `registerLazySingleton`; inject dependencies ke ViewModel/Controller

**Project terkait (3 hari) : `refactor_ke_getit`**
- Ambil app manajemen proyek
- Ganti manual injection dengan GetIt
- Setup semua dependency di satu file `injection.dart`
- Test bahwa semua masih berjalan dengan benar

---

### Hari 139–141 : Advanced Riverpod

**Hari 139:** Riverpod Generator dengan code generation
**Hari 140:** `AsyncNotifier` dan `AsyncNotifierProvider`; `Ref.invalidate()`, `Ref.refresh()`
**Hari 141:** Riverpod + Repository pattern + GetIt

**Project terkait (3 hari) : `app_social_feed`**
- Social feed sederhana: post teks/foto
- Riverpod untuk state: feed, profile, notifications
- Repository pattern untuk data layer
- Infinite scroll dengan pagination
- Optimistic update: like post langsung update UI sebelum server konfirmasi

---

### Hari 142–144 : Error Handling yang Komprehensif

**Hari 142:** `Either<Failure, Success>` dengan package `fpdart` atau `dartz`
**Hari 143:** Custom Failure classes per domain
**Hari 144:** Global error handler, Crash reporting dengan Firebase Crashlytics

**Project terkait (3 hari) : `robust_error_handling`**
- Refactor salah satu app untuk menggunakan `Either` pattern
- Setiap error punya tipe spesifik: NetworkFailure, CacheFailure, ValidationFailure
- UI menampilkan pesan error yang user-friendly berbeda untuk setiap tipe
- Setup Crashlytics untuk log error di production

---

### Hari 145–148 : Advanced Testing

**Hari 145:** Mockito dan build_runner untuk auto-generate mocks
**Hari 146:** Test Riverpod providers dengan `ProviderContainer`
**Hari 147:** Golden tests — screenshot testing
**Hari 148:** End-to-end test dengan Patrol atau integration_test

**Project terkait (4 hari) : `test_suite_lengkap`**
- Ambil app dengan arsitektur bersih
- Unit test: semua use case dan repository
- Widget test: semua screen utama
- Golden test: snapshot visual komponen kunci
- Integration test: flow login sampai lihat data

---

### Hari 149–151 : Code Generation

**Hari 149:** Apa itu code generation di Dart, `build_runner`
**Hari 150:** `freezed` — immutable class dan union types
**Hari 151:** `json_serializable` — JSON parsing otomatis

**Project terkait (3 hari) : `app_dengan_codegen`**
- Buat model class menggunakan `freezed`
- JSON parsing otomatis dengan `json_serializable`
- Sealed class untuk state menggunakan `freezed`
- Rasakan perbedaan: kode manual vs code generation

---

### Hari 152–155 : Feature Flag & Remote Config

**Hari 152:** Apa itu Feature Flag dan kegunaannya
**Hari 153:** Firebase Remote Config — ubah nilai dari console tanpa update app
**Hari 154:** A/B testing dasar dengan Remote Config
**Hari 155:** Toggle fitur experimental per user group

**Project terkait (4 hari) : `app_dengan_feature_flag`**
- Integrasi Firebase Remote Config
- Flag: `show_new_ui` (toggle UI lama vs baru)
- Flag: `max_items_per_page` (ubah dari console)
- Flag: `enable_beta_feature` (aktifkan fitur untuk beta tester)
- Dashboard admin: lihat semua flag yang aktif

---

### Hari 156–158 : Caching Strategy Lanjut

**Hari 156:** Cache-first vs network-first vs stale-while-revalidate
**Hari 157:** Implementasi caching layer di repository
**Hari 158:** Cache invalidation: kapan dan bagaimana

**Project terkait (3 hari) : `app_berita_offline_first`**
- Buat strategi caching yang benar untuk app berita
- Saat online: fetch dari API, simpan ke Hive
- Saat offline: tampilkan dari cache dengan label "Data tersimpan"
- Stale indicator: "Data ini dari 2 jam lalu" jika cache sudah lama
- Tujuan: UX yang mulus di kondisi koneksi apapun

---

### Hari 159–162 : Real-time Features dengan Firestore

**Hari 159:** `snapshots()` stream untuk real-time update
**Hari 160:** Menggabungkan multiple stream dengan `StreamZip` atau Riverpod
**Hari 161:** Optimistic update — update UI dulu, sync ke server belakangan
**Hari 162:** Conflict resolution saat dua user edit data bersamaan

**Project terkait (4 hari) : `app_kolaborasi_catatan`**
- Catatan yang bisa diedit bersama secara real-time (seperti Google Docs mini)
- Ketik di HP satunya → HP lain update real-time via Firestore stream
- Tampilkan siapa yang sedang online (presence system)
- Jika konflik: strategi last-write-wins dengan timestamp

---

### Hari 163–165 : Dart Patterns Lanjut

**Hari 163:** Extension methods — tambah method ke class yang ada
**Hari 164:** Mixins — sharing behavior antar class
**Hari 165:** Generics lanjut — membuat class dan function yang fleksibel

**Project terkait (3 hari) : `dart_advanced_patterns`**
- Extension: tambahkan method `.toFormattedDate()` ke `DateTime`
- Extension: tambahkan method `.toRupiah()` ke `int`
- Mixin: `LoggableMixin` yang tambahkan logging ke Repository apapun
- Generic: buat `Result<T>` class yang bisa bungkus tipe apapun
- Tujuan: Kode yang lebih ekspresif dan DRY

---

## 🗓️ FASE 7 — Build Project Nyata (Hari 166–200)
> Tujuan: Selesaikan satu app besar yang layak masuk portfolio

---

### Hari 166–200 : 🏆 Project Besar — "Habito" (App Pembentuk Kebiasaan)

**Konsep:**
App habit tracker yang serius — lebih dari sekedar checklist. Terinspirasi dari Streaks, Habitica, dan Loop Habit Tracker tapi dengan twist visual yang unik.

**Fitur Lengkap:**
- 🔐 Auth: Google Sign In + Email/Password
- 📋 Buat kebiasaan: nama, ikon, warna, frekuensi (harian/mingguan/hari tertentu), waktu reminder
- ✅ Check-in harian dengan animasi reward
- 🔥 Streak tracker dengan visualisasi api
- 📊 Analytics: grafik konsistensi per minggu/bulan, perbandingan antar kebiasaan
- 🏆 Achievement system: badge untuk milestone (7 hari streak, 30 hari, dll)
- 🎨 3 tema visual: Clean, Playful, Dark
- 👥 Social: share streak ke teman (opsional)
- 📱 Widget home screen (opsional, advanced)
- 🔔 Smart reminder yang tidak muncul jika kebiasaan sudah selesai

**Stack:**
- State Management: Riverpod
- Database: Hive (lokal) + Firestore (cloud sync, opsional)
- Auth: Firebase Auth
- Notification: flutter_local_notifications
- Charts: fl_chart
- Animation: Lottie + custom AnimationController

**Jadwal:**
- **Hari 166–168:** Setup project, arsitektur, design system
- **Hari 169–171:** Fitur buat & kelola kebiasaan (CRUD)
- **Hari 172–174:** Fitur check-in harian + animasi
- **Hari 175–177:** Streak logic + visualisasi
- **Hari 178–180:** Analytics dashboard + charts
- **Hari 181–183:** Achievement system
- **Hari 184–186:** Authentication + cloud sync
- **Hari 187–189:** Notifikasi pintar
- **Hari 190–192:** Theming + polish UI
- **Hari 193–195:** Testing (unit + widget)
- **Hari 196–197:** Bug fix + performance optimization
- **Hari 198–199:** Prepare release: icon, splash, store screenshots
- **Hari 200:** 🎉 Release ke Play Store (atau TestFlight)!

---

> **✅ End of Part 2 — Hari 101-200**
> Lanjut ke Part 3 untuk Hari 201-300 (Upper Intermediate Level)
