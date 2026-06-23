import '../models/ocean_trait.dart';
import '../utils/score_interpreter.dart';

/// Struktur data untuk satu set insights kepribadian lengkap.
class PersonalityInsights {
 const PersonalityInsights({
 required this.strengths,
 required this.weaknesses,
 required this.careerPaths,
 required this.selfImprovementTips,
 required this.learningTips,
 });

 final List<String> strengths;
 final List<String> weaknesses;
 final List<String> careerPaths;
 final List<String> selfImprovementTips;
 final List<String> learningTips;
}

/// Menghasilkan [PersonalityInsights] berdasarkan kombinasi skor kelima
/// trait OCEAN. Pendekatan berbasis kombinasi (bukan per-trait sendiri)
/// menghasilkan narasi yang lebih kontekstual dan realistis.
class PersonalityInsightsEngine {
 PersonalityInsightsEngine._();

 static PersonalityInsights generate(Map<OceanTrait, double> scores) {
 final o = ScoreInterpreter.levelOf(scores[OceanTrait.openness]!);
 final c = ScoreInterpreter.levelOf(scores[OceanTrait.conscientiousness]!);
 final e = ScoreInterpreter.levelOf(scores[OceanTrait.extraversion]!);
 final a = ScoreInterpreter.levelOf(scores[OceanTrait.agreeableness]!);
 final n = ScoreInterpreter.levelOf(scores[OceanTrait.neuroticism]!);

 return PersonalityInsights(
 strengths: _strengths(o, c, e, a, n),
 weaknesses: _weaknesses(o, c, e, a, n),
 careerPaths: _careerPaths(o, c, e, a, n),
 selfImprovementTips: _selfImprovementTips(o, c, e, a, n),
 learningTips: _learningTips(o, c, e, a, n),
 );
 }

 // 
 // KEUNGGULAN
 // 
 static List<String> _strengths(
 ScoreLevel o,
 ScoreLevel c,
 ScoreLevel e,
 ScoreLevel a,
 ScoreLevel n,
 ) {
 final List<String> result = [];

 // Openness
 if (o == ScoreLevel.high) {
 result.add('Kreatif dan imajinatif — mudah menghasilkan ide-ide segar yang belum terpikirkan orang lain.');
 result.add('Adaptif terhadap perubahan dan situasi baru yang tidak terduga.');
 } else if (o == ScoreLevel.moderate) {
 result.add('Mampu menyeimbangkan kreativitas dengan kepraktisan dalam menyelesaikan masalah.');
 } else {
 result.add('Konsisten dan dapat diandalkan karena menyukai pendekatan yang sudah terbukti berhasil.');
 result.add('Fokus pada hal-hal konkret dan realistis tanpa terdistraksi ide abstrak.');
 }

 // Conscientiousness
 if (c == ScoreLevel.high) {
 result.add('Sangat terorganisir, disiplin, dan selalu menyelesaikan apa yang sudah dimulai.');
 result.add('Dapat dipercaya untuk mengelola tanggung jawab besar tanpa perlu diawasi.');
 } else if (c == ScoreLevel.moderate) {
 result.add('Cukup bertanggung jawab sambil tetap fleksibel ketika situasi berubah mendadak.');
 } else {
 result.add('Spontan dan fleksibel — tidak kaku pada rencana sehingga mudah beradaptasi.');
 }

 // Extraversion
 if (e == ScoreLevel.high) {
 result.add('Karismatik dan mudah membangun relasi baru dengan cepat di lingkungan apapun.');
 result.add('Energik dan antusias — mampu memotivasi dan mengangkat semangat orang sekitar.');
 } else if (e == ScoreLevel.moderate) {
 result.add('Mampu bersosialisasi dengan baik sekaligus menikmati waktu refleksi sendiri.');
 } else {
 result.add('Pendengar yang baik — lebih banyak menyerap dan memproses sebelum berbicara.');
 result.add('Kemampuan berpikir mendalam dan konsentrasi tinggi dalam pekerjaan solo.');
 }

 // Agreeableness
 if (a == ScoreLevel.high) {
 result.add('Empatik dan pandai membaca perasaan orang lain sehingga mudah dipercaya.');
 result.add('Natural mediator — mampu meredakan konflik dan menciptakan harmoni dalam tim.');
 } else if (a == ScoreLevel.moderate) {
 result.add('Mampu bersikap kooperatif sekaligus tegas saat situasi mengharuskannya.');
 } else {
 result.add('Tegas dan berani menyampaikan pendapat tanpa khawatir tidak disukai.');
 result.add('Berorientasi pada hasil — tidak mudah terpengaruh tekanan sosial dalam mengambil keputusan.');
 }

 // Neuroticism
 if (n == ScoreLevel.low) {
 result.add('Tenang dan stabil di bawah tekanan — menjadi pilar ketenangan bagi orang-orang sekitar.');
 result.add('Mudah pulih dari kegagalan dan tidak berlama-lama dalam kondisi negatif.');
 } else if (n == ScoreLevel.moderate) {
 result.add('Kepekaan emosi yang cukup membuat Anda lebih peka terhadap situasi yang perlu diwaspadai.');
 } else {
 result.add('Sangat peka terhadap detail dan potensi risiko — berguna untuk pekerjaan yang membutuhkan kewaspadaan tinggi.');
 }

 return result;
 }

