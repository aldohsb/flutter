Buatkan panduan materi flutter di bawah ini, beserta file proyek terkait 


materi dengan bahasa yang mudah dimengerti, tambahkan tips trik industri terkait materi jika ada, tambahkan tanya jawab pendalaman materi.
proyek yang dibuat setiap file di tulis di masing-masing artifact agar mudah di copy berikan komentar penjelasan code setiap baris
jangan gunakan syntax code yang sudah deprecated di 2026, versi library yang paling up to date mulai dari inisialisasi proyek sertakan code bash touch mkdir untuk membuat struktur file lengkap semua file termasuk di root.
buatkan juga artifact tersendiri untuk penjelasan algoritma dan logika code utama proyek di atas, penjelasan untuk pemula, mengapa sebuah code ditulis, apa logikanya, untuk apa dan mengapa. 


buatkan quiz pilihan ganda, 15 soal, pilihan jawaban ada 8, pilihan e. benar semua, f. salah semua, g yang benar a dan c, pilihan h yang benar b dan d
tulis di chat bukan html

# 🚀 Kurikulum Flutter 300 Hari — Berbasis Proyek
## Part 2: Hari 61–120 | Intermediate — Menuju Expert

> **Filosofi**: Di fase ini kamu mulai membangun aplikasi yang benar-benar kompleks dan production-ready. Arsitektur yang bersih, performa yang optimal, dan pengalaman pengguna yang mulus menjadi prioritas utama.

---

## 🟠 FASE 3 — INTERMEDIATE ADVANCED (Hari 61–90)
### *"Fitur Kompleks & Integrasi Nyata"*

---

### Hari 61 : Maps & Geolocation
* Package `google_maps_flutter` setup dan API key
* Menampilkan peta dengan marker custom
* Package `geolocator` untuk GPS location
* Menghitung jarak antar dua titik
* `geocoding` untuk konversi koordinat ke alamat

**Proyek terkait materi : NearbyEats**
Buat aplikasi yang menampilkan restoran terdekat di sekitar lokasi user. Tampilkan peta Google Maps dengan marker untuk setiap restoran (gunakan data statis dulu, nanti bisa integrate Places API). List restoran di bawah peta, urutkan berdasarkan jarak. Saat marker diklik, tampilkan info window dengan nama dan rating. Maps adalah skill sangat dicari.

---

### Hari 62 : Maps Lanjutan — Polyline & Directions
* Menggambar polyline (garis rute) di peta
* Directions API untuk rute navigasi
* Animasi kamera bergerak mengikuti rute
* Custom marker dengan widget custom
* `LatLngBounds` untuk fit semua marker di layar

**Proyek terkait materi : RouteMapper**
Upgrade NearbyEats: tambahkan fitur "Navigasi ke sini". Saat tombol diklik, tampilkan rute dari lokasi user ke restoran tujuan menggunakan Directions API. Gambar polyline di atas peta, tampilkan estimasi jarak dan waktu tempuh. Kamera bergerak untuk menampilkan seluruh rute. Real navigation experience!

---

### Hari 63 : Video Player & Media
* Package `video_player`
* Play, pause, seek, volume control
* `Chewie` untuk UI video player yang lengkap
* Thumbnail dari video
* Fullscreen video mode

**Proyek terkait materi : VideoFeed**
Buat aplikasi video feed mirip TikTok/Reels (sederhana). List video yang bisa di-scroll vertikal, auto-play saat video masuk viewport, pause saat scroll ke video lain, like dan komentar counter di sisi kanan. Gunakan video URL dari internet. Tantangan: mengatur lifecycle video player saat scroll agar performa tetap bagus.

---

### Hari 64 : Audio Player
* Package `just_audio` untuk audio playback
* Play, pause, seek bar, volume
* Background audio dengan `audio_service`
* Playlist management
* Notification player controls (lock screen)

**Proyek terkait materi : PodcastApp**
Buat aplikasi podcast sederhana dengan: daftar episode podcast (data dari feed RSS atau statis), audio player dengan mini player di bottom bar, full player screen dengan cover art besar, seek bar, previous/next episode, background playback, dan kontrol di notification bar/lock screen. Audio yang berjalan di background adalah UX yang user harapkan.

