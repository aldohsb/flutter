Buatkan panduan materi flutter di bawah ini, beserta file proyek terkait 


materi dengan bahasa yang mudah dimengerti, tambahkan tips trik industri terkait materi jika ada, tambahkan tanya jawab pendalaman materi.
proyek yang dibuat setiap file di tulis di masing-masing artifact agar mudah di copy berikan komentar penjelasan code setiap baris
jangan gunakan syntax code yang sudah deprecated di 2026, versi library yang paling up to date mulai dari inisialisasi proyek sertakan code bash touch mkdir untuk membuat struktur file lengkap semua file termasuk di root.
buatkan juga artifact tersendiri untuk penjelasan algoritma dan logika code utama proyek di atas, penjelasan untuk pemula, mengapa sebuah code ditulis, apa logikanya, untuk apa dan mengapa. 


buatkan quiz pilihan ganda, 15 soal, pilihan jawaban ada 8, pilihan e. benar semua, f. salah semua, g yang benar a dan c, pilihan h yang benar b dan d
tulis di chat bukan html

# 🚀 Kurikulum Flutter 300 Hari — Berbasis Proyek
## Part 3: Hari 121–200 | Expert Level

> **Filosofi**: Di level ini kamu tidak hanya membuat aplikasi — kamu merancang sistem, memimpin arsitektur, mengoptimalkan skala, dan mengajarkan orang lain. Setiap proyek adalah production-grade dan bisa masuk portofolio utama.

---

## 🔴 FASE 5 — EXPERT SYSTEMS (Hari 121–160)
### *"Skala Besar & Sistem Kompleks"*

---

### Hari 121 : Micro-Frontend Architecture di Flutter
* Konsep micro-frontend untuk mobile
* Module Federation pattern
* Dynamic feature delivery (Android) dan App Clips (iOS)
* Communication antar module tanpa tight coupling
* Dart: event bus pattern

**Proyek terkait materi : MicroShop**
Refactor ShopNow menjadi micro-frontend: modul auth, produk, cart, dan pembayaran bisa didelivery secara independen. Implementasikan Android Dynamic Feature Module — fitur "Scanner" hanya di-download saat user pertama kali klik scan. App size awal berkurang drastis, fitur tambahan di-download on-demand.

---

### Hari 122 : Multi-Tenancy & White Label Apps
* Konsep white label application
* Konfigurasi berbasis remote (Remote Config / JSON)
* Tema yang sepenuhnya dynamic
* Brand assets yang bisa di-swap
* Dart: factory pattern untuk configurability

**Proyek terkait materi : WhiteLabel**
Convert ShopNow menjadi white-label e-commerce platform: warna, logo, nama app, fitur yang aktif — semuanya dikontrol dari Firebase Remote Config. "Tenant A" punya tema merah dengan fitur subscription, "Tenant B" punya tema hijau tanpa fitur subscription. Satu codebase, banyak brand. Ini adalah bisnis model SaaS mobile.

---

### Hari 123 : Advanced BLoC — Event Transformer
* `EventTransformer` — `sequential()`, `concurrent()`, `droppable()`, `restartable()`
* `bloc_concurrency` package
* Menangani event burst (banyak event sekaligus)
* BLoC testing yang komprehensif
* `blocTest()` dari `bloc_test` package

**Proyek terkait materi : SearchBloc**
Buat fitur search yang robust dengan BLoC: search event dengan `restartable()` transformer (batalkan search sebelumnya jika user masih mengetik), infinite scroll dengan `droppable()` (abaikan event baru saat sedang load), concurrent like button. Tulis bloc test yang cover semua scenario. BLoC yang event transformer-aware adalah tanda senior developer.

---

### Hari 124 : Advanced Riverpod — Code Generation
* `riverpod_generator` dan `@riverpod` annotation
* `@Riverpod(keepAlive: true)` vs auto-dispose
* `AsyncNotifierProvider` dengan code gen
* `StreamNotifierProvider`
* Testing dengan `ProviderContainer`

