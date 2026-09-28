Buatkan panduan dan file lengkap proyek Flutter untuk web di bawah ini,
Judul :

UI/UX standart profesional, designer grade.
Terapkan modular programming, dan setiap file di tulis di masing-masing artifact agar mudah di copy.
mulai dari inisialisasi proyek
sertakan code bash touch mkdir untuk membuat struktur file lengkap semua file termasuk di root.
tidak usah pakai demo tampilan, tidak usah pakai README.MD,
code dalam artifact lengkap dengan penjelasan detail dan lengkap setiap code dalam bentuk komentar, penjelasan level pemula minimal 10 kata setiap barisnya, jangan di ringkas, kecuali code yang pengulangan sudah dibahas sebelumnya

buat code dalam 5-15 tahap dengan tahapan seperti professional atau real developer akan mengembangkan app ini, jelaskan alurnya, apa dulu yang dibuat kemudian selanjutnya bagian mana hingga akhir finalisasinya, buat setiap part terpisah hingga bisa langsung dilihat hasilnya, kemudian ketika masuk part berikutnya, code yang sebelumnya di edit agar sesuai
Artifact hanya digunakan untuk coding aplikasi saja. Panduan atau pembahasan, setup dan lain lain di dalam chat saja

mulai dari part 1 terlebih dahulu

# 30 Ide Aplikasi Flutter Level Intermediate

Daftar ini berisi 30 ide aplikasi Flutter (target 1000–3000 baris kode) untuk latihan. Setiap app sengaja dirancang dengan fitur, teknologi, dan tema UI yang berbeda-beda agar mencakup berbagai paradigma dan teknik pengembangan.

---