 // 
 // KELEMAHAN
 // 
 static List<String> _weaknesses(
 ScoreLevel o,
 ScoreLevel c,
 ScoreLevel e,
 ScoreLevel a,
 ScoreLevel n,
 ) {
 final List<String> result = [];

 if (o == ScoreLevel.high) {
 result.add('Cenderung mudah bosan dengan rutinitas dan bisa kehilangan fokus saat pekerjaan terasa monoton.');
 result.add('Terkadang terlalu asyik mengeksplorasi ide baru sampai melupakan yang sudah dimulai.');
 } else if (o == ScoreLevel.moderate) {
 result.add('Terkadang ragu antara mencoba hal baru atau tetap pada cara yang sudah dikenal.');
 } else {
 result.add('Bisa kesulitan menyesuaikan diri ketika lingkungan atau metode kerja berubah secara drastis.');
 result.add('Kurang terbuka terhadap sudut pandang yang sangat berbeda dari kebiasaan sendiri.');
 }

 if (c == ScoreLevel.high) {
 result.add('Perfeksionisme yang berlebihan bisa memperlambat penyelesaian tugas atau menyulitkan delegasi.');
 result.add('Cenderung kaku pada rencana dan sulit menerima perubahan mendadak dengan lapang dada.');
 } else if (c == ScoreLevel.moderate) {
 result.add('Terkadang sulit konsisten mempertahankan disiplin saat motivasi sedang menurun.');
 } else {
 result.add('Rentan menunda pekerjaan (prokrastinasi) dan sulit menjaga konsistensi jangka panjang.');
 result.add('Seringkali kurang terorganisir sehingga hal-hal penting bisa terlewat.');
 }

 if (e == ScoreLevel.high) {
 result.add('Sulit berkonsentrasi dalam kondisi sunyi atau saat harus bekerja sendirian dalam waktu lama.');
 result.add('Kadang terlalu mendominasi percakapan sehingga kurang memberi ruang bagi orang lain.');
 } else if (e == ScoreLevel.moderate) {
 result.add('Energi sosial yang tidak konsisten bisa membuat orang lain sulit memprediksi respons Anda.');
 } else {
 result.add('Bisa tampak tertutup atau sulit didekati, terutama oleh orang yang baru mengenal Anda.');
 result.add('Jaringan relasi yang lebih kecil bisa membatasi peluang yang datang dari koneksi sosial.');
 }

 if (a == ScoreLevel.high) {
 result.add('Terlalu memprioritaskan kebutuhan orang lain sehingga kebutuhan sendiri sering terabaikan.');
 result.add('Sulit menolak permintaan orang lain meski sebenarnya sudah kewalahan.');
 } else if (a == ScoreLevel.moderate) {
 result.add('Dalam situasi tertentu bisa tampak tidak konsisten antara bersikap tegas atau akomodatif.');
 } else {
 result.add('Bisa dianggap tidak berempati atau terlalu kritis oleh orang-orang yang lebih sensitif.');
 result.add('Gaya komunikasi yang blak-blakan kadang menciptakan ketegangan dalam hubungan tim.');
 }

 if (n == ScoreLevel.low) {
 result.add('Terkadang kurang peka terhadap situasi yang memang perlu diantisipasi lebih hati-hati.');
 } else if (n == ScoreLevel.moderate) {
 result.add('Stres sesekali bisa mengganggu performa, terutama saat banyak hal terjadi bersamaan.');
 } else {
 result.add('Kecemasan yang berlebihan dapat menghambat pengambilan keputusan dan tindakan.');
 result.add('Emosi yang mudah fluktuatif bisa memengaruhi produktivitas dan hubungan dengan orang lain.');
 result.add('Cenderung merenung dan menganalisis kesalahan masa lalu secara berlebihan (overthinking).');
 }

 return result;
 }