**Proyek terkait materi : RiverpodPro**
Refactor FinTrack menggunakan Riverpod dengan code generation: semua provider menggunakan `@riverpod` annotation, auto-dispose untuk provider yang tidak perlu selalu aktif, keepAlive untuk global state (user session). Tulis provider test menggunakan `ProviderContainer`. Code gen Riverpod menghilangkan hampir semua boilerplate.

---

### Hari 125 : Dart Metaprogramming
* `dart:mirrors` (terbatas di Flutter)
* Source generation dengan `build_runner`
* Annotation custom dan `AnnotationProcessor`
* `Macro` — fitur terbaru Dart (experimental)
* Dart: reflection pattern

**Proyek terkait materi : MetaPod**
Buat custom code generator: annotation `@AutoToJson` yang secara otomatis generate method `toJson()` dan `fromJson()` untuk class mana saja. Buat juga annotation `@AutoCopyWith` yang generate `copyWith()`. Publish sebagai package ke pub.dev. Memahami metaprogramming membuka level baru kemampuan Dart.

---

### Hari 126–130 : Proyek Besar — Fintech App *(5 hari)*

**Proyek terkait materi : NeoBank**
Buat aplikasi fintech/neobank yang production-grade:

**Hari 126**: Onboarding KYC simulasi (foto KTP + selfie → ML Kit face matching), security setup (PIN 6 digit + biometrik), arsitektur modular dengan clean arch.

**Hari 127**: Dashboard: saldo virtual, list transaksi terbaru dengan infinite scroll, virtual card dengan animasi flip 3D, quick action (transfer, top-up, bayar).

**Hari 128**: Transfer uang antar user (Firestore transaction untuk atomic operation), riwayat transfer, notifikasi real-time saat terima uang.

**Hari 129**: Pembayaran QRIS simulasi (generate + scan QR), split bill feature (bagi tagihan ke beberapa teman), cicilan calculator.

**Hari 130**: Laporan keuangan dengan chart, investasi simulasi (reksa dana/saham dengan data fake), security audit (certificate pinning, jailbreak detection, root detection), publish ke internal testing.

---

### Hari 131 : Jailbreak & Root Detection
* Package `flutter_jailbreak_detection`
* Mendeteksi rooted Android device
* Mendeteksi jailbroken iOS device
* Debugging prevention di production
* Reverse engineering protection

**Proyek terkait materi : SecurityShield**
Tambahkan security layer ke NeoBank: jailbreak/root detection (tampilkan warning dan batasi fitur jika terdeteksi), disable screenshot (Android: `FLAG_SECURE`, iOS: native overlay), obfuscate string sensitif di kode, anti-debugging check. Security di fintech bukan optional — ini mandatory.

---

### Hari 132 : Background Processing Lanjutan
* `background_fetch` untuk iOS background fetch
* Android foreground service
* `flutter_background_service` package
* Periodic location tracking di background
* Battery optimization handling

**Proyek terkait materi : TrackBack**
Buat aplikasi tracking lokasi yang berjalan di background: mulai tracking → app bisa diminimize → lokasi terus direcord ke Firestore setiap 30 detik → tampilkan rute di peta. Foreground service notification yang informatif. Handle battery optimization request. Ini adalah teknik yang dipakai di aplikasi delivery dan field force.

---

### Hari 133 : WebRTC — Video Call
* `flutter_webrtc` package
* Signaling server dengan WebSocket/Firebase
* ICE candidates dan SDP exchange
* Camera preview dan remote stream
* Screen sharing

**Proyek terkait materi : VideoPeer**
Buat aplikasi video call sederhana: 2 user bisa video call satu sama lain menggunakan WebRTC dengan Firebase sebagai signaling server. Fitur: mute audio, matikan kamera, switch kamera depan/belakang, end call. WebRTC adalah teknologi dibalik Zoom, Google Meet, dan FaceTime — memahaminya membuka peluang besar.

---

### Hari 134 : Advanced Camera — Custom Camera UI
* `camera` package untuk kontrol penuh
* Manual focus dan exposure control
* Zoom camera
* Flash control
* Frame processing untuk ML/AR

**Proyek terkait materi : ProCamera**
Buat kamera custom dengan UI yang lebih kaya dari kamera default: zoom dengan pinch gesture, focus tap dengan animasi focus square, exposure slider, timer otomatis, grid overlay, dan filter warna sederhana (processed di Dart). Setelah foto, tampilkan preview sebelum save. Custom camera membuat pengalaman fotografi dalam app menjadi premium.