---

### Hari 65 : Camera & Barcode Scanner
* Package `camera` untuk akses kamera langsung
* Preview kamera dalam widget
* Capture foto dan simpan
* Package `mobile_scanner` untuk scan QR/barcode
* Overlay custom di atas camera preview

**Proyek terkait materi : ScanPay**
Buat aplikasi scanner QR sederhana: scan QR code → tampilkan isi/URL dari QR → jika URL, bisa langsung buka di browser. Tambahkan fitur buat QR code sendiri dari teks/URL yang diinput user. Bonus: tambahkan riwayat scan yang tersimpan. QR scanner adalah fitur yang sangat umum di aplikasi fintech dan retail.

---

### Hari 66 : WebView & Browser In-App
* Package `webview_flutter`
* Load URL dan HTML string
* `NavigationDelegate` untuk intercept navigation
* JavaScript bridge — Flutter ↔ JS komunikasi
* Progress indicator saat loading

**Proyek terkait materi : ArticleReader**
Buat aplikasi pembaca artikel yang membuka URL berita di WebView in-app. Fitur: progress bar loading, tombol back/forward/refresh, share URL, dan open in browser. Tambahkan JavaScript injection untuk mode baca (hapus iklan dan nav dari halaman web). Ini adalah pattern yang dipakai banyak superapp.

---

### Hari 67 : Connectivity & Offline Mode
* Package `connectivity_plus` untuk cek koneksi
* Mendeteksi perubahan koneksi secara real-time
* Strategy offline-first: cache → tampilkan → refresh
* `Hive` atau `sqflite` sebagai cache layer
* UI untuk status offline yang informatif

**Proyek terkait materi : OfflineFirst**
Upgrade NewsReader atau CoinWatch dengan kemampuan offline: data yang pernah di-fetch disimpan ke local database. Saat tidak ada koneksi, tampilkan data terakhir yang tersimpan dengan banner "Mode Offline — data per [waktu terakhir update]". Saat koneksi kembali, auto-refresh. Offline mode adalah tanda aplikasi yang matang.

---

### Hari 68 : Dart Isolate & Background Processing
* Dart single-threaded dan event loop
* `Isolate` untuk komputasi berat
* `compute()` function — cara mudah pakai isolate
* `WorkManager` untuk background task terjadwal
* Dart: `SendPort` dan `ReceivePort`

**Proyek terkait materi : HeavyLifter**
Buat aplikasi yang memproses data berat tanpa freeze UI: (1) Import CSV besar (1000+ baris) di isolate → tampilkan progress → tampilkan hasil. (2) Background sync setiap 30 menit menggunakan WorkManager. (3) Kompresi gambar di background sebelum upload. Ini adalah skill yang membedakan developer yang mengerti performa.

---

### Hari 69 : Platform Channel — Native Code
* Konsep Method Channel Flutter ↔ Native
* Membuat MethodChannel di Flutter (Dart side)
* Implementasi di Android (Kotlin)
* Implementasi di iOS (Swift)
* EventChannel untuk data streaming dari native

**Proyek terkait materi : NativeBridge**
Buat aplikasi yang mengakses fitur native: (1) Baca info device (model, OS version, battery level) melalui Method Channel. (2) Getaran/haptic feedback custom. (3) Brightness screen control. Ini adalah "jembatan" ke dunia native yang kadang diperlukan ketika tidak ada package Flutter yang tersedia.

---

### Hari 70 : Accessibility & Internasionalisasi
* Semantic widget untuk screen reader
* `Semantics` widget dan `excludeSemantics`
* `flutter_localizations` setup
* `intl` package untuk format tanggal, angka, mata uang
* ARB file untuk translation strings

