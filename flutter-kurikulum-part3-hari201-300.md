# ⚡ Flutter Kurikulum — Part 3: Hari 201–300
### Level: Intermediate → Upper Intermediate
> Fokus: Performa, platform-specific, advanced patterns, dan kontribusi open source

---

## 🗓️ FASE 8 — Advanced Flutter Internals (Hari 201–230)
> Tujuan: Pahami cara Flutter bekerja di balik layar agar bisa debug dan optimize dengan tepat

---

### Hari 201–203 : Flutter Rendering Pipeline

**Hari 201:**
* 3 tree di Flutter: Widget Tree, Element Tree, RenderObject Tree
* Perbedaan antara ketiganya dan bagaimana sinkronisasi
* `BuildContext` — sebenarnya apa itu?

**Hari 202:**
* Layout phase: constraints go down, sizes go up
* Paint phase: bagaimana widget digambar ke layar
* Compositing: layer dan GPU

**Hari 203:**
* `repaintBoundary` — mengoptimalkan area yang perlu repaint
* `shouldRebuild` dan `shouldRepaint` yang benar
* Membaca Flutter DevTools Rendering section

**Project terkait (3 hari) : `rendering_experiment`**
- Buat app yang dengan sengaja bermasalah (banyak rebuild tidak perlu)
- Gunakan DevTools Widget Inspector untuk melihat rebuild yang terjadi
- Perbaiki satu per satu dengan `const`, `RepaintBoundary`, `ValueListenableBuilder`
- Bandingkan frame rate sebelum dan sesudah di DevTools Performance

---

### Hari 204–206 : Keys di Flutter

**Hari 204:**
* Mengapa Flutter butuh Keys
* `LocalKey` vs `GlobalKey`
* `ValueKey`, `ObjectKey`, `UniqueKey`

**Hari 205:**
* Kapan `GlobalKey` harus digunakan (dan kapan tidak)
* Keys dalam animasi list (permasalahan tanpa key vs dengan key)
* `GlobalObjectKey`

**Hari 206:**
* `GlobalKey` untuk akses state dari luar
* Masalah performa `GlobalKey` dan alternatifnya

**Project terkait (3 hari) : `demo_keys`**
- Buat demo visual: list 5 item berwarna, tombol shuffle
- Tanpa key: lihat animasi yang salah
- Dengan ValueKey: animasi perpindahan yang benar
- Demo GlobalKey: akses form dari widget parent

---

### Hari 207–209 : Inherited Widget & InheritedModel

**Hari 207:**
* Apa itu `InheritedWidget` — pondasi dari semua state management
* Membuat custom InheritedWidget dari nol
* `of(context)` pattern

**Hari 208:**
* `InheritedModel` — update yang lebih granular dari InheritedWidget
* Aspect-based rebuilding

**Hari 209:**
* Perbandingan: InheritedWidget vs Provider vs Riverpod — mana di atas mana?
* Kapan membuat InheritedWidget custom vs pakai library

**Project terkait (3 hari) : `custom_theme_provider`**
- Buat ThemeProvider menggunakan pure InheritedWidget (tanpa package)
- Simpan theme mode, font size preference, color scheme
- Widget apapun dalam tree bisa akses dan ubah tema
- Tujuan: Pahami Provider sesungguhnya bekerja di atas InheritedWidget

---

### Hari 210–212 : Flutter Web (Dasar)

**Hari 210:**
* Perbedaan Flutter Web vs Flutter Mobile: rendering, API, limitasi
* `flutter build web` — build dan deploy
* Responsive design untuk layar besar

**Hari 211:**
* Platform-specific code: `kIsWeb`
* URL strategy: hash vs path
* SEO di Flutter Web (limitasi dan workaround)

**Hari 212:**
* Deploy ke Firebase Hosting / Vercel / Netlify
* PWA (Progressive Web App) dengan Flutter

**Project terkait (3 hari) : `portfolio_web_flutter`**
- Buat website portfolio pribadimu menggunakan Flutter Web
- Responsive: mobile dan desktop layout berbeda
- Halaman: Home (hero section), Proyek (grid), Skill, Kontak
- Deploy ke Firebase Hosting — punya URL publik
- Tujuan: Portfolio yang bisa dibagikan!

---

### Hari 213–215 : Flutter Desktop (Dasar)