| #   | Nama App        | Deskripsi                                                         | Teknologi                                                         | Tema UI               |
| --- | --------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | --------------------- |
| 1   | **Habitloom**   | Pelacak kebiasaan harian dengan grafik progres dan streak counter | Provider, sqflite, fl_chart, shared_preferences                   | Zen garden            |
| 2   | **Pulsewave**   | Pemutar musik lokal dengan visualizer audio real-time             | just_audio, audio_waveforms, get_it, path_provider                | Neon synthwave        |
| 3   | **Driftnote**   | Aplikasi catatan dengan sinkronisasi offline-first ke cloud       | Riverpod, hive, connectivity_plus, workmanager                    | Minimalist paper      |
| 4   | **Kaldera**     | Simulasi cuaca & kualitas udara dengan animasi partikel           | Bloc, http, lottie, geolocator                                    | Volcanic/nebula       |
| 5   | **Wanderlist**  | Bucket list perjalanan dengan peta interaktif & checklist         | flutter_map, latlong2, provider, image_picker                     | Vintage explorer      |
| 6   | **Coinfolio**   | Tracker portofolio kripto dengan grafik harga live                | GetX, web_socket_channel, syncfusion_flutter_charts               | Futuristic dark glass |
| 7   | **Brewtime**    | Timer multi-tahap untuk seduh kopi manual dengan preset           | flutter_bloc, vibration, audioplayers, hive                       | Warm café rustic      |
| 8   | **Skyledger**   | Jurnal mood harian dengan analisis pola mingguan                  | Provider, table_calendar, fl_chart, sqflite                       | Pastel skyline        |
| 9   | **Formflow**    | Form builder dinamis dengan validasi kondisional                  | flutter_form_builder, reactive_forms, dio                         | Corporate clean       |
| 10  | **Ripplechat**  | Chat real-time sederhana dengan status online/typing indicator    | firebase_core, cloud_firestore, firebase_auth, provider           | Aquatic gradient      |
| 11  | **Cartwheel**   | Aplikasi belanja dengan cart, wishlist, dan filter kategori       | Riverpod, cached_network_image, badges, hive                      | Playful pop-art       |
| 12  | **Nightowl**    | Reading tracker dengan target halaman & reminder pengingat        | Bloc, flutter_local_notifications, sqflite, share_plus            | Dark academia         |
| 13  | **Terrahike**   | Pelacak hiking dengan GPS trail recording & elevasi               | geolocator, flutter_map, fl_chart, permission_handler             | Topographic outdoor   |
| 14  | **Vaultkeep**   | Password manager lokal dengan enkripsi AES                        | encrypt, flutter_secure_storage, local_auth, provider             | Cybersecurity dark    |
| 15  | **Snaplang**    | Flashcard bahasa dengan spaced repetition algorithm               | GetX, sqflite, animations, confetti                               | Playground pastel     |
| 16  | **Fizzbudget**  | Manajemen keuangan personal dengan kategori & grafik pie          | Provider, fl_chart, intl, sqflite                                 | Fintech soft green    |
| 17  | **Cloudcanvas** | Aplikasi gambar sederhana dengan layer & undo-redo                | CustomPainter, provider, image, path_provider                     | Artistic sketchbook   |
| 18  | **Moondeck**    | Aplikasi pelacak siklus tidur dengan alarm cerdas                 | flutter_bloc, flutter_local_notifications, fl_chart, sensors_plus | Midnight lunar        |
| 19  | **Pinboard**    | Aplikasi bookmark link dengan preview metadata otomatis           | any_link_preview, hive, share_plus, url_launcher                  | Retro corkboard       |
| 20  | **Rushcart**    | Aplikasi grocery list kolaboratif real-time multi-user            | firebase_database, provider, flutter_slidable                     | Fresh grocery pastel  |
| 21  | **Echoverse**   | Text-to-speech reader untuk artikel & PDF                         | flutter_tts, syncfusion_flutter_pdfviewer, provider               | Ambient soundwave     |
| 22  | **Glasspot**    | Pelacak konsumsi air harian dengan animasi gelas mengisi          | Riverpod, flutter_local_notifications, shared_preferences         | Aqua glassmorphism    |
| 23  | **Threadline**  | Aplikasi to-do dengan sub-task, drag-drop reorder, tag            | Bloc, reorderable_grid_view, hive, flutter_slidable               | Modern kanban         |
| 24  | **Petalpath**   | Aplikasi identifikasi tanaman dengan galeri koleksi               | image_picker, tflite_flutter, hive, cached_network_image          | Botanical soft        |
| 25  | **Ledgerbite**  | Split bill & pembagian tagihan grup dengan riwayat transaksi      | Provider, sqflite, pdf, printing                                  | Modern fintech        |
| 26  | **Wispertimer** | Pomodoro timer dengan white noise & statistik fokus               | flutter_bloc, audioplayers, fl_chart, wakelock_plus               | Calm forest ambient   |
| 27  | **Trailmix**    | Aplikasi playlist kolaboratif dengan voting lagu                  | GetX, cloud_firestore, firebase_auth, just_audio                  | Festival neon         |
| 28  | **Quillspace**  | Blog writer offline dengan markdown preview live                  | flutter_markdown, hive, share_plus, file_picker                   | Editorial monochrome  |
| 29  | **Kindred**     | Manajemen kontak keluarga besar dengan pohon relasi visual        | CustomPainter, sqflite, contacts_service, provider                | Warm family sepia     |
| 30  | **Ohmwatch**    | Monitor pemakaian listrik rumah dengan estimasi biaya             | Riverpod, fl_chart, sqflite, flutter_local_notifications          | Industrial tech-blue  |

---

## Catatan Desain Kurikulum

- **State management bervariasi**: Provider, Riverpod, Bloc/flutter_bloc, dan GetX dipakai bergantian agar terlatih di semua paradigma populer.
- **Storage bervariasi**: sqflite (relasional), hive (NoSQL lokal), Firebase (cloud real-time), shared_preferences/flutter_secure_storage (key-value & terenkripsi).
- **Hardware & sensor**: beberapa app memakai geolocator, sensors_plus, local_auth untuk latihan integrasi perangkat.
- **UI & animasi murni**: beberapa app fokus ke CustomPainter, lottie, confetti, animations untuk latihan custom rendering dan micro-interaction.
- **Real-time & kolaboratif**: beberapa app memakai Firebase/web_socket_channel untuk latihan sinkronisasi multi-user.
