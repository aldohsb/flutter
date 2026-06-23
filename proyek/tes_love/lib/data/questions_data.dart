import '../models/quiz_result_model.dart';

class QuizQuestion {
  final int id;
  final String text;
  final List<QuizOption> options;

  const QuizQuestion({
    required this.id,
    required this.text,
    required this.options,
  });
}

class QuizOption {
  final String text;
  final LoveLanguage language;

  const QuizOption({
    required this.text,
    required this.language,
  });
}

/// 40 soal — 10 pasangan love language × 4 ulangan
/// Bahasa netral: cocok untuk semua usia dan konteks hubungan
/// (pasangan, keluarga, pertemanan, anak, remaja)
///
/// Distribusi:
///  1– 4 : Words × Quality Time
///  5– 8 : Words × Gifts
///  9–12 : Words × Acts of Service
/// 13–16 : Words × Physical Touch
/// 17–20 : Quality Time × Gifts
/// 21–24 : Quality Time × Acts of Service
/// 25–28 : Quality Time × Physical Touch
/// 29–32 : Gifts × Acts of Service
/// 33–36 : Gifts × Physical Touch
/// 37–40 : Acts of Service × Physical Touch

final List<QuizQuestion> quizQuestions = [

  // ══════════════════════════════════════════════════════════
  // BLOK 1 — Words of Affirmation × Quality Time (1–4)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 1,
    text: 'Ketika seseorang yang kamu sayangi ingin menunjukkan perhatian, '
        'kamu lebih senang jika mereka...',
    options: [
      QuizOption(
        text: 'Mengucapkan kata-kata tulus seperti "Aku bangga padamu" atau "Kamu berarti untukku"',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Meluangkan waktu khusus bersamamu tanpa terganggu hal lain',
        language: LoveLanguage.qualityTime,
      ),
    ],
  ),

  const QuizQuestion(
    id: 2,
    text: 'Saat kamu sedang sedih atau kecewa, hal yang paling membuatmu merasa lebih baik adalah...',
    options: [
      QuizOption(
        text: 'Mendengar kata-kata penyemangat dan dukungan dari orang terdekat',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Ada seseorang yang menemanimu dan benar-benar mendengarkan ceritamu',
        language: LoveLanguage.qualityTime,
      ),
    ],
  ),

  const QuizQuestion(
    id: 3,
    text: 'Kamu merasa hubunganmu dengan seseorang semakin dekat ketika...',
    options: [
      QuizOption(
        text: 'Mereka sering mengungkapkan rasa sayang atau apresiasinya secara langsung',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Kalian punya waktu rutin untuk ngobrol atau melakukan sesuatu bersama',
        language: LoveLanguage.qualityTime,
      ),
    ],
  ),

  const QuizQuestion(
    id: 4,
    text: 'Hal yang paling membuatmu merasa tidak dihargai adalah...',
    options: [
      QuizOption(
        text: 'Jarang mendapat pujian atau pengakuan atas usaha yang sudah kamu lakukan',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Orang-orang terdekat selalu tampak sibuk dan tidak ada waktu untukmu',
        language: LoveLanguage.qualityTime,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 2 — Words of Affirmation × Receiving Gifts (5–8)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 5,
    text: 'Di hari ulang tahunmu, ungkapan perhatian yang paling menyentuh hatimu adalah...',
    options: [
      QuizOption(
        text: 'Ucapan panjang yang tulus tentang betapa berartinya kamu bagi mereka',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Hadiah kecil yang dipilih dengan penuh perhatian karena mereka tahu kamu menyukainya',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 6,
    text: 'Ketika kamu berhasil mencapai sesuatu, reaksi yang paling membuatmu bahagia adalah...',
    options: [
      QuizOption(
        text: 'Dipuji dan diakui dengan kata-kata hangat seperti "Kamu luar biasa!"',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Diberi sesuatu sebagai tanda mereka ikut merayakan pencapaianmu',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 7,
    text: 'Cara seseorang menunjukkan perhatian yang paling terasa bagimu adalah...',
    options: [
      QuizOption(
        text: 'Mereka sering bilang hal-hal positif tentangmu atau mengungkapkan rasa terima kasih',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Mereka mengingat hal-hal kecil yang kamu suka dan menghadirkannya sebagai kejutan',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 8,
    text: 'Saat seseorang baru saja pulang dari perjalanan jauh, yang paling kamu harapkan adalah...',
    options: [
      QuizOption(
        text: 'Mereka bercerita dan bilang betapa merindukan kehadiranmu',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Mereka membawakanmu sesuatu kecil karena teringat padamu selama perjalanan',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 3 — Words of Affirmation × Acts of Service (9–12)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 9,
    text: 'Ketika kamu sedang kewalahan mengerjakan banyak hal, bantuan yang paling berarti adalah...',
    options: [
      QuizOption(
        text: 'Seseorang yang menyemangatimu dengan kata-kata dan mengingatkanmu bahwa kamu bisa',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Seseorang yang langsung turun tangan membantu tanpa perlu diminta',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 10,
    text: 'Bukti nyata bahwa seseorang peduli padamu menurut kamu adalah...',
    options: [
      QuizOption(
        text: 'Mereka selalu punya kata-kata yang tepat untuk membuatmu merasa dilihat dan dihargai',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Mereka melakukan tindakan nyata yang meringankan hidupmu, sekecil apapun itu',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 11,
    text: 'Setelah hari yang berat, kamu paling ingin...',
    options: [
      QuizOption(
        text: 'Mendengar seseorang berkata "Kamu sudah berusaha keras hari ini, aku bangga"',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Ada seseorang yang membantu membereskan sesuatu agar bebanmu berkurang',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 12,
    text: 'Dalam sebuah hubungan yang sehat, kamu paling menghargai seseorang yang...',
    options: [
      QuizOption(
        text: 'Tidak pelit dalam mengungkapkan apresiasi, pujian, dan rasa sayangnya',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Selalu proaktif membantu dan mengikuti kata-katanya dengan tindakan nyata',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 4 — Words of Affirmation × Physical Touch (13–16)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 13,
    text: 'Setelah berdamai dari sebuah kesalahpahaman, yang paling membuatmu lega adalah...',
    options: [
      QuizOption(
        text: 'Mendengar kata-kata tulus bahwa semuanya sudah baik-baik saja',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Pelukan hangat sebagai tanda bahwa hubungan kalian kembali pulih',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 14,
    text: 'Saat kamu merasa stres atau cemas, yang paling cepat menenangkanmu adalah...',
    options: [
      QuizOption(
        text: 'Kata-kata menenangkan dari seseorang yang kamu percaya',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Sentuhan fisik yang hangat seperti pelukan atau tepukan di bahu',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 15,
    text: 'Cara salam atau perpisahan yang paling bermakna bagimu adalah...',
    options: [
      QuizOption(
        text: 'Ucapan tulus seperti "Hati-hati ya, aku peduli padamu"',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Pelukan atau high-five hangat setiap kali bertemu dan berpisah',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 16,
    text: 'Menurutmu, rasa dekat dengan seseorang paling terasa melalui...',
    options: [
      QuizOption(
        text: 'Kata-kata yang jujur dan terbuka yang mengungkapkan perasaan mereka',
        language: LoveLanguage.wordsOfAffirmation,
      ),
      QuizOption(
        text: 'Kontak fisik yang alami dan nyaman seperti bersalaman, berpelukan, atau menepuk punggung',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 5 — Quality Time × Receiving Gifts (17–20)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 17,
    text: 'Jika ada seseorang yang ingin menunjukkan bahwa mereka memikirkanmu, caranya yang paling berkesan adalah...',
    options: [
      QuizOption(
        text: 'Mengajakmu ngobrol panjang atau melakukan sesuatu bersama tanpa terburu-buru',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Memberimu sesuatu — sekecil apapun — karena mereka ingat hal yang kamu sukai',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 18,
    text: 'Hari yang terasa spesial bagimu biasanya ditandai dengan...',
    options: [
      QuizOption(
        text: 'Menghabiskan waktu berkualitas bersama orang yang kamu sayangi',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Menerima sesuatu yang tak terduga dari seseorang yang peduli',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 19,
    text: 'Kamu merasa benar-benar diperhatikan ketika...',
    options: [
      QuizOption(
        text: 'Seseorang mau meluangkan waktunya hanya untuk bersamamu, tanpa agenda lain',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Seseorang memberikanmu sesuatu yang menunjukkan mereka benar-benar mengenalmu',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  const QuizQuestion(
    id: 20,
    text: 'Saat jarak memisahkan kamu dari orang yang kamu sayangi, kamu paling merindukan...',
    options: [
      QuizOption(
        text: 'Momen-momen sederhana saat kalian bisa hadir bersama tanpa distraksi',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Menerima kiriman atau titipan kecil sebagai tanda mereka masih memikirkanmu',
        language: LoveLanguage.receivingGifts,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 6 — Quality Time × Acts of Service (21–24)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 21,
    text: 'Tanda persahabatan atau hubungan yang kuat bagimu adalah...',
    options: [
      QuizOption(
        text: 'Kalian punya waktu rutin untuk benar-benar hadir satu sama lain',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Kalian saling membantu secara nyata saat dibutuhkan tanpa harus diminta',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 22,
    text: 'Ketika seseorang ingin membuat harimu lebih baik, kamu berharap mereka...',
    options: [
      QuizOption(
        text: 'Mengajakmu jalan-jalan atau sekadar duduk bersama dan mengobrol',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Melakukan sesuatu yang nyata untuk meringankan bebanmu hari itu',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 23,
    text: 'Liburan atau hari bebas yang ideal bagimu adalah...',
    options: [
      QuizOption(
        text: 'Menghabiskannya bersama orang-orang yang berarti, fokus satu sama lain',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Ada orang yang membantu mempersiapkan atau mengurus hal-hal agar kamu bisa benar-benar istirahat',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 24,
    text: 'Kamu merasa paling terhubung dengan seseorang ketika...',
    options: [
      QuizOption(
        text: 'Kalian melakukan aktivitas bersama yang membuat waktu terasa berlalu cepat',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Mereka secara aktif membantu kehidupan sehari-harimu menjadi lebih mudah',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 7 — Quality Time × Physical Touch (25–28)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 25,
    text: 'Momen kebersamaan yang paling hangat bagimu adalah ketika...',
    options: [
      QuizOption(
        text: 'Kalian benar-benar fokus satu sama lain tanpa ada yang sibuk sendiri',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Ada kontak fisik yang hangat dan alami seperti duduk berdekatan atau berpelukan',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 26,
    text: 'Ketika bertemu seseorang setelah lama tidak berjumpa, yang pertama kamu rindukan adalah...',
    options: [
      QuizOption(
        text: 'Waktu ngobrol panjang untuk mengejar semua yang terlewat',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Pelukan erat sebagai sambutan yang langsung terasa hangat',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 27,
    text: 'Dalam sebuah pertemuan yang berkesan, kamu biasanya pulang dengan perasaan hangat karena...',
    options: [
      QuizOption(
        text: 'Kalian benar-benar hadir dan menikmati waktu bersama tanpa distraksi',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Ada sentuhan fisik yang nyaman — tepukan, gandengan tangan, atau pelukan perpisahan',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 28,
    text: 'Kamu merasa paling aman dan nyaman bersama seseorang ketika...',
    options: [
      QuizOption(
        text: 'Mereka selalu punya waktu dan perhatian penuh untukmu',
        language: LoveLanguage.qualityTime,
      ),
      QuizOption(
        text: 'Ada kebiasaan sentuhan fisik yang alami dan tidak canggung di antara kalian',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 8 — Receiving Gifts × Acts of Service (29–32)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 29,
    text: 'Saat kamu sakit atau tidak enak badan, bentuk perhatian yang paling menyentuh adalah...',
    options: [
      QuizOption(
        text: 'Dibelikan makanan, minuman, atau sesuatu yang kamu butuhkan tanpa kamu minta',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Ada yang merawatmu — membuatkan minuman hangat, menemanimu, atau mengurus keperluanmu',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 30,
    text: 'Untuk menunjukkan bahwa kamu peduli pada seseorang, kamu lebih cenderung...',
    options: [
      QuizOption(
        text: 'Mencari atau membuat sesuatu yang bermakna untuk diberikan kepadanya',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Melakukan sesuatu yang nyata untuk meringankan beban atau memudahkan harinya',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 31,
    text: 'Kamu merasa sangat dipedulikan ketika...',
    options: [
      QuizOption(
        text: 'Menerima sesuatu yang tak terduga karena seseorang mengingat kesukaanmu',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Seseorang tiba-tiba membantu menyelesaikan sesuatu yang sedang membebankanmu',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  const QuizQuestion(
    id: 32,
    text: 'Orang yang paling berkesan dalam hidupmu biasanya adalah mereka yang...',
    options: [
      QuizOption(
        text: 'Selalu ingat momen-momen penting dan menyiapkan sesuatu yang spesial untukmu',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Selalu ada secara nyata — membantu, mendukung, dan tidak hanya bicara',
        language: LoveLanguage.actsOfService,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 9 — Receiving Gifts × Physical Touch (33–36)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 33,
    text: 'Ekspresi kasih sayang yang paling langsung terasa bagimu adalah...',
    options: [
      QuizOption(
        text: 'Menerima sesuatu — sekecil apapun — yang dipilih dengan penuh perhatian',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Pelukan hangat atau sentuhan fisik yang tulus',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 34,
    text: 'Saat seseorang ingin menghiburmu yang sedang sedih, cara yang paling efektif bagimu adalah...',
    options: [
      QuizOption(
        text: 'Mereka membawakan sesuatu — makanan favoritmu atau hal kecil yang kamu suka',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Mereka memelukmu atau menepuk bahumu sebagai tanda mereka ada untukmu',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 35,
    text: 'Kamu cenderung menilai seseorang benar-benar mengenalmu ketika...',
    options: [
      QuizOption(
        text: 'Mereka memberikan sesuatu yang pas dengan selera dan kepribadianmu',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Mereka nyaman melakukan kontak fisik yang hangat dan tidak kaku bersamamu',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 36,
    text: 'Dalam persahabatan yang dekat, hal yang paling membuat kamu merasa dihargai adalah...',
    options: [
      QuizOption(
        text: 'Mereka selalu ingat detail-detail kecil tentangmu dan menunjukkannya lewat pemberian',
        language: LoveLanguage.receivingGifts,
      ),
      QuizOption(
        text: 'Ada rasa nyaman fisik di antara kalian — bisa berpelukan atau bersandar tanpa canggung',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  // ══════════════════════════════════════════════════════════
  // BLOK 10 — Acts of Service × Physical Touch (37–40)
  // ══════════════════════════════════════════════════════════

  const QuizQuestion(
    id: 37,
    text: 'Saat kamu lelah dan butuh dukungan, yang paling langsung membuatmu merasa tertolong adalah...',
    options: [
      QuizOption(
        text: 'Ada seseorang yang langsung membantu — mengerjakan sesuatu agar bebanmu berkurang',
        language: LoveLanguage.actsOfService,
      ),
      QuizOption(
        text: 'Ada seseorang yang memelukmu erat atau menepuk bahumu sebagai tanda mereka ada',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 38,
    text: 'Menurutmu, kehadiran seseorang paling terasa nyata melalui...',
    options: [
      QuizOption(
        text: 'Tindakan nyata yang mereka lakukan untuk memudahkan hidupmu',
        language: LoveLanguage.actsOfService,
      ),
      QuizOption(
        text: 'Kedekatan fisik yang membuat kamu merasa tidak sendirian',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 39,
    text: 'Cara terbaik seseorang menunjukkan dukungan saat kamu menghadapi tantangan adalah...',
    options: [
      QuizOption(
        text: 'Ikut terlibat secara aktif — membantu memikirkan solusi atau mengerjakan bagiannya',
        language: LoveLanguage.actsOfService,
      ),
      QuizOption(
        text: 'Duduk di sampingmu, menyentuh bahumu, dan membuat kamu tahu mereka ada',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

  const QuizQuestion(
    id: 40,
    text: 'Kamu merasa paling tidak kesepian ketika...',
    options: [
      QuizOption(
        text: 'Ada seseorang yang secara nyata melakukan sesuatu untukmu tanpa diminta',
        language: LoveLanguage.actsOfService,
      ),
      QuizOption(
        text: 'Ada seseorang yang hadir secara fisik dan membuat kamu merasa dekat lewat sentuhan',
        language: LoveLanguage.physicalTouch,
      ),
    ],
  ),

];