**Hari 213:**
* Setup Flutter untuk Windows/macOS/Linux
* Perbedaan dengan mobile: menu bar, window management, mouse hover
* Desktop-specific widgets

**Hari 214:**
* `MenuBar` dan `MenuAnchor`
* `ContextMenuRegion` untuk right-click menu
* Keyboard shortcuts dengan `Shortcuts` widget

**Hari 215:**
* Window management: ukuran minimum, maximize, minimize
* Package `window_manager`
* File system access: package `file_picker`

**Project terkait (3 hari) : `app_catatan_desktop`**
- App catatan markdown yang berjalan di desktop
- Sidebar: list catatan
- Main area: editor markdown (pakai package `flutter_markdown`)
- Keyboard shortcut: Ctrl+N buat catatan baru, Ctrl+S simpan
- Right-click pada catatan: menu hapus/rename
- Simpan ke file sistem lokal

---

### Hari 216–218 : Dart FFI (Foreign Function Interface)

**Hari 216:**
* Apa itu FFI dan kapan digunakan
* Memanggil fungsi C dari Dart
* Binding Dart ke library native

**Hari 217:**
* Memory management di FFI: `malloc`, `free`, `Pointer`
* Tipe FFI: `Int32`, `Double`, `Pointer`, dll

**Hari 218:**
* Contoh nyata: binding ke crypto library
* Async FFI dengan `NativeCallable`

**Project terkait (3 hari) : `dart_ffi_image_processor`**
- Buat FFI binding sederhana ke library C untuk manipulasi pixel gambar
- Fungsi: convert ke grayscale, tambah noise
- Proses gambar di thread terpisah via Isolate + FFI
- Tujuan: Tahu cara akses native code performa tinggi

---

### Hari 219–222 : Advanced State Patterns

**Hari 219:**
* State Machines dengan package `statemachine`
* Definisikan state, event, transisi yang legal

**Hari 220:**
* CQRS (Command Query Responsibility Segregation) pattern di Flutter
* Pisahkan "perintah" dan "query" data

**Hari 221:**
* Event Sourcing konsep dasar
* Kapan pattern ini berguna

**Hari 222:**
* UndoManager — implementasi undo/redo
* Command pattern untuk reversible actions

**Project terkait (4 hari) : `editor_diagram_sederhana`**
- App editor diagram (node + connection)
- Tambah node, hapus, pindah dengan drag
- Undo/redo menggunakan Command pattern
- State machine: node bisa dalam state selected/editing/normal
- Export diagram sebagai gambar

---

### Hari 223–225 : Advanced Networking

**Hari 223:**
* WebSocket di Flutter dengan `web_socket_channel`
* Koneksi real-time tanpa Firestore
* Reconnection logic

**Hari 224:**
* GraphQL dengan package `graphql_flutter`
* Queries, Mutations, Subscriptions
* Apollo-style caching

**Hari 225:**
* gRPC — protocol buffer dengan Flutter
* Server Sent Events (SSE)

**Project terkait (3 hari) : `app_chat_websocket`**
- App chat real-time menggunakan WebSocket
- Gunakan server WebSocket gratis (websocket.org echo atau buat sendiri di Heroku)
- Kirim dan terima pesan real-time
- Tampilkan "mengetik..." indicator
- History chat tersimpan lokal di Hive

---

### Hari 226–228 : Encryption & Security

**Hari 226:**
* Keamanan data di Flutter: apa yang perlu diperhatikan
* `flutter_secure_storage` — simpan data sensitif
* Jangan simpan API key di kode!

**Hari 227:**
* Enkripsi data dengan `encrypt` package
* AES encryption/decryption
* Hashing dengan SHA

**Hari 228:**
* Certificate pinning — hindari MITM attack
* Root detection
* Obfuscation saat build release

**Project terkait (3 hari) : `password_manager_mini`**
- App menyimpan password yang terenkripsi
- Master password untuk buka app (hash-nya disimpan di secure storage)
- Password tiap akun dienkripsi dengan AES sebelum disimpan ke Hive
- Generate password acak yang kuat
- Salin ke clipboard dengan auto-clear setelah 30 detik

---

### Hari 229–230 : Advanced Animations — Staggered & Orchestration

**Hari 229:**
* `AnimationGroup` — koordinasi banyak animasi
* Staggered animation: delay antar elemen
* `Interval` untuk mengatur timing dalam satu controller