**Proyek terkait materi : GlobalApp**
Upgrade salah satu proyek (ShopApp atau TaskFlow) dengan dukungan 2 bahasa (Indonesia dan English) dan accessibility. Semua teks dalam ARB file, user bisa ganti bahasa dari settings. Format harga sesuai locale (Rp untuk ID, $ untuk EN). Semua tombol punya Semantics label untuk screen reader. Ini adalah standar aplikasi enterprise.

---

### Hari 71–75 : Proyek Besar — E-Commerce App *(5 hari)*

**Proyek terkait materi : ShopNow**
Buat aplikasi e-commerce lengkap dengan semua fitur yang telah dipelajari:

**Hari 71**: Setup arsitektur (clean arch + BLoC), Firebase auth (email + Google), halaman splash dan onboarding.

**Hari 72**: Halaman home (banner slider, kategori, produk featured), halaman kategori, halaman search dengan filter.

**Hari 73**: Halaman detail produk (foto slider + zoom, varian, stok, deskripsi), tambah ke cart, wishlist.

**Hari 74**: Halaman cart, checkout form (alamat + payment method), order summary, konfirmasi order.

**Hari 75**: Halaman profil, riwayat pesanan, push notification (order status update), offline mode untuk produk yang pernah dilihat.

Aplikasi ini adalah portofolio utama yang menunjukkan kemampuan end-to-end Flutter development.

---

### Hari 76 : Advanced Animation — Staggered
* `StaggeredAnimationBuilder` dari package `flutter_staggered_animations`
* List item yang muncul satu per satu
* Page transition custom
* `TweenSequence` untuk animasi bertahap
* Dart: `vsync` dan `TickerProvider`

**Proyek terkait materi : SmoothFeed**
Buat halaman feed dengan animasi masuk yang mulus: setiap card muncul dari bawah dengan delay yang bertahap (staggered). Halaman transition custom menggunakan `PageRouteBuilder`. Tombol-tombol punya micro-animation saat ditekan. Tambahkan animasi skeleton loading sebelum data muncul. Polish animasi adalah perbedaan antara aplikasi biasa dan aplikasi yang dicinta.

---

### Hari 77 : Infinite Scroll & Pagination
* Pagination strategy: offset-based vs cursor-based
* Mendeteksi scroll near-bottom dengan `ScrollController`
* `flutter_infinite_scroll_pagination` package
* Loading indicator di bottom list
* Error handling saat load page gagal

**Proyek terkait materi : InfinityFeed**
Implement infinite scroll di SocialFeed atau ShopNow. Gunakan cursor-based pagination Firestore (`startAfterDocument`). Tampilkan loading shimmer di bottom saat load page baru. Jika error, tampilkan tombol "Coba lagi". Scroll ke halaman 5–10 tanpa masalah memori. Pagination yang benar adalah tanda developer yang peduli performa.

---

### Hari 78 : Search & Filter Advanced
* Debounce untuk search input (pakai `RxDart` atau manual)
* Search lokal vs remote
* Filter multi-kriteria (harga, rating, kategori)
* Sort multiple field
* Highlight kata kunci dalam hasil search

**Proyek terkait materi : SmartSearch**
Upgrade fitur search di ShopNow: (1) Auto-suggest saat mengetik (debounce 300ms). (2) Recent search history (simpan ke Hive). (3) Filter panel yang bisa slide dari bawah: range harga (RangeSlider), kategori (multi-select chip), rating minimum, sort by. (4) Highlight keyword dalam hasil. Search yang baik = retensi user yang tinggi.

---

### Hari 79 : Charts & Data Visualization
* Package `fl_chart` — line, bar, pie chart
* Animasi chart saat data muncul
* Interactive chart (tap untuk detail)
* `syncfusion_flutter_charts` untuk chart lebih advanced
* Dart: komputasi statistik dasar

**Proyek terkait materi : DashMetric**
Buat dashboard analytics yang menampilkan: line chart tren penjualan 30 hari, bar chart top 5 kategori produk, pie chart distribusi payment method, dan metric card (total revenue, total order, average order value). Semua chart interaktif — tap untuk lihat detail hari/kategori tertentu. Dashboard seperti ini umum di aplikasi admin/merchant.

---

