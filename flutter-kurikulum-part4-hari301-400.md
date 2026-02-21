# 🔥 Flutter Kurikulum — Part 4: Hari 301–400
### Level: Upper Intermediate → Advanced
> Fokus: Mastery-level teknik, kompleks project, dan professional readiness

---

## 🗓️ FASE 11 — Expert-Level Flutter (Hari 301–340)
> Tujuan: Kuasai aspek paling dalam dari Flutter yang jarang orang pelajari

---

### Hari 301–304 : Custom RenderObject

**Hari 301:**
* Kapan kamu butuh RenderObject sendiri (bukan hanya CustomPainter)
* `RenderBox` vs `RenderSliver`
* Lifecycle: `createRenderObject`, `updateRenderObject`

**Hari 302:**
* Implementasi layout di RenderObject: `performLayout`
* Implementasi paint di RenderObject: `paint`
* Hit testing: `hitTestSelf`, `hitTestChildren`

**Hari 303:**
* `MultiChildRenderObjectWidget` — widget dengan banyak anak
* `ContainerRenderObjectMixin`
* Contoh: custom layout algorithm

**Hari 304:**
* Perbandingan performa: RenderObject vs CustomPainter vs Widget biasa
* Kapan investasi ini worth it

**Project terkait (4 hari) : `custom_chart_renderobject`**
- Buat custom chart widget (radar/spider chart) dari nol menggunakan RenderObject
- Bukan dengan CustomPainter — gunakan RenderBox langsung
- Chart bisa: animasi, di-tap untuk highlight nilai, resize dinamis
- Publish sebagai package ke pub.dev
- Tujuan: Pemahaman mendalam tentang Flutter rendering engine

---

### Hari 305–307 : Impeller & Skia

**Hari 305:**
* Apa itu Skia vs Impeller rendering engine
* Kenapa Flutter pindah ke Impeller
* Cara enable/disable Impeller untuk testing

**Hari 306:**
* Perbedaan performa nyata Skia vs Impeller
* Fitur yang bermasalah di Impeller dan workaround-nya
* Shader warm-up: masalah Skia yang diatasi Impeller

**Hari 307:**
* Kontribusi ke Flutter engine (pengantar)
* Cara setup Flutter engine untuk development
* Membaca Flutter engine source code

**Project terkait (3 hari) : `impeller_benchmark`**
- Buat app benchmark yang menguji aspek rendering yang berbeda
- Test: kompleks CustomPainter, animasi banyak widget, gradients besar
- Ukur FPS dengan Skia dan Impeller
- Dokumentasikan temuan dalam blog post (tulis di Medium atau dev.to)

---

### Hari 308–311 : Advanced Testing Strategies

**Hari 308:**
* Property-based testing dengan `dart_test`
* Generate ribuan test case secara otomatis
* Menemukan edge case yang tidak terpikirkan

**Hari 309:**
* Mutation testing — apakah test-mu cukup kuat?
* Contract testing antara frontend dan backend

**Hari 310:**
* Visual regression testing: golden file strategy
* Setup golden test di CI
* Mengelola golden file update yang disengaja

**Hari 311:**
* Test pyramid di Flutter: berapa rasio unit/widget/integration test yang ideal?
* Flaky test: penyebab dan solusinya
* Parallelisasi test untuk speed

**Project terkait (4 hari) : `test_suite_production_grade`**
- Ambil project Habito
- Unit test: 80%+ coverage untuk business logic
- Widget test: semua screen dengan golden test
- Integration test: happy path dan unhappy path utama
- Setup di GitHub Actions: test harus lulus sebelum merge ke main
- Tujuan: Confidence untuk deploy tanpa takut

---

### Hari 312–315 : Flutter dengan AI & ML

**Hari 312:**
* TensorFlow Lite di Flutter: package `tflite_flutter`
* Load model .tflite dan buat inferensi
* Pre-processing input data

**Hari 313:**
* Image classification on-device
* Object detection dengan camera real-time
* Performa on-device vs cloud inference

**Hari 314:**
* Google ML Kit: text recognition, face detection, barcode scanning
* Pose detection untuk fitness app
* Language detection

**Hari 315:**
* Integrasi LLM API (OpenAI/Claude API) ke Flutter app
* Streaming response untuk chat UX yang smooth
* Rate limiting dan error handling LLM API