**Hari 230:**
* `AnimatedList` — list yang animasi saat item ditambah/hapus
* `AnimatedGrid`
* Flip card animation

**Project terkait (2 hari) : `app_onboarding_premium`**
- 5 halaman onboarding dengan animasi yang benar-benar memukau
- Elemen masuk dengan staggered animation (satu per satu, bukan semua sekaligus)
- Transisi antar halaman: shared element + fade
- Skip button yang muncul setelah animasi pertama selesai
- Tujuan: First impression yang tidak terlupakan

---

## 🗓️ FASE 9 — Monetization & Growth (Hari 231–260)
> Tujuan: Buat app yang bisa menghasilkan, pahami ekosistem bisnis app

---

### Hari 231–233 : In-App Purchase

**Hari 231:**
* Konsep IAP: subscription vs one-time vs consumable
* Setup di Google Play Console dan App Store Connect
* Package `in_app_purchase`

**Hari 232:**
* Fetch products dari store
* Initiate purchase flow
* Verify purchase (penting untuk keamanan!)

**Hari 233:**
* Restore purchases
* Handle pending purchases
* Server-side validation (penting untuk subscription)

**Project terkait (3 hari) : `app_dengan_premium`**
- Ambil salah satu app yang sudah dibuat
- Tambahkan "Premium" tier: beberapa fitur dikunci
- Tombol upgrade ke premium
- Simulasi purchase flow (sandbox testing)
- Setelah "purchase": unlock fitur premium
- Tujuan: Pahami monetization dari dalam

---

### Hari 234–235 : AdMob Integration

**Hari 234:**
* Setup Google AdMob
* Banner ads, Interstitial ads, Rewarded ads
* Package `google_mobile_ads`

**Hari 235:**
* Ad frequency capping — jangan terlalu banyak iklan
* GDPR compliance: consent dialog
* Strategi: hybrid model (ads untuk free, no ads untuk premium)

**Project terkait (2 hari) : `app_kuis_dengan_ads`**
- App kuis 10 pertanyaan harian
- Setelah tiap 3 pertanyaan: banner ad
- Setelah game over: interstitial ad (skip setelah 5 detik)
- Tombol "Remove Ads": IAP untuk hapus iklan selamanya

---

### Hari 236–238 : Analytics & User Behavior

**Hari 236:**
* Firebase Analytics — event tracking
* Log event: screen view, button tap, purchase, error
* User properties: subscriber, free user, dll

**Hari 237:**
* Mixpanel atau Amplitude (alternatif Firebase Analytics)
* Funnel analysis: dari install sampai purchase
* Retention analysis

**Hari 238:**
* A/B testing dengan Firebase Remote Config
* Experiment: dua versi UI, mana yang lebih baik?
* Interpretasi data analytics untuk keputusan produk

**Project terkait (3 hari) : `analytics_dashboard_app`**
- Integrasi Firebase Analytics ke salah satu app
- Track semua aksi penting: open app, buat item, share, dll
- Buat custom dashboard di Firebase Console (event + funnel)
- Setup A/B test: 2 versi halaman onboarding
- Tunggu data (pakai test user) dan analisis hasilnya

---

### Hari 239–241 : ASO & Store Optimization

**Hari 239:**
* App Store Optimization (ASO) — apa itu
* Riset keyword untuk nama dan deskripsi app
* Icon dan screenshot yang convert

**Hari 240:**
* Rating dan review management
* Strategi meminta rating pada waktu yang tepat
* Merespons review negatif

**Hari 241:**
* Lokalisasi store listing untuk pasar berbeda
* Seasonal update dan featured content

**Project terkait (3 hari) : `store_listing_kit`**
- Untuk app terbaikmu, buat store listing lengkap:
  - Judul dan deskripsi yang dioptimasi untuk keyword
  - 8 screenshot yang menarik (gunakan tool seperti previewed.app)
  - Promo banner 1024x500px
  - Short description (80 karakter max, yang paling menarik)
- Tujuan: Siap publish dengan profil terbaik

---

### Hari 242–244 : User Onboarding & Retention

**Hari 242:**
* Apa itu onboarding yang baik vs buruk
* Prinsip: tunjukkan value secepat mungkin
* Onboarding flow design