### Hari 80 : Drag & Drop
* `LongPressDraggable` dan `DragTarget`
* `ReorderableListView` untuk list yang bisa diurutkan ulang
* Drag between containers
* Visual feedback saat drag
* `flutter_reorderable_grid_view` package

**Proyek terkait materi : KanbanBoard**
Buat Kanban board dengan 3 kolom (To Do, In Progress, Done). Setiap task bisa di-drag dari satu kolom ke kolom lain. Urutan dalam kolom juga bisa diubah dengan long-press drag. Perubahan langsung tersimpan ke Firestore. Ini adalah interaksi yang rumit tapi sangat memukau jika berhasil.

---

### Hari 81–85 : Proyek Besar — Social Media App *(5 hari)*

**Proyek terkait materi : Vibe**
Buat aplikasi sosial media mini dengan feed, stories, dan direct message.

**Hari 81**: Auth Firebase + profil user (foto, bio, link), halaman home feed dengan postingan (teks + foto).

**Hari 82**: Stories (foto yang hilang setelah 24 jam), story viewer dengan progress bar di atas.

**Hari 83**: Fitur like, komentar (nested), follow/unfollow user, notifikasi aktivitas.

**Hari 84**: Direct message (1-on-1) menggunakan Firestore real-time, read receipt, kirim foto.

**Hari 85**: Explore page (search user + konten populer), infinite scroll, halaman notifikasi, optimisasi performa dan image caching.

Proyek ini mendemonstrasikan kemampuan membangun sistem real-time yang kompleks.

---

### Hari 86 : Slivers Advanced
* `SliverPersistentHeader` untuk custom header
* `SliverFillRemaining` untuk konten yang mengisi sisa
* `SliverPadding` dan `SliverToBoxAdapter`
* Nested scroll view
* Parallax effect dengan Sliver

**Proyek terkait materi : ParallaxScroll**
Buat halaman artikel/destinasi wisata dengan: parallax header image (scroll ke bawah, gambar bergerak lebih lambat), sticky tab bar di tengah, dan konten di bawah tab. Tambahkan SliverPersistentHeader untuk kategori yang menempel saat scroll. Efek scroll yang halus dan premium ini sangat disukai desainer.

---

### Hari 87 : Flutter Web — Dasar
* Mengaktifkan web support di Flutter project
* Perbedaan rendering: HTML vs CanvasKit
* Responsif untuk layar lebar
* Web-specific: SEO metadata, favicon, URL strategy
* `url_launcher` dan navigasi web

**Proyek terkait materi : WebPortfolio**
Build halaman portofolio developer menggunakan Flutter Web. Responsive untuk mobile dan desktop. Bagian: hero section, tentang saya, skill dengan progress bar, proyek dengan card, kontak. Deploy ke Firebase Hosting agar bisa diakses online. URL-nya bisa dibagikan ke recruiter!

---

### Hari 88 : Flutter Desktop — Windows/macOS
* Mengaktifkan desktop support
* Window size dan management
* Desktop-specific UX: menu bar, context menu, hover
* `window_manager` package
* Keyboard shortcuts

**Proyek terkait materi : DesktopNotes**
Port aplikasi catatan (CloudNotes) ke desktop. Tambahkan: sidebar navigation yang selalu terlihat (karena layar lebar), keyboard shortcut (Ctrl+N untuk note baru, Ctrl+S simpan), right-click context menu, window resize yang mulus. Desktop UX sangat berbeda dari mobile — eksplor perbedaannya.

---

### Hari 89 : Monetisasi — In-App Purchase
* Package `in_app_purchase`
* Setup produk di App Store Connect dan Google Play Console
* Restore purchase
* Subscription vs one-time purchase
* Receipt validation dasar

**Proyek terkait materi : ProUnlock**
Tambahkan sistem premium ke salah satu aplikasi: beberapa fitur terkunci di balik "Pro Version". Implementasikan pembelian satu kali dan subscription bulanan (sandbox mode). Setelah beli, semua fitur terbuka. Restore purchase saat reinstall. Ini adalah skill yang langsung menghasilkan uang dari aplikasi kamu.