**Project terkait (4 hari) : `app_kamera_pintar`**
- App kamera dengan AI layer real-time
- Fitur 1: Scan teks dari foto (ML Kit OCR) → copy ke clipboard
- Fitur 2: Identifikasi objek dalam frame kamera (TFLite object detection)
- Fitur 3: Analisis tanaman (foto tanaman → nama + info via LLM API)
- UI: overlay bounding box di atas camera preview secara real-time

---

### Hari 316–319 : Augmented Reality (AR) di Flutter

**Hari 316:**
* Apa itu AR dan toolkit yang tersedia untuk Flutter
* ARCore (Android) dan ARKit (iOS)
* Package `ar_flutter_plugin`

**Hari 317:**
* Plane detection — detect permukaan datar
* Anchor points — menempatkan objek di dunia nyata
* 3D model rendering dengan sceneview

**Hari 318:**
* Interaksi dengan objek AR: tap, scale, rotate
* Lighting estimation untuk render yang realistis

**Hari 319:**
* Limitasi AR di Flutter vs native
* Use case nyata: furniture preview, wayfinding, education

**Project terkait (4 hari) : `app_ar_furniture`**
- App preview furnitur AR
- Scan permukaan lantai → pilih furnitur dari catalog
- Tempatkan furnitur 3D di lantai seolah-olah nyata
- Bisa: pindah, rotate, scale furnitur
- Screenshot dan share hasilnya
- Terinspirasi dari fitur IKEA Place app

---

### Hari 320–323 : Flutter + IoT & Hardware

**Hari 320:**
* Komunikasi Flutter dengan hardware: BLE, WiFi, USB
* `flutter_blue_plus` untuk BLE communication
* Scan, connect, read, write karakteristik BLE

**Hari 321:**
* MQTT protocol untuk IoT dengan `mqtt_client`
* Subscribe ke topik sensor
* Publish perintah ke device

**Hari 322:**
* Komunikasi dengan Arduino via serial USB (mobile)
* Parsing binary protocol data

**Hari 323:**
* WebSocket untuk lokal IoT (ESP8266/ESP32 + WebSocket server)

**Project terkait (4 hari) : `app_smart_home_controller`**
- Simulasi smart home controller (bisa gunakan simulator MQTT atau ESP32 nyata)
- Dashboard: 4 kartu — Lampu, AC, Kipas, Keamanan
- Toggle on/off, slider brightness/temperature
- Real-time update via MQTT/WebSocket
- Grafik historis penggunaan (suhu 24 jam, dll)

---

### Hari 324–327 : Game Development dengan Flutter (Flame)

**Hari 324:**
* Apa itu Flame game engine untuk Flutter
* `FlameGame`, `Component`, `GameWidget`
* Game loop: `update()` dan `render()`

**Hari 325:**
* Sprite dan SpriteAnimation
* Collision detection
* Kamera dan parallax background

**Hari 326:**
* Flame audio, game state, overlay UI
* Tiled map integration
* Particle system di Flame

**Hari 327:**
* Optimasi game: object pooling, frustum culling
* Physics dengan Forge2D (port Box2D)

**Project terkait (4 hari) : `game_platform_runner`**
- Buat endless runner game sederhana
- Karakter berlari otomatis, tap untuk lompat
- Obstacle datang dari kanan, collision detection
- Skor, high score tersimpan lokal
- Soundtrack dan sound effect
- Parallax background 3 layer untuk kedalaman

---

### Hari 328–332 : Micro-Frontend Architecture di Flutter

**Hari 328:**
* Konsep micro-frontend: app sebagai kumpulan modul independen
* Module Federation di Flutter
* Dart packages sebagai micro-modules

**Hari 329:**
* Dynamic module loading
* Shared dependencies antar modul

**Hari 330:**
* Communication antar modul tanpa direct dependency
* Event bus pattern

**Hari 331:**
* Versioning antar modul
* Deploying modul secara independen

**Hari 332:**
* Kapan micro-frontend cocok vs terlalu kompleks

**Project terkait (5 hari) : `super_app_architecture`**
- Buat "super app" yang terdiri dari 3 sub-app independen:
  - Modul Keuangan: tracking pengeluaran
  - Modul Kesehatan: habit tracker
  - Modul Produktivitas: todo dan catatan