**Hari 243:**
* Push notification strategy untuk retention
* Waktu terbaik mengirim notifikasi
* Personalized notification

**Hari 244:**
* Re-engagement: win-back users yang tidak aktif
* Daily/weekly digest notification
* Gamification elements: streak, points, badges

**Project terkait (3 hari) : `retention_system`**
- Lanjutan app Habito (Hari 200)
- Tambahkan smart notification: "Kamu belum check-in hari ini, ayo jaga streak-mu!"
- Notifikasi tidak muncul jika semua kebiasaan sudah selesai
- Weekly summary setiap Minggu malam: "Minggu ini kamu konsisten di 3 dari 5 kebiasaan"
- Celebration notification saat capai milestone

---

### Hari 245–248 : Backend dengan Firebase Functions

**Hari 245:**
* Apa itu Firebase Cloud Functions
* Setup Node.js functions
* Trigger: HTTP, Firestore, Auth

**Hari 246:**
* Scheduled functions: cron job
* Callable functions dari Flutter
* Environment variables untuk functions

**Hari 247:**
* Kirim push notification via FCM dari Cloud Function
* Trigger: saat ada event di Firestore, kirim notif ke user terkait

**Hari 248:**
* Security: validasi request di Cloud Functions
* Integrasi payment webhook (Midtrans/Stripe)

**Project terkait (4 hari) : `notification_system_backend`**
- Cloud Function yang jalan setiap jam 07.00: kirim reminder ke semua user yang belum check-in
- Cloud Function: saat user mencapai 30-day streak → kirim notifikasi achievement
- Callable function: generate shareable achievement card (gambar)
- Semua dipanggil dari Firebase, bukan dari Flutter langsung

---

### Hari 249–251 : App Performance di Production

**Hari 249:**
* Monitoring performa di production: Firebase Performance
* Trace: ukur berapa lama operasi tertentu
* Network request monitoring

**Hari 250:**
* ANR (App Not Responding) — cara diagnosa dan fix
* Memory leak detection di production
* Crash-free rate target

**Hari 251:**
* Gradle build optimization (Android)
* Xcode build optimization (iOS)
* Reduce app size: split APK, deferred loading

**Project terkait (3 hari) : `performance_audit`**
- Integrasikan Firebase Performance ke app terbesar
- Tambahkan custom trace di 5 operasi kritis (fetch data, build UI, dll)
- Ukur cold start time
- Identifikasi bottleneck dan perbaiki minimal 2

---

### Hari 252–255 : Dart Server (Backend Sederhana)

**Hari 252:**
* Dart sebagai backend dengan `shelf` package
* Setup HTTP server sederhana
* Routing dan middleware

**Hari 253:**
* ORM: `drift` atau koneksi langsung ke PostgreSQL
* CRUD endpoint
* JSON serialization

**Hari 254:**
* Authentication di backend: JWT
* Rate limiting
* Cors handling

**Hari 255:**
* Deploy ke Railway.app atau Fly.io
* Connect Flutter app ke backend Dart sendiri

**Project terkait (4 hari) : `custom_api_backend`**
- Buat REST API sederhana dengan Dart Shelf
- Endpoint: GET /posts, POST /posts, PUT /posts/:id, DELETE /posts/:id
- Auth: JWT bearer token
- Database: PostgreSQL di Railway
- Flutter app yang consume API buatanmu sendiri

---

### Hari 256–260 : Open Source Contribution

**Hari 256:**
* Cara membaca dan memahami codebase orang lain
* Konvensi kontribusi open source: fork, branch, PR
* Membaca CONTRIBUTING.md

**Hari 257:**
* Cari "good first issue" di repositori Flutter packages
* Reproduce bug yang dilaporkan
* Menulis fix yang proper

**Hari 258:**
* Membuat Flutter package dari nol
* Publish ke pub.dev
* Menulis dokumentasi yang baik

**Hari 259:**
* Semantic versioning untuk package
* Changelog yang informatif
* Maintain package: issue response, update dependency

**Hari 260:**
* Buat example app untuk demo package
* Screenshot dan GIF demo untuk README

**Project terkait (5 hari) : `package_flutter_pubdev`**
- Buat Flutter package yang genuinely berguna (bukan sekedar latihan)
- Ide: `flutter_streak_widget` — widget streak calendar yang cantik dan fleksibel
- Publish ke pub.dev dengan skor pub points yang tinggi
- Dokumentasi lengkap: README, API docs, example app
- Bagikan di komunitas Flutter Indonesia!