---

### Hari 90 : Review Fase 3 & Persiapan Expert
* Review semua konsep Fase 3
* Audit kualitas kode proyek yang sudah dibuat
* Buat README dan dokumentasi proyek
* Setup App Store / Play Store listing
* Rencana fitur untuk Fase 4

**Proyek terkait materi : AppStore Ready** *(lanjutan dari ShopNow atau Vibe)*
Siapkan salah satu aplikasi untuk publish: buat icon dan splash screen (menggunakan `flutter_launcher_icons` dan `flutter_native_splash`), buat screenshot untuk store listing, buat privacy policy page, setup app signing, generate release build (APK dan AAB). Publish ke Google Play Internal Testing. Aplikasi di store = credibility nyata.

---

## 🔴 FASE 4 — ADVANCED FLUTTER (Hari 91–120)
### *"Arsitektur Expert & Spesialisasi"*

---

### Hari 91 : GraphQL Client
* Perbedaan REST vs GraphQL
* Package `graphql_flutter`
* Query, Mutation, Subscription
* `GraphQLClient` setup dan `HttpLink`
* Caching di GraphQL client

**Proyek terkait materi : GraphNews**
Buat aplikasi berita menggunakan GraphQL API publik (misal: Space X API atau GitHub GraphQL API). Implementasikan: query untuk list data, mutation untuk like/favorite, subscription untuk update real-time. Bandingkan developer experience vs REST. GraphQL semakin populer di startup modern.

---

### Hari 92 : WebSocket & Real-time Communication
* `web_socket_channel` package
* Membuka dan menutup koneksi WebSocket
* Mengirim dan menerima pesan
* Reconnect logic jika koneksi terputus
* Dart: Stream untuk WebSocket messages

**Proyek terkait materi : LiveChat**
Buat aplikasi live chat menggunakan WebSocket (bisa pakai Ably atau Pusher free tier). Fitur: masuk room chat dengan username, kirim pesan teks, lihat siapa yang sedang online (presence), typing indicator ("X sedang mengetik..."), reconnect otomatis jika koneksi putus. Real-time yang sesungguhnya!

---

### Hari 93 : Encryption & Keamanan Data
* `encrypt` package untuk AES/RSA encryption
* Hashing dengan `crypto` package
* Secure storage dengan `flutter_secure_storage`
* Certificate pinning dengan Dio
* OWASP Mobile Top 10 — awareness

**Proyek terkait materi : SecureChat**
Upgrade LiveChat dengan end-to-end encryption: pesan dienkripsi di client sebelum dikirim, hanya penerima yang bisa decrypt. Simpan private key di secure storage. Tambahkan certificate pinning agar tidak bisa di-intercept dengan proxy. Ini adalah implementasi keamanan yang dipakai di aplikasi messaging profesional.

---

### Hari 94 : Custom Hooks & Composable Logic
* Package `flutter_hooks`
* `useState`, `useEffect`, `useMemoized`, `useCallback`
* Membuat custom hook yang reusable
* Hooks vs StatefulWidget — tradeoffs
* Hooks dengan Riverpod

**Proyek terkait materi : HooksMaster**
Refactor dua komponen kompleks menggunakan flutter_hooks. Buat custom hooks: `useDebounce(value, duration)`, `usePagination(fetchFn)`, `useFormField(initialValue, validator)`. Demonstrasikan bagaimana hooks membuat kode lebih bersih dan reusable dibandingkan StatefulWidget konvensional.

---

### Hari 95 : Code Generation — Build Runner
* `json_serializable` dan `json_annotation`
* `freezed` untuk immutable data class
* `auto_route` untuk type-safe routing
* Menjalankan `build_runner watch`
* Dart: code generation flow

**Proyek terkait materi : FrozenApp**
Refactor model classes di salah satu proyek menggunakan `freezed`: union types untuk state (loading, data, error), copyWith yang generated, equality yang otomatis benar. Gunakan `auto_route` untuk routing yang sepenuhnya type-safe. Code generation mengurangi boilerplate dan bug secara signifikan.