---

### Hari 135 : Notification Advanced — Scheduled & Rich
* `flutter_local_notifications` — advanced features
* Scheduled notification (repeating, specific time)
* Rich notification dengan gambar dan action button
* Notification channels (Android)
* Handling notification tap dan payload parsing

**Proyek terkait materi : SmartRemind**
Buat aplikasi pengingat berbasis smart notification: jadwalkan pengingat harian/mingguan/bulanan, notifikasi kaya dengan preview tugas dan action button (Selesai / Tunda 10 menit / Buka app), notification channel terpisah untuk different urgency level. Ini adalah notification system yang diharapkan pengguna di 2025+.

---

### Hari 136–140 : Proyek Besar — Healthcare App *(5 hari)*

**Proyek terkait materi : MediCare**
Buat aplikasi kesehatan personal yang komprehensif:

**Hari 136**: Setup dengan HealthKit (iOS) / Health Connect (Android) melalui `health` package. Dashboard kesehatan: langkah kaki, detak jantung, kalori, tidur — data real dari sensor device.

**Hari 137**: Booking dokter: list dokter (spesialis, rating, jadwal), pilih slot waktu, konfirmasi booking, reminder notification H-1 dan H-0.

**Hari 138**: Rekam medis digital: riwayat penyakit, alergi, obat-obatan yang sedang dikonsumsi. Upload dokumen (hasil lab, resep). Semua tersimpan encrypted.

**Hari 139**: Telemedicine: video call dengan dokter (WebRTC), chat dengan dokter (Firestore), kirim foto keluhan, e-prescription PDF yang bisa di-share ke apotek.

**Hari 140**: Farmasi: cari obat, cek ketersediaan apotek terdekat (Maps), order obat dengan delivery, notifikasi minum obat (scheduled notification). Privacy-first: semua data health dienkripsi.

---

### Hari 141 : Design System Engineering
* Atomic design principle dalam Flutter
* Token-based design system (spacing, color, typography sebagai const)
* Component library yang scalable
* Storybook-like showcase untuk Flutter
* Versioning design system

**Proyek terkait materi : DesignToken**
Buat design system package yang bisa dipakai di semua proyek: `design_tokens.dart` berisi semua konstanta (spacing 4/8/12/16/24/32, color palette, typography scale), widget library (Button variants, Input variants, Card variants, Badge), dan showcase app yang menampilkan semua komponen. Publish ke pub.dev atau private repo.

---

### Hari 142 : Advanced Navigation — Deep Link & Branch
* Universal links yang kompleks
* Deferred deep link (install app dulu, buka link setelah install)
* Branch.io atau Firebase Dynamic Links
* App indexing (konten app muncul di Google search)
* `go_router` advanced — redirect, guards, shell routes

**Proyek terkait materi : DeepNav**
Implementasikan deferred deep link di ShopNow: user dapat link produk di WhatsApp → klik → jika sudah install langsung buka halaman produk, jika belum install → redirect ke Play Store → setelah install, otomatis buka produk yang dimaksud. Ini adalah teknik growth hacking yang powerful.

---

### Hari 143 : Flutter dan AI — LLM Integration
* OpenAI API atau Gemini API integration
* Streaming response dari LLM
* Prompt engineering dalam konteks mobile
* `langchain_dart` package
* On-device LLM dengan `mlkit` atau `llm_dart`

**Proyek terkait materi : AiAssist**
Tambahkan AI assistant ke FinTrack: user bisa tanya "Berapa total pengeluaran makan bulan ini?" atau "Beri saran cara hemat dari pola pengeluaranku". AI dapat context dari data transaksi user (dikirim sebagai context ke LLM). Streaming response sehingga jawaban muncul karakter per karakter. AI yang personal dan kontekstual.

---

### Hari 144 : Performance Profiling Expert
* CPU profiling dengan Flutter DevTools timeline
* Memory profiling — detect memory leak
* GPU rendering profiling
* Network profiling
* Jank detection dan elimination