 // 
 // PANDUAN KARIR
 // 
 static List<String> _careerPaths(
 ScoreLevel o,
 ScoreLevel c,
 ScoreLevel e,
 ScoreLevel a,
 ScoreLevel n,
 ) {
 final List<String> result = [];

 // Kombinasi O tinggi
 if (o == ScoreLevel.high && c == ScoreLevel.high) {
 result.add('Arsitek / Desainer Produk — kreativitas tinggi yang dieksekusi dengan disiplin menghasilkan karya berkualitas.');
 result.add('Peneliti / Ilmuwan — kemampuan eksplorasi ide dikombinasikan dengan metodologi yang ketat.');
 result.add('Konsultan Strategi / Innovation Lead — merancang solusi baru dan memastikan implementasinya berjalan.');
 } else if (o == ScoreLevel.high && e == ScoreLevel.high) {
 result.add('Direktur Kreatif / Art Director — memimpin tim kreatif dengan visi dan energi yang kuat.');
 result.add('Pembicara Publik / Edukator — berbagi ide-ide segar kepada khalayak luas.');
 result.add('Entrepreneur / Founder Startup — mendorong inovasi sambil membangun jaringan dan komunitas.');
 } else if (o == ScoreLevel.high) {
 result.add('Penulis / Jurnalis / Content Creator — menuangkan imajinasi dan perspektif unik melalui tulisan.');
 result.add('Sutradara / Produser Konten — mengubah ide kreatif menjadi karya visual yang berdampak.');
 result.add('UX Researcher / Product Designer — mengeksplorasi solusi desain berbasis riset pengguna.');
 }

 // Kombinasi C tinggi
 if (c == ScoreLevel.high && a == ScoreLevel.high) {
 result.add('Dokter / Perawat / Tenaga Medis — perhatian terhadap detail dan empati yang tinggi.');
 result.add('Guru / Dosen / Instruktur — tanggung jawab mendidik dengan penuh perhatian pada perkembangan orang lain.');
 result.add('Manajer Proyek / Koordinator Program — terstruktur dalam eksekusi, hangat dalam memimpin tim.');
 } else if (c == ScoreLevel.high && n == ScoreLevel.low) {
 result.add('Manajer / Eksekutif Korporat — ketenangan dan keteraturan yang dibutuhkan untuk kepemimpinan level tinggi.');
 result.add('Auditor / Akuntan / Analis Keuangan — presisi, ketelitian, dan stabilitas emosi sangat dibutuhkan.');
 result.add('Analis Keamanan Siber — kewaspadaan detail tanpa panik dalam menghadapi ancaman.');
 } else if (c == ScoreLevel.high) {
 result.add('Data Analyst / Business Analyst — mengolah data secara sistematis untuk menghasilkan insight bisnis.');
 result.add('Insinyur / Engineer — merancang dan membangun sesuatu dengan standar presisi tinggi.');
 result.add('Operations Manager / Supply Chain — mengelola proses dan logistik secara terstruktur.');
 }

 // Kombinasi E tinggi
 if (e == ScoreLevel.high && a == ScoreLevel.high) {
 result.add('Sales / Account Manager — membangun relasi jangka panjang yang saling menguntungkan.');
 result.add('Konselor / Psikolog Klinis — mendengarkan, memahami, dan membantu orang melewati tantangan.');
 result.add('Diplomat / Hubungan Internasional — negosiasi dan membangun hubungan lintas budaya.');
 } else if (e == ScoreLevel.high) {
 result.add('Marketing Manager / Brand Strategist — membangun kesadaran merek dengan energi dan ide yang menular.');
 result.add('MC / Host / Presenter — menjadi wajah dan suara yang mampu menghidupkan sebuah acara.');
 result.add('HR Manager / Talent Acquisition — menghubungkan orang dengan peluang yang tepat.');
 }

 // Kombinasi E rendah
 if (e == ScoreLevel.low && o == ScoreLevel.high) {
 result.add('Software Engineer / Backend Developer — bekerja mandiri dengan fokus mendalam pada pemecahan masalah teknis.');
 result.add('Peneliti Akademik / Analis Kebijakan — menggali wawasan mendalam secara independen.');
 } else if (e == ScoreLevel.low && c == ScoreLevel.high) {
 result.add('Quality Assurance Engineer — ketelitian dan kemampuan kerja mandiri yang sangat dibutuhkan.');
 result.add('Technical Writer / Editor — menghasilkan dokumentasi berkualitas dengan konsentrasi penuh.');
 }

 // Fallback jika hasil terlalu umum
 if (result.isEmpty) {
 result.add('Bidang apapun yang Anda masuki, kombinasi kepribadian Anda adalah aset unik.');
 result.add('Pertimbangkan peran yang memberi Anda otonomi dan kesempatan berkembang sesuai ritme Anda sendiri.');
 }

 return result;
 }