---

### Hari 96 : Dependency Injection — GetIt
* Konsep Dependency Injection (DI) dan IoC
* Package `get_it` sebagai service locator
* `Injectable` dan code generation untuk DI
* Singleton, factory, dan lazy singleton
* DI dalam clean architecture

**Proyek terkait materi : DIClean**
Refactor CleanNews atau TaskFlow menggunakan GetIt + Injectable. Daftarkan semua dependency (repository, use case, service) di service locator. Widget tidak lagi membuat instance langsung. Testing menjadi lebih mudah karena dependency bisa di-mock. DI adalah tanda arsitektur yang mature.

---

### Hari 97 : Offline-First Architecture
* Strategi: cache-first, network-first, stale-while-revalidate
* Conflict resolution saat sync
* Background sync dengan WorkManager
* Local queue untuk operasi offline
* Dart: `Completer` untuk async coordination

**Proyek terkait materi : OfflineMaster**
Buat aplikasi expense tracker yang benar-benar offline-first: semua operasi bisa dilakukan tanpa internet, disimpan ke SQLite dengan status "pending sync". Background WorkManager secara periodik sync ke Firestore saat ada koneksi. Conflict resolution: last-write-wins. Banner yang jelas menunjukkan status sync. Ini adalah level engineering yang diharapkan dari senior developer.

---

### Hari 98 : Flutter Flavors & Multi-Environment
* Konsep dev/staging/production environment
* Setup Flutter flavors untuk Android dan iOS
* Berbeda API URL, Firebase project per environment
* `flutter_flavor` package
* CI/CD yang build per flavor

**Proyek terkait materi : FlavorPro**
Setup 3 flavor untuk ShopNow atau aplikasi besar lain: `dev` (debug, dev server, verbose logging), `staging` (staging server, semi-debug), `production` (production server, no logs, minified). Setiap flavor punya icon berbeda (ada badge "DEV" atau "STG" di corner icon). Ini adalah setup standar di tim engineering profesional.

---

### Hari 99 : Modularization — Feature Module
* Memecah aplikasi besar menjadi module Dart package
* Membuat package lokal dengan `melos`
* Shared module (common, design system, networking)
* Feature module yang independent
* Dependency antar module

**Proyek terkait materi : ModularApp**
Refactor ShopNow menjadi multi-module dengan melos: `packages/design_system/`, `packages/networking/`, `packages/auth_feature/`, `packages/product_feature/`, `packages/cart_feature/`. Setiap module bisa dikembangkan dan di-test secara independen. Ini adalah arsitektur yang dipakai di aplikasi skala besar dengan tim banyak.

---

### Hari 100 : Milestone — Aplikasi Production *(5 hari)*

**Proyek terkait materi : FinTrack** *(Hari 100–104)*
Buat aplikasi keuangan personal yang benar-benar production-ready dan siap publish:

**Hari 100**: Arsitektur (modular + clean arch + BLoC + GetIt), Firebase setup dengan 3 environment, onboarding dengan setup mata uang dan nama.

**Hari 101**: Dashboard: total balance, income vs expense chart, transaksi terbaru. Budget per kategori dengan progress bar.

**Hari 102**: Tambah transaksi (income/expense), kategori custom, foto bukti transaksi (Firebase Storage), recurring transaction.

**Hari 103**: Laporan bulanan dengan chart lengkap, export PDF laporan, filter dan search transaksi, multi-akun (cash, bank, e-wallet).

**Hari 104**: Push notification untuk budget alert, widget rumah (Android home screen widget), release build, publish ke Play Store internal testing, unit test coverage 60%+.

---

### Hari 105 : AR & Machine Learning di Flutter
* Package `ar_flutter_plugin` pengenalan
* Google ML Kit integration: text recognition, face detection
* `tflite_flutter` untuk model ML custom
* On-device ML vs cloud ML — tradeoffs
* Privacy consideration untuk ML features