- Masing-masing adalah Dart package independen
- Main app sebagai shell yang load modul
- Navigasi, theme, dan auth dibagikan via shared package

---

### Hari 333–336 : Flutter di TV & Wearable

**Hari 333:**
* Flutter di Android TV — perbedaan dengan mobile
* Focus management: navigasi dengan remote
* `FocusNode` dan `FocusTraversalGroup`

**Hari 334:**
* D-pad navigation yang intuitif
* UI yang dibaca dari jarak jauh (font besar, kontras tinggi)
* `onKey` untuk handle tombol remote

**Hari 335:**
* Flutter di WearOS (Android Watch)
* Ukuran layar sangat kecil: konten ultra-minimal
* `AmbientMode` untuk jam tangan

**Hari 336:**
* Flutter di embedded Linux (Raspberry Pi)
* Kiosk mode: satu app, layar penuh

**Project terkait (4 hari) : `app_tv_remote`**
- Buat media player UI untuk Android TV
- Navigasi penuh menggunakan tombol remote (D-pad)
- Home: grid konten yang bisa dinavigasi
- Detail konten: informasi besar, tombol "Putar"
- Fokus state yang jelas (highlighted saat dipilih)

---

### Hari 337–340 : DevOps & Advanced CI/CD

**Hari 337:**
* Fastlane untuk automasi release: Android dan iOS
* Screenshot automation dengan Fastlane
* Code signing automation

**Hari 338:**
* GitHub Actions advanced: matrix build (build untuk Android + iOS sekaligus)
* Artifact caching untuk speed up build
* Secret management

**Hari 339:**
* Codemagic atau Bitrise untuk mobile CI/CD
* Auto-increment build number
* Deploy ke beta testers (Firebase App Distribution / TestFlight) secara otomatis setiap merge

**Hari 340:**
* Rollout strategy: percentage-based rollout di Play Store
* Feature flags untuk rollout bertahap
* Rollback plan jika ada bug kritis

**Project terkait (4 hari) : `pipeline_release_otomatis`**
- Setup pipeline lengkap untuk Habito app:
  - Setiap push ke `develop`: build + test otomatis
  - Setiap push ke `main`: build + test + deploy ke Firebase App Distribution (beta tester)
  - Tag versi (v1.0.0): build + deploy ke Play Store Internal Track
- Fastlane untuk manage semua proses release
- Tujuan: Release cycle professional seperti di startup

---

## 🗓️ FASE 12 — Enterprise & Team Development (Hari 341–380)
> Tujuan: Siap bekerja di tim besar dengan standar enterprise

---

### Hari 341–345 : Monorepo Setup

**Hari 341:** Apa itu monorepo dan kenapa beberapa perusahaan memakainya
**Hari 342:** Melos — tool untuk Flutter monorepo
**Hari 343:** Shared packages, app packages, versioning bersama
**Hari 344:** Workspace commands: `melos bootstrap`, `melos run`, `melos publish`
**Hari 345:** CI/CD dengan monorepo: hanya build package yang berubah

**Project terkait (5 hari) : `monorepo_super_app`**
- Konversi super app (Hari 332) ke monorepo dengan Melos
- Struktur: `packages/` (shared), `apps/` (multi apps)
- Setiap package punya test suite sendiri
- CI hanya test package yang file-nya berubah (affected detection)

---

### Hari 346–350 : Code Quality & Governance

**Hari 346:** Static analysis lanjut: custom lint rules dengan `custom_lint`
**Hari 347:** Architecture lint: pastikan dependency tidak melanggar layer boundary
**Hari 348:** Automated code review dengan Danger
**Hari 349:** Documentation generation dengan `dartdoc` yang komprehensif
**Hari 350:** Code owner: CODEOWNERS file di GitHub

**Project terkait (5 hari) : `governance_toolkit`**
- Setup custom lint rules: "Jangan import langsung dari `data` layer di `presentation`"
- Danger: PR tanpa test → fail dengan pesan yang membantu
- dartdoc: generate situs dokumentasi API yang lengkap
- CODEOWNERS: setiap direktori punya pemilik yang harus approve PR

---

### Hari 351–356 : Internationalization Enterprise Grade