**Proyek terkait materi : PerfMaster**
Lakukan comprehensive performance audit pada Vibe atau ShopNow: (1) Record timeline saat scroll feed → identifikasi frame drops → fix dengan `const`, `RepaintBoundary`, `AutomaticKeepAlive`. (2) Memory audit — cari leak di StreamSubscription yang tidak di-cancel. (3) Startup time profiling — lazy load heavy initialization. Target: 60fps konsisten dan startup < 2 detik.

---

### Hari 145–150 : Proyek Besar — Super App *(6 hari)*

**Proyek terkait materi : OmniApp**
Buat "super app" yang menggabungkan beberapa layanan dalam satu aplikasi (seperti Gojek/WeChat mini):

**Hari 145**: Shell app dengan dynamic module loading. Home screen dengan grid layanan. Auth yang shared antar module.

**Hari 146**: Module "Pesan Antar" — browse restoran, menu, cart, order, tracking driver real-time.

**Hari 147**: Module "Transfer" — transfer antar pengguna, riwayat, notifikasi. Integrasi dengan NeoBank wallet.

**Hari 148**: Module "Belanja" — toko, produk, cart, checkout. Reuse dari ShopNow dengan adaptasi.

**Hari 149**: Module "Berita & Hiburan" — feed berita, video shorts, streaming audio. Mini browser untuk konten eksternal.

**Hari 150**: Polish: super app home yang personal (rekomendasi berdasarkan history), performance optimization untuk multi-module, Analytics terpusat, publish ke beta testing.

---

### Hari 151 : Advanced Dart — Type System Expert
* Variance (covariance, contravariance)
* `typedef` dan function type alias
* Callable class
* Dart generics advanced — bounded type parameters
* Pattern matching dengan `switch` expression (Dart 3+)

**Proyek terkait materi : DartExpert**
Buat library utility Dart yang showcase advanced type system: type-safe event bus dengan generics, result type (`Result<T, E>`) mirip Rust, pattern matching untuk API response handling, callable class untuk function composition. Publish ke pub.dev. Dikombinasi dengan komentar dokumentasi yang lengkap.

---

### Hari 152 : Dart 3 — Records & Patterns
* Dart 3 Records: `(String, int)` dan named records
* Destructuring: list, map, dan record
* Pattern matching di switch dan if
* `sealed class` untuk exhaustive matching
* Guard clause dalam pattern

**Proyek terkait materi : Dart3App**
Refactor CleanNews atau FinTrack menggunakan fitur Dart 3: use case return `Result<Data, AppError>` menggunakan Records, API response parsing dengan pattern matching, sealed class untuk komprehensif state handling (`sealed class AuthState { ... }`), dan destructuring di everywhere yang relevan. Kode yang lebih ekspresif dan aman.

---

### Hari 153 : Server-Side Dart — Dart Frog
* `dart_frog` untuk backend Dart
* REST API dengan Dart Frog
* Middleware dan dependency injection
* Deployment ke Cloud Run / Vercel Edge
* Full-stack Dart: shared model antara app dan server

**Proyek terkait materi : DartStack**
Buat backend sederhana untuk salah satu proyek menggunakan Dart Frog: API endpoints untuk produk dan user, middleware auth dengan JWT, shared model package yang dipakai oleh Flutter app DAN server (satu kode, dua platform). Deploy ke Cloud Run. Full-stack Dart = satu bahasa untuk segalanya.

---

### Hari 154 : Flutter Plugin Development
* Perbedaan package vs plugin
* Membuat plugin dengan Kotlin/Swift native code
* `MethodChannel` dari sisi plugin
* Federated plugin architecture
* Publishing plugin ke pub.dev

**Proyek terkait materi : CustomPlugin**
Buat Flutter plugin yang mengakses fitur native yang belum ada di pub.dev: misal "thermal API" (baca suhu CPU device), "clipboard image" (paste gambar dari clipboard), atau "app usage stats" (baca statistik penggunaan app lain di Android). Ini adalah kontribusi nyata ke ekosistem Flutter.

---