**Proyek terkait materi : SmartScan**
Buat aplikasi yang memanfaatkan ML Kit: (1) Scan struk/receipt dengan kamera → text recognition → auto-parse jumlah dan toko → auto-fill form pengeluaran di FinTrack. (2) Face detection untuk fun selfie filter sederhana. On-device ML = tanpa internet, lebih cepat, lebih private.

---

### Hari 106 : Bluetooth & IoT
* Package `flutter_blue_plus` untuk Bluetooth LE
* Scan device, connect, disconnect
* Membaca data dari sensor Bluetooth
* Write data ke perangkat Bluetooth
* Handling permission Bluetooth di Android/iOS

**Proyek terkait materi : BLEConnect**
Buat aplikasi yang terhubung ke perangkat Bluetooth LE (bisa simulasi dengan HC-08 module atau ESP32): scan device terdekat, connect, tampilkan data sensor (suhu, kelembaban) secara real-time, dan kirim perintah ke device. Bluetooth + Flutter membuka peluang di IoT dan hardware startup.

---

### Hari 107 : Payment Gateway Integration
* Midtrans (Indonesia) atau Stripe integration
* `midtrans_sdk` atau webview payment
* Webhook handling (via Firebase Functions)
* Payment state machine (pending → success/fail)
* Security: jangan proses payment di client saja

**Proyek terkait materi : PayGate**
Tambahkan payment gateway ke ShopNow menggunakan Midtrans Sandbox. Flow: pilih produk → checkout → pilih metode bayar (transfer bank/e-wallet) → Midtrans snap WebView → konfirmasi → update order status via webhook (Firebase Functions). Payment flow yang aman dan sesuai standar industri.

---

### Hari 108 : Firebase Analytics & Crashlytics
* `firebase_analytics` untuk event tracking
* Custom events dan user properties
* `firebase_crashlytics` untuk crash reporting
* Breadcrumbs dan non-fatal error logging
* A/B testing dengan Firebase Remote Config

**Proyek terkait materi : AnalyticsPro**
Tambahkan analytics dan crash monitoring ke FinTrack atau ShopNow: track semua user action penting (login, tambah item, checkout, error), custom user properties (plan type, total transaction), Crashlytics untuk catch error yang tidak tertangani, Remote Config untuk feature flag (aktifkan/nonaktifkan fitur dari Firebase console tanpa update app). Ini adalah mata dan telinga aplikasi produksi.

---

### Hari 109 : Advanced Testing — Integration Test
* `integration_test` package
* End-to-end test yang jalan di emulator/device nyata
* Simulate user flow lengkap
* Screenshot saat test
* Integration test di CI (Firebase Test Lab)

**Proyek terkait materi : E2ETest**
Tulis integration test untuk flow paling kritis di ShopNow atau FinTrack: (1) Register → login → browse produk → add to cart → checkout. (2) Login → tambah transaksi → cek dashboard update. Test ini jalan di emulator nyata dan tangkap screenshot di setiap step. Upload ke Firebase Test Lab untuk jalan di banyak device nyata.

---

### Hari 110 : Custom Linter & Code Quality
* `flutter_lints` dan `very_good_analysis`
* Membuat custom lint rule dengan `custom_lint`
* Metriks kualitas kode: cyclomatic complexity, code coverage
* `dart fix` untuk auto-fix
* Pre-commit hook dengan `lefthook`

**Proyek terkait materi : CodeQuality**
Setup code quality pipeline untuk semua proyek: custom linting rules yang enforce tim convention, pre-commit hook yang jalankan `dart fix` dan `flutter analyze` sebelum commit, code coverage report yang generated otomatis di CI, dan analisis kode dengan `dart_code_metrics`. Kode yang konsisten = tim yang produktif.

---

### Hari 111–115 : Proyek Besar — Ride Hailing App *(5 hari)*

**Proyek terkait materi : ZipRide**
Buat simulasi aplikasi ride hailing (seperti Gojek/Grab mini):

**Hari 111**: Two apps dalam satu project — rider app dan driver app (gunakan flavors). Auth, onboarding, halaman home dengan peta dan lokasi user.