**Hari 351:** ARB workflow yang benar: source ARB, generate, translate
**Hari 352:** Pluralization, ordinals, gender-based translation
**Hari 353:** RTL (Right-to-Left) language support (Arabic, Hebrew)
**Hari 354:** Locale-specific date, time, number, currency format
**Hari 355:** Working dengan translation management system (Crowdin, Lokalise)
**Hari 356:** Pseudo-localization untuk testing layout

**Project terkait (6 hari) : `app_global_ready`**
- Ambil salah satu app, siapkan untuk 5 bahasa: ID, EN, AR, JA, DE
- Arab (RTL): semua layout harus terbalik secara otomatis
- Jepang: karakter yang lebih lebar, perlu adjustasi layout
- Currency dan date format berbeda di setiap locale
- Pseudo-locale testing: verifikasi tidak ada teks yang terpotong

---

### Hari 357–362 : Large Team Workflow

**Hari 357:** Git branching strategy: Gitflow vs Trunk-based development
**Hari 358:** Feature branch workflow: branch → PR → review → merge
**Hari 359:** Semantic commits: `feat:`, `fix:`, `chore:`, dll
**Hari 360:** Changelog otomatis dari commit messages
**Hari 361:** PR template dan issue template di GitHub
**Hari 362:** Pair programming dan mob programming sebagai praktik

**Project terkait (6 hari) : `simulasi_kolaborasi`**
- Setup repositori GitHub dengan branch protection rules
- Buat PR template yang memaksa penjelasan: "Apa yang berubah? Bagaimana testing-nya?"
- Buat beberapa branch fitur secara bersamaan, resolve merge conflict
- Buat CHANGELOG.md otomatis menggunakan `conventional-changelog`
- Tujuan: Simulasi workflow tim yang nyata

---

### Hari 363–368 : Platform-Specific Advanced

**Hari 363:** Android: Custom Gradle build script, ProGuard rules lanjut
**Hari 364:** Android: Adaptive icons, in-app updates API
**Hari 365:** iOS: App Extension (Share Extension, Widget Extension)
**Hari 366:** iOS: Xcode build configuration, multiple schemes
**Hari 367:** Platform views: embed native Android View/iOS UIView dalam Flutter
**Hari 368:** MethodChannel lanjut: binary messenger, streaming channel

**Project terkait (6 hari) : `platform_native_integration`**
- iOS: tambahkan Widget Extension (home screen widget) ke app Habito — tampilkan streak hari ini
- Android: tambahkan App Widget ke home screen Android
- iOS: Share Extension — user bisa share URL ke app dari browser
- Tujuan: Fitur yang benar-benar native dan terasa bagian dari OS

---

### Hari 369–374 : Security Hardening

**Hari 369:** OWASP Mobile Top 10 — celah keamanan paling umum
**Hari 370:** Root/Jailbreak detection dan enforcement
**Hari 371:** SSL Pinning implementation yang robust
**Hari 372:** Code obfuscation dengan Dart obfuscation flags
**Hari 373:** Runtime application self-protection (RASP)
**Hari 374:** Security audit checklist sebelum release

**Project terkait (6 hari) : `security_hardened_app`**
- Lakukan security audit lengkap terhadap app terbesar
- Implement: SSL pinning, root detection, obfuscation
- Test dengan proxy tool (Charles/mitmproxy) — apakah SSL pinning berhasil?
- Buat dokumen "Security Report": apa yang ditemukan, apa yang diperbaiki
- Tujuan: App yang layak menyimpan data sensitif user

---

### Hari 375–380 : Architecture Review & Technical Leadership

**Hari 375:** Membuat Architecture Decision Record (ADR) yang komprehensif
**Hari 376:** Mengevaluasi dan memilih library: criteria, trade-off, migration cost
**Hari 377:** Tech debt registry: mencatat, memprioritaskan, dan mengelola hutang teknis
**Hari 378:** Mentoring: cara mengajarkan Flutter ke developer junior
**Hari 379:** Technical presentation: demo dan explain arsitektur ke stakeholder non-teknis
**Hari 380:** Engineering blog: menulis tentang solusi teknis yang ditemukan

**Project terkait (6 hari) : `tech_lead_artifacts`**
- Buat ADR untuk 5 keputusan arsitektur terpenting di proyekmu
- Buat slide presentasi arsitektur (bisa pakai Flutter Web untuk presentasi!)
- Tulis blog post di Medium: "Bagaimana kami membangun [nama app] dengan Flutter"
- Buat panduan onboarding untuk developer baru masuk ke proyekmu
- Tujuan: Kemampuan komunikasi teknis yang setara dengan coding skill