---

## 🗓️ FASE 10 — Spesialisasi (Hari 261–300)
> Tujuan: Pilih satu area untuk dikuasai lebih dalam

---

### Hari 261–275 : Track A — UI/UX Engineering

*(Pilih ini jika kamu ingin fokus ke bidang UI dan desain sistem)*

**Hari 261–263:**
* Design Tokens — variabel desain yang sistematis
* Membuat token sistem: spacing, typography, color, radius
* Sinkronisasi Figma → Flutter

**Hari 264–266:**
* Motion Design principles: easing, timing, choreography
* 12 prinsip animasi Disney diterapkan ke UI
* Membuat animasi yang terasa "alami"

**Hari 267–269:**
* Accessibility audit mendalam
* WCAG 2.1 guideline untuk mobile
* Implementasi semantic navigation, focus management

**Hari 270–272:**
* Design System versioning dan governance
* Dark mode yang benar-benar baik (bukan sekadar warna dibalik)
* Adaptive icons dan gambar

**Hari 273–275:**
* Micro-interactions library
* Haptic feedback yang tepat
* Sound design di mobile app

**Project terkait (15 hari) : `DesignKit — Design System Package`**
- Buat Flutter package design system yang komprehensif
- 20+ widget yang konsisten: Button, Input, Card, Modal, Toast, Badge, Avatar, Chip, Tabs, Accordion...
- Setiap widget: 3 variant, 3 size, dark/light mode, animasi smooth
- Demo app yang interaktif layaknya Storybook
- Dokumentasi setiap komponen dengan contoh penggunaan

---

### Hari 276–290 : Track B — Backend & Data Engineering

*(Pilih ini jika kamu ingin fokus ke data dan integrasi sistem)*

**Hari 276–278:** Supabase sebagai Firebase alternative: Auth, Database (PostgreSQL), Storage, Realtime
**Hari 279–281:** GraphQL server dengan Hasura + integrasi Flutter
**Hari 282–284:** WebRTC untuk video call di Flutter dengan `flutter_webrtc`
**Hari 285–287:** Machine Learning On-Device dengan TensorFlow Lite + Flutter
**Hari 288–290:** BLE (Bluetooth Low Energy) dengan `flutter_blue_plus`

**Project terkait (15 hari) : `app_video_call_peer`**
- App video call peer-to-peer menggunakan WebRTC
- Signaling server dengan Dart Shelf
- Fitur: video call, audio call, chat text selama call, flip camera, mute
- Untuk 2 pengguna via kode unik (bukan perlu daftar akun)

---

### Hari 291–300 : Senior-Level Practices

**Hari 291–292:**
* Technical debt — apa itu, cara ukur, cara manage
* Refactoring yang aman: test dulu, baru ubah

**Hari 293–294:**
* Code review sebagai reviewer maupun reviewee
* Memberikan feedback yang konstruktif
* Menerima kritik kode dengan lapang dada

**Hari 295–296:**
* Dokumentasi teknis: Architecture Decision Records (ADR)
* Diagram arsitektur dengan Mermaid
* Onboarding developer baru ke proyekmu

**Hari 297–298:**
* Estimasi pengerjaan yang realistis
* Breaking down task yang besar
* Mengelola hutang teknis secara aktif

**Hari 299–300:**
* Review perjalanan 300 hari
* Update CV dan portfolio dengan semua yang sudah dibuat
* Buat case study mendalam dari project terbaikmu

**Project terkait (10 hari) : `dokumentasi_proyek_lengkap`**
- Pilih project terbaikmu (Habito atau app terbesar)
- Buat README.md yang profesional: arsitektur, cara run, cara test, cara contribute
- Buat Architecture Decision Record: kenapa pilih Riverpod? kenapa Hive? dll
- Buat diagram arsitektur (flow data, layer diagram)
- Buat video demo 2-3 menit (opsional tapi sangat recommended!)
- Upload ke GitHub dengan semua dokumentasi — ini bisa jadi killer portfolio piece

---

> **✅ End of Part 3 — Hari 201-300**
> Lanjut ke Part 4 untuk Hari 301-400 (Advanced Level)