 // 
 // TIPS SELF IMPROVEMENT
 // 
 static List<String> _selfImprovementTips(
 ScoreLevel o,
 ScoreLevel c,
 ScoreLevel e,
 ScoreLevel a,
 ScoreLevel n,
 ) {
 final List<String> result = [];

 // Berdasarkan Openness
 if (o == ScoreLevel.high) {
 result.add('Latih kemampuan "follow-through": pilih satu proyek kreatif dan selesaikan sepenuhnya sebelum memulai yang baru.');
 result.add('Jadwalkan waktu khusus untuk eksplorasi ide agar tidak mengganggu pekerjaan utama (misalnya "jam kreatif" 30 menit/hari).');
 } else if (o == ScoreLevel.low) {
 result.add('Tantang diri seminggu sekali mencoba satu hal kecil yang belum pernah dilakukan — mulai dari makanan baru, rute baru, atau genre buku baru.');
 result.add('Biasakan membaca artikel atau mendengarkan podcast dari bidang yang sama sekali tidak familiar untuk memperluas perspektif.');
 }

 // Berdasarkan Conscientiousness
 if (c == ScoreLevel.high) {
 result.add('Praktikkan "good enough" untuk tugas-tugas minor — tidak semua pekerjaan perlu sempurna, selesaikan yang penting terlebih dahulu.');
 result.add('Latih delegasi: percayakan tugas kepada orang lain dan tahan keinginan untuk mengontrol setiap detailnya.');
 } else if (c == ScoreLevel.low) {
 result.add('Mulai dengan sistem yang sederhana: to-do list harian dengan maksimal 3 prioritas utama per hari.');
 result.add('Gunakan teknik "habit stacking" — tempelkan kebiasaan baru ke rutinitas yang sudah ada agar lebih mudah konsisten.');
 result.add('Set alarm atau reminder untuk tenggat waktu, dan latih komitmen menyelesaikan sebelum alarm kedua berbunyi.');
 }

 // Berdasarkan Extraversion
 if (e == ScoreLevel.high) {
 result.add('Latih kemampuan mendengarkan aktif: dalam percakapan berikutnya, fokus pada memahami daripada merespons.');
 result.add('Sisihkan 30 menit sehari untuk refleksi diam-diam — jurnal, meditasi, atau sekadar duduk tanpa distraksi.');
 } else if (e == ScoreLevel.low) {
 result.add('Latih public speaking secara bertahap: mulai dari berbicara di kelompok kecil yang aman sebelum forum yang lebih besar.');
 result.add('Buat target "satu koneksi baru per minggu" — tidak harus pertemanan dalam, cukup percakapan bermakna dengan seseorang baru.');
 }

 // Berdasarkan Agreeableness
 if (a == ScoreLevel.high) {
 result.add('Latih untuk berkata "tidak" dengan sopan tapi tegas — kebutuhan Anda sama pentingnya dengan kebutuhan orang lain.');
 result.add('Sebelum setuju membantu, tanyakan pada diri sendiri: "Apakah saya punya kapasitas untuk ini?" Jujurlah pada jawabannya.');
 } else if (a == ScoreLevel.low) {
 result.add('Latih empati aktif: sebelum merespons dalam debat atau diskusi, coba ulangi sudut pandang lawan bicara dengan kata-kata sendiri.');
 result.add('Perhatikan bahasa tubuh dan nada bicara — seringkali dampak komunikasi bukan dari apa yang dikatakan, tapi bagaimana cara mengatakannya.');
 }

 // Berdasarkan Neuroticism
 if (n == ScoreLevel.high) {
 result.add('Terapkan teknik "5-4-3-2-1 Grounding" saat kecemasan muncul: sebutkan 5 hal yang dilihat, 4 yang didengar, 3 yang disentuh, 2 yang dicium, 1 yang dirasakan.');
 result.add('Buat "worry journal": tulis semua kekhawatiran di pagi hari lalu tutup buku tersebut — pisahkan waktu khawatir dari waktu produktif.');
 result.add('Bangun rutinitas pagi yang stabil (olahraga ringan, sarapan, journaling) untuk memberikan "jangkar" emosional di awal hari.');
 result.add('Pertimbangkan berbicara dengan psikolog atau konselor — bukan karena ada yang salah, tapi karena Anda layak mendapat dukungan terbaik.');
 } else if (n == ScoreLevel.low) {
 result.add('Sesekali tanyakan pada orang terdekat: "Apakah ada yang perlu aku waspadai?" — stabilitas emosi Anda bisa membuat Anda melewatkan sinyal penting.');
 }

 return result;
 }