---

## 🗓️ FASE 13 — Portfolio & Career (Hari 381–400)
> Tujuan: Siap masuk industri sebagai Flutter Developer

---

### Hari 381–390 : 🏆 Project Final — "Wander" (App Travel Journal)

**Konsep:**
App jurnal perjalanan yang berbeda dari yang biasa. Bukan sekedar foto dan catatan — tapi pengalaman visual yang imersif. Setiap perjalanan terasa seperti sebuah "karya" yang layak dipamerkan.

**Fitur:**
- 🗺️ Peta interaktif yang menandai semua tempat yang pernah dikunjungi
- 📸 Jurnal per perjalanan: timeline foto + cerita + mood
- 🌤️ Auto-embed cuaca saat foto diambil (berdasarkan metadata lokasi + tanggal)
- 🎞️ Auto-generate "travel reel": slideshow animasi dari foto-foto perjalanan
- 🔒 Konten private by default, bisa di-share selektif
- 📊 Statistik: berapa negara/kota dikunjungi, total kilometer perjalanan
- 🧳 Packing list per perjalanan dengan smart suggestion berdasarkan destinasi + cuaca
- 💾 Backup otomatis ke Google Drive / iCloud

**Stack:**
- Auth: Firebase Auth
- DB: Firestore + Hive (offline)
- Storage: Firebase Storage
- Maps: Google Maps Flutter
- State: Riverpod
- Architecture: Clean Architecture + DDD
- CI/CD: GitHub Actions + Fastlane

**Timeline (10 hari):**
- Hari 381–382: Setup + arsitektur + design system
- Hari 383–384: Auth + profil user
- Hari 385–386: Fitur tambah & lihat perjalanan + peta
- Hari 387–388: Jurnal foto + cerita + mood timeline
- Hari 389: Travel stats + packing list
- Hari 390: Polish, testing, bug fix

---

### Hari 391–395 : Portfolio Polish

**Hari 391:**
* Update GitHub profile: README, pinned repositori
* Setiap repositori punya README yang menarik + screenshot/GIF

**Hari 392:**
* Buat website portfolio menggunakan Flutter Web (dari Hari 212) — update dengan semua project terbaru

**Hari 393:**
* LinkedIn: update skill, tambahkan proyek sebagai portfolio items
* Tulis artikel "500 Hari Belajar Flutter" — perjalananmu

**Hari 394:**
* Rekam video demo untuk 3 project terbaik (2–3 menit)
* Upload ke YouTube sebagai tambahan portofolio

**Hari 395:**
* GitHub contribution graph: pastikan terlihat aktif
* Star dan fork repositori terkait Flutter untuk visibility

---

### Hari 396–398 : Interview Preparation

**Hari 396:**
* Pertanyaan interview Flutter yang paling sering: State management, lifecycle, widget types
* Buat cheat sheet: 50 pertanyaan + jawaban ringkas
* Latihan menjawab tanpa melihat catatan

**Hari 397:**
* Technical coding test Flutter: biasanya buat app sederhana dalam 2–4 jam
* Latihan: buat app fetch dan tampilkan data dari API publik dalam 1 jam
* Fokus: clean code, error handling, UI rapi

**Hari 398:**
* Soft skills interview: ceritakan tentang proyek, tantangan, solusi
* STAR method untuk behavioral questions
* Pertanyaan balik ke interviewer yang cerdas

---

### Hari 399–400 : Refleksi & Langkah Selanjutnya

**Hari 399:**
* Review semua yang telah dipelajari dari Hari 1
* Identifikasi area yang masih perlu diperdalam
* Buat learning plan untuk 100 hari ke depan

**Hari 400:**
* 🎉 Rayakan pencapaian 400 hari!
* Update "Surat untuk Diri Sendiri" — bandingkan dengan yang ditulis di Hari 1
* Bagikan perjalananmu ke komunitas — kamu sudah jadi Flutter Developer!

---

> **✅ End of Part 4 — Hari 301-400**
> Lanjut ke Part 5 untuk Hari 401-500 (Expert/Mastery Level)