### Hari 155 : Advanced Testing — TDD & Mocking
* Test-Driven Development workflow
* `mockito` dan `mocktail` untuk mocking
* Testing BLoC dengan `bloc_test`
* Testing Riverpod dengan `ProviderContainer`
* Mutation testing konsep

**Proyek terkait materi : TDDProject**
Buat fitur baru di FinTrack menggunakan TDD murni: tulis test dulu → implementasi → refactor. Gunakan mocktail untuk mock repository dan external dependency. Bloc test untuk semua state transition. Target: 90%+ coverage untuk feature yang dibuat dengan TDD. Rasakan perbedaan confidence ketika kode punya test yang baik.

---

### Hari 156 : Scalable Architecture — DDD
* Domain-Driven Design (DDD) concepts
* Bounded context dalam mobile app
* Aggregate, Entity, Value Object
* Domain events
* CQRS pattern sederhana untuk mobile

**Proyek terkait materi : DDDApp**
Refactor NeoBank menggunakan DDD: identifikasi bounded contexts (Account, Transaction, KYC), buat domain model yang kaya (Entity `Account` dengan behavior, tidak hanya data), domain events (`MoneyTransferred`, `AccountVerified`) yang trigger side effects. DDD cocok untuk domain yang kompleks seperti fintech.

---

### Hari 157 : Multi-Window & Split Screen
* Platform view untuk native widget
* Flutter pada embedded display
* Multi-window support (Android 12+)
* Drag and drop antar window
* State sharing antar window

**Proyek terkait materi : MultiWindow**
Buat aplikasi yang memanfaatkan multi-window Android: TabletMode dengan panel kiri (list) dan panel kanan (detail) yang independent, support drag file dari Files app ke dalam app, secondary display support. Ini adalah frontier baru Flutter untuk tablet dan foldable device.

---

### Hari 158 : Accessibility Expert
* WCAG 2.1 guideline untuk mobile
* Contrast ratio checker
* Dynamic font size support (TextScaleFactor)
* Reduced motion support
* Switch access support
* TalkBack/VoiceOver testing

**Proyek terkait materi : A11yAudit**
Comprehensive accessibility audit MediCare atau FinTrack: (1) Semua interaktif element punya Semantics label yang bermakna. (2) App masih usable dengan ukuran font 200%. (3) Semua warna punya contrast ratio ≥ 4.5:1. (4) Animasi bisa dimatikan lewat system setting. (5) Test manual dengan TalkBack aktif. Accessibility bukan nice-to-have — ini hak semua pengguna.

---

### Hari 159 : Internationalization Expert
* Pluralization dan gender in ARB files
* Right-to-left (RTL) layout support
* Number, date, dan currency formatting per locale
* Bidirectional text handling
* Pseudo-localization untuk testing

**Proyek terkait materi : GlobalReady**
Tambahkan dukungan RTL ke ShopNow atau OmniApp: Arabic atau Hebrew sebagai second language. Semua layout harus flip otomatis, ikon directional harus mirror, text alignment menyesuaikan. Test dengan pseudo-localization untuk deteksi string yang tidak di-localize. App yang mendukung RTL membuka pasar Timur Tengah yang besar.

---

### Hari 160 : Open Source Leadership
* Cara maintain open source project
* Issue triage dan pull request review
* Semantic versioning dan changelog automation
* GitHub Actions untuk package publishing
* Community building

**Proyek terkait materi : OSLead**
Pilih salah satu package yang sudah kamu buat dan jadikan project open source yang serius: buat GitHub repo dengan README profesional, CONTRIBUTING.md, issue templates, GitHub Actions untuk CI + auto-publish ke pub.dev saat tag baru. Announce di Flutter Community (Twitter/X, Reddit, Discord). Maintainer open source = credibility yang luar biasa.

---

## 🟣 FASE 6 — MASTERY (Hari 161–200)
### *"Spesialisasi & Kontribusi"*

---

### Hari 161–170 : Proyek Besar — EdTech App *(10 hari)*

**Proyek terkait materi : LearnFlow**
Buat platform edukasi online yang komprehensif:

**Hari 161**: Arsitektur dan auth. Onboarding: pilih topik minat → personalized curriculum.

**Hari 162**: Halaman kursus: list kursus, filter, search, detail kursus dengan silabus.