 // 
 // TIPS BELAJAR EFEKTIF
 // 
 static List<String> _learningTips(
 ScoreLevel o,
 ScoreLevel c,
 ScoreLevel e,
 ScoreLevel a,
 ScoreLevel n,
 ) {
 final List<String> result = [];

 // Gaya belajar berdasarkan Openness
 if (o == ScoreLevel.high) {
 result.add('Anda belajar terbaik lewat eksplorasi bebas — mind mapping, rabbit hole riset, dan menghubungkan konsep dari bidang yang berbeda.');
 result.add('Pilih buku non-fiksi atau kursus interdisipliner yang menantang asumsi Anda, bukan hanya mengkonfirmasi apa yang sudah diketahui.');
 result.add('Coba metode "deliberate play" — pelajari sesuatu melalui eksperimen dan prototype cepat sebelum membaca teorinya secara mendalam.');
 } else if (o == ScoreLevel.low) {
 result.add('Anda belajar paling efektif dengan panduan yang jelas dan terstruktur — pilih kursus dengan silabus yang rapi dan progres yang terukur.');
 result.add('Ulangi materi dengan metode yang sama sebelum berganti metode baru — konsistensi lebih penting dari variasi untuk Anda.');
 result.add('Fokus pada satu keterampilan hingga benar-benar kompeten sebelum beralih ke topik berikutnya.');
 } else {
 result.add('Anda fleksibel dalam gaya belajar — kombinasikan sumber terstruktur (kursus) dengan eksplorasi bebas (bacaan mandiri) secara bergantian.');
 }

 // Berdasarkan Conscientiousness
 if (c == ScoreLevel.high) {
 result.add('Buat jadwal belajar mingguan yang spesifik: tentukan topik, durasi, dan output yang diharapkan untuk setiap sesi.');
 result.add('Gunakan sistem checklist atau aplikasi spaced repetition (Anki, Quizlet) untuk memastikan tidak ada materi yang terlewat.');
 } else if (c == ScoreLevel.low) {
 result.add('⏱ Gunakan teknik Pomodoro (25 menit fokus, 5 menit istirahat) untuk membangun konsistensi belajar tanpa terasa berat.');
 result.add('Belajar bersama teman atau bergabung dengan study group agar ada akuntabilitas eksternal yang memotivasi.');
 result.add('Gamifikasi proses belajar — berikan reward kecil pada diri sendiri setiap menyelesaikan satu unit materi.');
 }

 // Berdasarkan Extraversion
 if (e == ScoreLevel.high) {
 result.add('Metode "teach back" sangat cocok untuk Anda — segera ajarkan apa yang baru dipelajari kepada orang lain untuk memperkuat pemahaman.');
 result.add('Bergabunglah dengan komunitas belajar, diskusi kelompok, atau bootcamp yang melibatkan banyak interaksi langsung.');
 result.add('Rekam diri Anda menjelaskan konsep dengan suara keras — mendengarkan kembali rekaman sendiri adalah cara belajar yang sangat efektif untuk Anda.');
 } else if (e == ScoreLevel.low) {
 result.add('Anda belajar terbaik dalam kondisi tenang dan minim gangguan — ciptakan ruang belajar khusus yang bebas dari distraksi sosial.');
 result.add('Tulisan dan catatan adalah alat belajar utama Anda — invest pada sistem notetaking yang baik (Obsidian, Notion, atau buku catatan analog).');
 result.add('Self-paced learning (kursus online asynchronous) jauh lebih cocok daripada kelas tatap muka yang menuntut partisipasi spontan.');
 }

 // Berdasarkan Neuroticism
 if (n == ScoreLevel.high) {
 result.add('Mulai sesi belajar dengan 5 menit pernapasan dalam atau meditasi singkat untuk menurunkan kecemasan dan meningkatkan fokus.');
 result.add('Hindari belajar dalam sesi marathon yang panjang — bagi materi menjadi bagian-bagian kecil yang terasa manageable dan tidak overwhelming.');
 result.add('Fokus pada progres, bukan kesempurnaan — track kemajuan Anda setiap minggu untuk melihat bahwa Anda memang berkembang.');
 } else if (n == ScoreLevel.low) {
 result.add('Manfaatkan ketahanan stres Anda untuk belajar di bawah tekanan — ujian simulasi dan deadline ketat justru bisa meningkatkan performa Anda.');
 }

 // Agreeableness dan kolaborasi belajar
 if (a == ScoreLevel.high) {
 result.add('Peer learning dan mentoring orang lain adalah cara belajar yang sangat efektif untuk Anda — mengajar memperkuat pemahaman sekaligus memberi makna.');
 } else if (a == ScoreLevel.low) {
 result.add('Belajar lewat kompetisi (hackathon, kompetisi coding, olimpiade) bisa menjadi motivator kuat untuk Anda.');
 }

 return result;
 }
}