**Hari 112**: Rider: pilih destinasi, pilih tipe kendaraan, hitung estimasi harga dan waktu (Directions API), order ride.

**Hari 113**: Driver: terima/tolak order, update status real-time (Firestore), tracking posisi driver yang bergerak di peta rider.

**Hari 114**: In-trip screen: peta dengan driver bergerak, estimasi tiba, hubungi driver (deep link ke phone), cancel order.

**Hari 115**: Rating setelah trip, riwayat perjalanan, sistem pembayaran (cash/wallet), push notification untuk setiap update status.

---

### Hari 116 : State Restoration
* Menyimpan dan restore UI state saat app di-kill
* `RestorationMixin` dan `RestorableProperty`
* Form restoration
* Scroll position restoration
* Testing state restoration

**Proyek terkait materi : RestoreApp**
Implementasikan state restoration di FinTrack: jika app di-kill oleh OS saat user sedang di form tambah transaksi, saat dibuka lagi form sudah terisi kembali. Scroll position di halaman riwayat juga diingat. Ini adalah detail kecil yang membuat pengguna merasa aplikasi "pintar" dan tidak menjengkelkan.

---

### Hari 117 : Deferred Loading & App Size Optimization
* Konsep deferred loading untuk Flutter Web
* `loadLibrary()` untuk lazy load module
* Optimasi ukuran APK: `--split-per-abi`
* ProGuard/R8 untuk obfuscation
* Tree shaking dan mengurangi dependency tidak perlu

**Proyek terkait materi : SlimApp**
Audit ukuran APK ShopNow atau FinTrack: pakai `flutter build apk --analyze-size`, identifikasi library yang paling besar, cari alternatif yang lebih ringan, aktifkan split-per-ABI, minify dan obfuscate. Target: kurangi ukuran APK minimal 30%. Ukuran APK kecil = lebih banyak yang install.

---

### Hari 118 : Shader & GPU Effects
* `FragmentShader` di Flutter
* Menulis GLSL shader sederhana
* Efek: blur custom, distortion, color grading
* `ImageFilter` dan `BackdropFilter`
* Performa shader — kapan worth it

**Proyek terkait materi : GlassMorphism**
Buat UI dengan efek glassmorphism yang nyata menggunakan `BackdropFilter` dan custom shader: navigation bar frosted glass, card dengan blur effect, dan efek ripple custom. Buat showcase halaman settings yang menggunakan semua efek ini. GPU-accelerated effects yang membuat UI terlihat premium.

---

### Hari 119 : Open Source — Contribute & Publish Package
* Membuat Flutter package yang publishable
* `pubspec.yaml` yang benar untuk package
* Menulis dokumentasi dengan dartdoc
* Publish ke pub.dev
* Semantic versioning dan changelog

**Proyek terkait materi : MyPackage**
Extract salah satu widget atau utility yang kamu buat (misal: rating widget, bottom sheet custom, atau date picker) menjadi Flutter package yang bisa dipublish. Tulis README yang baik, contoh penggunaan, dan API documentation. Publish ke pub.dev. Package di pub.dev = contribution nyata ke komunitas Flutter.

---

### Hari 120 : Review Fase 4 & Portofolio
* Review semua proyek dari hari 1–120
* Buat portofolio website (pakai WebPortfolio)
* Tulis blog post tentang satu pengalaman teknis
* GitHub profile yang menarik
* Persiapan technical interview

**Proyek terkait materi : Portfolio120**
Susun portofolio: (1) GitHub profile README yang menarik dengan skill, proyek unggulan, dan stats. (2) Update WebPortfolio dengan semua proyek yang sudah dibuat beserta screenshot dan link. (3) Tulis 1 artikel teknis di Medium/blog pribadi tentang sesuatu yang kamu pelajari (misal: "BLoC vs Riverpod — Panduan Memilih untuk Proyek Flutter"). Portofolio yang kuat = peluang karir yang lebih baik.

---

*© Kurikulum Flutter 300 Hari | Part 2: Hari 61–120*