**Hari 163**: Video pembelajaran dengan custom player: playback speed, quality selection, subtitle, bookmark timestamp.

**Hari 164**: Quiz interaktif: multiple choice, true/false, drag-match, fill in blank — dengan timer dan scoring.

**Hari 165**: Progress tracking: streak belajar (habit loop), XP points, level up animation, leaderboard.

**Hari 166**: Offline download: download video untuk ditonton offline, progress download yang bisa di-pause/resume.

**Hari 167**: Komunitas: forum diskusi per course, Q&A dengan upvote, mention instructor.

**Hari 168**: Sertifikat digital: generate PDF sertifikat dengan nama user dan course yang selesai, share ke LinkedIn.

**Hari 169**: Monetisasi: subscription bulanan/tahunan (in-app purchase), one-time course purchase, voucher/promo code system.

**Hari 170**: Analytics untuk instructor: mana video yang paling sering di-pause (struggle point), completion rate, student engagement score. A/B test konten pembelajaran.

---

### Hari 171 : Flutter untuk Wearable — WearOS
* `wear_plus` package untuk WearOS
* Circular layout untuk layar bulat
* Watch face development dasar
* Komplikasi WearOS
* Sync data antara phone app dan watch

**Proyek terkait materi : WristTrack**
Buat WearOS companion app untuk FinTrack: watch face yang menampilkan total pengeluaran hari ini, komplikasi untuk cepat-tambah pengeluaran, dan notifikasi saat mendekati budget limit — semuanya tampil di pergelangan tangan. Wearable adalah platform yang masih jarang dikuasai developer Flutter.

---

### Hari 172 : Flutter untuk TV — Android TV
* Android TV manifest configuration
* D-pad navigation dan focus management
* `focus_traversal` dan `FocusNode`
* Leanback UI pattern
* Remote control simulation

**Proyek terkait materi : StreamTV**
Buat aplikasi streaming konten untuk Android TV: home screen dengan carousel konten, navigasi penuh D-pad (remote TV), halaman detail konten, dan video player fullscreen. Focus management yang benar adalah kunci — setiap element harus bisa dijangkau dengan D-pad tanpa kebingungan. TV = layar besar, pola UX yang berbeda total.

---

### Hari 173 : Advanced Maps — Custom Tile Layer
* Custom map style dengan Mapbox atau MapLibre
* Tile layer custom
* Heatmap layer untuk visualisasi data
* Clustering marker yang banyak
* Offline map tile download

**Proyek terkait materi : GeoVis**
Buat aplikasi visualisasi data geospasial: tampilkan 1000+ titik data (misal: lokasi ATM, warung, dll) dengan clustering yang efisien, heatmap layer yang menunjukkan kepadatan, offline map tile untuk area tertentu yang bisa dipakai tanpa internet. Custom map style yang branded. GIS dalam mobile adalah skill yang dicari di startup data dan pemerintahan.

---

### Hari 174 : Game Development dengan Flutter
* `flame` package untuk game development
* Game loop, component, dan world
* Sprite dan animation
* Collision detection
* Audio dalam game

**Proyek terkait materi : FlameRunner**
Buat game endless runner sederhana menggunakan Flame: karakter yang berlari (animated sprite), rintangan yang muncul dari kanan, lompat dengan tap, gravity simulation, skor dan high score, sound effect dan background music, game over dan restart. Game di Flutter = user engagement yang tinggi, bisa di-embed di aplikasi utama sebagai reward feature.

---

### Hari 175–185 : Proyek Besar — AgriTech App *(11 hari)*

**Proyek terkait materi : TaniCerdas**
Buat aplikasi pertanian pintar yang menggabungkan banyak teknologi:

**Hari 175**: Onboarding petani: profil lahan (luas, jenis tanah, lokasi GPS), jenis tanaman.

**Hari 176**: Dashboard lahan: cuaca real-time di lokasi lahan (Weather API), rekomendasi aktivitas hari ini berdasarkan cuaca.

**Hari 177**: Kalender tanam: tanggal tanam, estimasi panen, jadwal pemupukan/pestisida — dengan notifikasi terjadwal.

**Hari 178**: Diagnosa tanaman: foto daun tanaman → ML Kit image classification → identifikasi penyakit → saran penanganan (gunakan model pre-trained atau Gemini Vision API).

**Hari 179**: Pasar digital: petani bisa listing hasil panen, pembeli bisa browse dan order, chat langsung.

**Hari 180**: Logistik: tracking pengiriman hasil panen, integrasi Maps untuk rute ke pembeli.

**Hari 181**: Keuangan petani: catat pengeluaran modal dan pemasukan penjualan, analisis untung/rugi per musim tanam.

**Hari 182**: Komunitas petani: forum tanya jawab, berbagi foto pertanian, livestream panen.

**Hari 183**: Offline-first: semua fitur berjalan tanpa internet, sync saat ada koneksi (penting untuk daerah terpencil).

**Hari 184**: Bahasa lokal: dukungan Bahasa Indonesia dan minimal 2 bahasa daerah (Jawa, Sunda, atau Bugis).

**Hari 185**: Government integration: koneksi ke program subsidi pertanian (API pemerintah simulasi), pelaporan data pertanian, sertifikasi digital hasil panen organik.

---

### Hari 186 : Flutter Embedded — Automotive & IoT
* Flutter di embedded Linux
* `flutter-elinux` dan `flutter-pi`
* Input dari GPIO, sensor, dan hardware
* Dashboard automotive UI
* Kiosk mode dan locked screen

**Proyek terkait materi : EmbedDash**
Buat dashboard untuk Raspberry Pi menggunakan Flutter Embedded: tampilan suhu, kelembaban, kualitas udara dari sensor GPIO, grafik historis 24 jam, kontrol lampu/kipas via relay. UI yang dioptimalkan untuk layar touchscreen kecil tanpa keyboard/mouse. Flutter embedded = Flutter dimana-mana.

---

### Hari 187 : Advanced Security — Penetration Testing Mindset
* Threat modeling untuk mobile app
* Reverse engineering protection dengan obfuscation
* Anti-tampering dan integrity check
* Network security: man-in-the-middle prevention
* Secure coding checklist untuk Flutter

**Proyek terkait materi : SecAudit**
Lakukan security audit menyeluruh pada NeoBank: (1) Gunakan apktool untuk decompile APK sendiri dan lihat apa yang bisa dilihat attacker. (2) Aktifkan ProGuard + Flutter obfuscation. (3) Implementasikan integrity check (Google Play Integrity API). (4) Penetration test simulasi: replay attack prevention, parameter tampering protection. Dokumentasikan semua temuan dan perbaikan.

---

### Hari 188 : Flutter di Cloud — Server-Side Rendering
* Flutter Web dengan server-side rendering
* `dart_frog` untuk SSR
* Hydration dan SEO
* Edge deployment dengan Vercel/Cloudflare
* Core Web Vitals untuk Flutter Web

**Proyek terkait materi : WebSSR**
Buat landing page marketing untuk ShopNow atau LearnFlow menggunakan Flutter Web dengan SSR: halaman yang di-render di server untuk SEO optimal, metadata Open Graph untuk social sharing, schema.org structured data, Core Web Vitals yang bagus (LCP < 2.5s). Ini adalah Flutter Web yang siap production dan SEO-friendly.

---

### Hari 189–195 : Proyek Besar — PropTech App *(7 hari)*

**Proyek terkait materi : HomeFinder**
Buat aplikasi properti (seperti Rumah123 / Zillow mini):

**Hari 189**: Listing properti: browse dengan filter lengkap (harga, lokasi, tipe, luas, fasilitas), tampilan map view dan list view.

**Hari 190**: Detail properti: foto gallery dengan virtual tour 360° sederhana (`panorama` package), floor plan interaktif, fasilitas terdekat di maps.

**Hari 191**: AR View: `ar_flutter_plugin` untuk lihat furnitur virtual di rumah kosong — pilih sofa → AR tap di lantai → sofa muncul di kamera.

**Hari 192**: KPR Calculator: simulasi cicilan dengan berbagai parameter (DP, tenor, bunga), perbandingan bank, eligibility check.

**Hari 193**: Booking kunjungan: pilih jadwal kunjungan properti, video call virtual tour dengan agen (WebRTC), review dan rating agen.

**Hari 194**: Proses KPR digital: upload dokumen KTP/slip gaji/rekening koran, AI check kelengkapan dokumen (ML Kit), status tracking proses KPR.

**Hari 195**: Notifikasi cerdas: alert harga properti turun di wishlist, properti baru di area favorit, reminder jadwal kunjungan, market insight mingguan (harga rata-rata per area).

---

### Hari 196 : Technical Writing & Documentation
* Menulis ADR (Architecture Decision Record)
* API documentation dengan dartdoc
* Runbook untuk operasional
* Technical blog writing
* Presenting technical decision ke non-technical audience

**Proyek terkait materi : DocMaster**
Dokumentasikan OmniApp atau salah satu proyek besar secara komprehensif: (1) README yang sangat baik dengan diagram arsitektur, cara setup, dan cara contribute. (2) ADR untuk 3 keputusan arsitektur penting. (3) Wiki internal dengan panduan onboarding developer baru. (4) Tulis artikel blog teknis panjang tentang arsitektur proyek. Documentation = tanda seorang tech lead.

---

### Hari 197 : Mentoring & Code Review
* Cara memberikan code review yang konstruktif
* Pair programming best practices
* Teaching vs telling dalam mentoring
* Menyusun learning path untuk junior developer
* Tech talk preparation

**Proyek terkait materi : MentorKit**
Buat "starter kit" Flutter untuk junior developer baru: template project dengan arsitektur yang sudah di-setup, code style guide, contoh implementasi untuk pattern yang sering dipakai (API call, form, navigation), dan onboarding guide "30 hari pertama Flutter". Bagikan ke komunitas. Mengajar adalah cara belajar terbaik.

---

### Hari 198 : Entrepreneurship — Dari App ke Bisnis
* App monetization strategies
* Market research untuk ide app
* MVP (Minimum Viable Product) thinking
* App Store Optimization (ASO)
* Growth hacking untuk mobile app

**Proyek terkait materi : LaunchPlan**
Buat business plan untuk salah satu aplikasi yang ingin dikomersialisasikan: (1) Analisis kompetitor. (2) Target user persona. (3) Monetization model (freemium, subscription, one-time, b2b). (4) ASO strategy: keyword research, icon A/B test, screenshot optimization. (5) Go-to-market plan 90 hari pertama. (6) Unit economics: CAC vs LTV. Aplikasi bagus tanpa bisnis model = hobi. Dengan bisnis model = perusahaan.

---

### Hari 199 : Contributing to Flutter Framework
* Setup Flutter engine untuk development
* Cara menemukan good first issue di GitHub
* Membuat PR ke flutter/flutter
* Flutter RFC process
* Flutter Community engagement

**Proyek terkait materi : FlutterContrib**
Mulai berkontribusi ke ekosistem Flutter: (1) Fix bug kecil di package populer yang kamu gunakan — submit PR. (2) Improve dokumentasi Flutter yang kurang jelas — submit PR ke flutter.dev. (3) Jawab 5 pertanyaan di StackOverflow tentang Flutter. (4) Post di Flutter Community Discord/Slack. Contributor Flutter = network yang luar biasa.

---

### Hari 200 : Milestone — Review Hari 121–200
* Review semua proyek besar yang sudah dibuat
* Tech stack yang dikuasai — update di LinkedIn/Resume
* Identifikasi gap dan rencana pembelajaran selanjutnya
* Mentoring session: ajarkan seseorang materi dari Fase 1-2
* Celebrate! 200 hari adalah pencapaian luar biasa.

**Proyek terkait materi : ShowcasePro**
Buat "showcase app" yang menampilkan semua proyek terbaik dalam satu aplikasi dengan navigasi yang rapi: setiap proyek punya halaman sendiri dengan: screenshot, tech stack yang dipakai, tantangan yang dihadapi, dan link ke GitHub. Flutter Web version dari showcase ini bisa menjadi portofolio online yang sangat impressive. Ini adalah resume visual kamu sebagai Flutter developer.

---

*© Kurikulum Flutter 300 Hari | Part 3: Hari 121–200*
