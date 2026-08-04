import 'character_item.dart';

/// Kumpulan kanji dasar setara JLPT N5-N4 (~243 karakter).
/// Setiap kanji dipetakan ke SATU bacaan latin yang paling umum diajarkan
/// pada level pemula (bisa kun'yomi atau on'yomi, tergantung mana yang
/// paling lazim dipakai berdiri sendiri), ditambah [CharacterItem.meaningId]
/// berupa arti singkat dalam Bahasa Indonesia yang ditampilkan di
/// [CharacterListScreen]. Urutan list disusun dari kanji paling dasar
/// (angka, waktu, orang) menuju kanji yang lebih abstrak, mengikuti pola
/// kesulitan JLPT N5 -> N4.
const List<CharacterItem> kKanjiData = [
  // --- Angka dasar ---
  CharacterItem(character: '一', romaji: 'ichi', meaningId: 'satu'),
  CharacterItem(character: '二', romaji: 'ni', meaningId: 'dua'),
  CharacterItem(character: '三', romaji: 'san', meaningId: 'tiga'),
  CharacterItem(character: '四', romaji: 'yon', meaningId: 'empat'),
  CharacterItem(character: '五', romaji: 'go', meaningId: 'lima'),
  CharacterItem(character: '六', romaji: 'roku', meaningId: 'enam'),
  CharacterItem(character: '七', romaji: 'nana', meaningId: 'tujuh'),
  CharacterItem(character: '八', romaji: 'hachi', meaningId: 'delapan'),
  CharacterItem(character: '九', romaji: 'kyuu', meaningId: 'sembilan'),
  CharacterItem(character: '十', romaji: 'juu', meaningId: 'sepuluh'),
  CharacterItem(character: '百', romaji: 'hyaku', meaningId: 'seratus'),
  CharacterItem(character: '千', romaji: 'sen', meaningId: 'seribu'),
  CharacterItem(character: '万', romaji: 'man', meaningId: 'sepuluh ribu'),

  // --- Waktu & kalender ---
  CharacterItem(character: '円', romaji: 'en', meaningId: 'yen (mata uang)'),
  CharacterItem(character: '年', romaji: 'toshi', meaningId: 'tahun'),
  CharacterItem(character: '月', romaji: 'tsuki', meaningId: 'bulan'),
  CharacterItem(character: '日', romaji: 'hi', meaningId: 'hari / matahari'),
  CharacterItem(character: '時', romaji: 'toki', meaningId: 'waktu / jam'),
  CharacterItem(character: '分', romaji: 'fun', meaningId: 'menit / bagian'),
  CharacterItem(character: '半', romaji: 'han', meaningId: 'setengah'),
  CharacterItem(character: '週', romaji: 'shuu', meaningId: 'minggu'),
  CharacterItem(character: '曜', romaji: 'you', meaningId: 'hari dalam minggu'),
  CharacterItem(character: '今', romaji: 'ima', meaningId: 'sekarang'),

  // --- Orang & keluarga ---
  CharacterItem(character: '人', romaji: 'hito', meaningId: 'orang'),
  CharacterItem(character: '男', romaji: 'otoko', meaningId: 'laki-laki'),
  CharacterItem(character: '女', romaji: 'onna', meaningId: 'perempuan'),
  CharacterItem(character: '子', romaji: 'ko', meaningId: 'anak'),
  CharacterItem(character: '父', romaji: 'chichi', meaningId: 'ayah'),
  CharacterItem(character: '母', romaji: 'haha', meaningId: 'ibu'),
  CharacterItem(character: '友', romaji: 'tomo', meaningId: 'teman'),
  CharacterItem(character: '先', romaji: 'saki', meaningId: 'sebelum / duluan'),
  CharacterItem(character: '生', romaji: 'sei', meaningId: 'hidup / lahir'),
  CharacterItem(character: '私', romaji: 'watashi', meaningId: 'saya'),
  CharacterItem(character: '兄', romaji: 'ani', meaningId: 'kakak laki-laki'),
  CharacterItem(character: '姉', romaji: 'ane', meaningId: 'kakak perempuan'),
  CharacterItem(character: '弟', romaji: 'otouto', meaningId: 'adik laki-laki'),
  CharacterItem(character: '妹', romaji: 'imouto', meaningId: 'adik perempuan'),

  // --- Sekolah & tempat umum ---
  CharacterItem(character: '学', romaji: 'gaku', meaningId: 'belajar / ilmu'),
  CharacterItem(character: '校', romaji: 'kou', meaningId: 'sekolah'),
  CharacterItem(character: '名', romaji: 'na', meaningId: 'nama'),
  CharacterItem(character: '前', romaji: 'mae', meaningId: 'depan'),
  CharacterItem(character: '後', romaji: 'ushiro', meaningId: 'belakang'),
  CharacterItem(character: '中', romaji: 'naka', meaningId: 'dalam / tengah'),
  CharacterItem(character: '外', romaji: 'soto', meaningId: 'luar'),
  CharacterItem(character: '何', romaji: 'nani', meaningId: 'apa'),

  // --- Arah & posisi ---
  CharacterItem(character: '上', romaji: 'ue', meaningId: 'atas'),
  CharacterItem(character: '下', romaji: 'shita', meaningId: 'bawah'),
  CharacterItem(character: '左', romaji: 'hidari', meaningId: 'kiri'),
  CharacterItem(character: '右', romaji: 'migi', meaningId: 'kanan'),
  CharacterItem(character: '北', romaji: 'kita', meaningId: 'utara'),
  CharacterItem(character: '南', romaji: 'minami', meaningId: 'selatan'),
  CharacterItem(character: '東', romaji: 'higashi', meaningId: 'timur'),
  CharacterItem(character: '西', romaji: 'nishi', meaningId: 'barat'),

  // --- Bahasa & tulisan ---
  CharacterItem(character: '本', romaji: 'hon', meaningId: 'buku / asal'),
  CharacterItem(character: '語', romaji: 'go', meaningId: 'bahasa'),
  CharacterItem(character: '話', romaji: 'hanashi', meaningId: 'cerita / bicara'),
  CharacterItem(character: '字', romaji: 'ji', meaningId: 'huruf'),

  // --- Kata kerja dasar 1 ---
  CharacterItem(character: '読', romaji: 'yomu', meaningId: 'membaca'),
  CharacterItem(character: '書', romaji: 'kaku', meaningId: 'menulis'),
  CharacterItem(character: '聞', romaji: 'kiku', meaningId: 'mendengar'),
  CharacterItem(character: '見', romaji: 'miru', meaningId: 'melihat'),
  CharacterItem(character: '食', romaji: 'taberu', meaningId: 'makan'),
  CharacterItem(character: '飲', romaji: 'nomu', meaningId: 'minum'),
  CharacterItem(character: '行', romaji: 'iku', meaningId: 'pergi'),
  CharacterItem(character: '来', romaji: 'kuru', meaningId: 'datang'),
  CharacterItem(character: '帰', romaji: 'kaeru', meaningId: 'pulang'),
  CharacterItem(character: '出', romaji: 'deru', meaningId: 'keluar'),
  CharacterItem(character: '入', romaji: 'hairu', meaningId: 'masuk'),
  CharacterItem(character: '立', romaji: 'tatsu', meaningId: 'berdiri'),

  // --- Kata kerja dasar 2 ---
  CharacterItem(character: '休', romaji: 'yasumu', meaningId: 'istirahat'),
  CharacterItem(character: '買', romaji: 'kau', meaningId: 'membeli'),
  CharacterItem(character: '売', romaji: 'uru', meaningId: 'menjual'),
  CharacterItem(character: '待', romaji: 'matsu', meaningId: 'menunggu'),
  CharacterItem(character: '会', romaji: 'au', meaningId: 'bertemu'),
  CharacterItem(character: '言', romaji: 'iu', meaningId: 'berkata'),
  CharacterItem(character: '思', romaji: 'omou', meaningId: 'berpikir'),
  CharacterItem(character: '知', romaji: 'shiru', meaningId: 'mengetahui'),
  CharacterItem(character: '道', romaji: 'michi', meaningId: 'jalan'),
  CharacterItem(character: '車', romaji: 'kuruma', meaningId: 'mobil'),

  // --- Tempat ---
  CharacterItem(character: '駅', romaji: 'eki', meaningId: 'stasiun'),
  CharacterItem(character: '店', romaji: 'mise', meaningId: 'toko'),
  CharacterItem(character: '社', romaji: 'sha', meaningId: 'perusahaan'),
  CharacterItem(character: '家', romaji: 'ie', meaningId: 'rumah'),
  CharacterItem(character: '国', romaji: 'kuni', meaningId: 'negara'),
  CharacterItem(character: '町', romaji: 'machi', meaningId: 'kota kecil'),
  CharacterItem(character: '村', romaji: 'mura', meaningId: 'desa'),
  CharacterItem(character: '山', romaji: 'yama', meaningId: 'gunung'),
  CharacterItem(character: '川', romaji: 'kawa', meaningId: 'sungai'),
  CharacterItem(character: '海', romaji: 'umi', meaningId: 'laut'),

  // --- Alam 1 ---
  CharacterItem(character: '天', romaji: 'ten', meaningId: 'langit'),
  CharacterItem(character: '気', romaji: 'ki', meaningId: 'udara / semangat'),
  CharacterItem(character: '雨', romaji: 'ame', meaningId: 'hujan'),
  CharacterItem(character: '雪', romaji: 'yuki', meaningId: 'salju'),
  CharacterItem(character: '花', romaji: 'hana', meaningId: 'bunga'),
  CharacterItem(character: '木', romaji: 'ki', meaningId: 'pohon'),
  CharacterItem(character: '空', romaji: 'sora', meaningId: 'langit / kosong'),
  CharacterItem(character: '星', romaji: 'hoshi', meaningId: 'bintang'),
  CharacterItem(character: '風', romaji: 'kaze', meaningId: 'angin'),
  CharacterItem(character: '雲', romaji: 'kumo', meaningId: 'awan'),

  // --- Alam 2 ---
  CharacterItem(character: '光', romaji: 'hikari', meaningId: 'cahaya'),
  CharacterItem(character: '音', romaji: 'oto', meaningId: 'suara'),
  CharacterItem(character: '地', romaji: 'chi', meaningId: 'tanah / bumi'),
  CharacterItem(character: '森', romaji: 'mori', meaningId: 'hutan'),
  CharacterItem(character: '林', romaji: 'hayashi', meaningId: 'hutan kecil'),
  CharacterItem(character: '池', romaji: 'ike', meaningId: 'kolam'),
  CharacterItem(character: '石', romaji: 'ishi', meaningId: 'batu'),

  // --- Warna & tubuh ---
  CharacterItem(character: '赤', romaji: 'aka', meaningId: 'merah'),
  CharacterItem(character: '青', romaji: 'ao', meaningId: 'biru'),
  CharacterItem(character: '白', romaji: 'shiro', meaningId: 'putih'),
  CharacterItem(character: '黒', romaji: 'kuro', meaningId: 'hitam'),
  CharacterItem(character: '色', romaji: 'iro', meaningId: 'warna'),
  CharacterItem(character: '頭', romaji: 'atama', meaningId: 'kepala'),
  CharacterItem(character: '顔', romaji: 'kao', meaningId: 'wajah'),
  CharacterItem(character: '目', romaji: 'me', meaningId: 'mata'),
  CharacterItem(character: '耳', romaji: 'mimi', meaningId: 'telinga'),
  CharacterItem(character: '口', romaji: 'kuchi', meaningId: 'mulut'),
  CharacterItem(character: '手', romaji: 'te', meaningId: 'tangan'),
  CharacterItem(character: '足', romaji: 'ashi', meaningId: 'kaki'),
  CharacterItem(character: '体', romaji: 'karada', meaningId: 'tubuh'),
  CharacterItem(character: '心', romaji: 'kokoro', meaningId: 'hati / perasaan'),

  // ============ Tingkat N4 (lebih abstrak) ============

  // --- Kata sifat 1 ---
  CharacterItem(character: '古', romaji: 'furui', meaningId: 'lama / tua'),
  CharacterItem(character: '新', romaji: 'atarashii', meaningId: 'baru'),
  CharacterItem(character: '大', romaji: 'dai', meaningId: 'besar'),
  CharacterItem(character: '小', romaji: 'shou', meaningId: 'kecil'),
  CharacterItem(character: '高', romaji: 'takai', meaningId: 'tinggi / mahal'),
  CharacterItem(character: '安', romaji: 'yasui', meaningId: 'murah'),
  CharacterItem(character: '多', romaji: 'ooi', meaningId: 'banyak'),
  CharacterItem(character: '少', romaji: 'sukunai', meaningId: 'sedikit'),
  CharacterItem(character: '長', romaji: 'nagai', meaningId: 'panjang'),
  CharacterItem(character: '短', romaji: 'mijikai', meaningId: 'pendek'),
  CharacterItem(character: '早', romaji: 'hayai', meaningId: 'cepat / awal'),
  CharacterItem(character: '明', romaji: 'akarui', meaningId: 'terang'),

  // --- Kata sifat 2 ---
  CharacterItem(character: '暗', romaji: 'kurai', meaningId: 'gelap'),
  CharacterItem(character: '広', romaji: 'hiroi', meaningId: 'luas'),
  CharacterItem(character: '重', romaji: 'omoi', meaningId: 'berat'),
  CharacterItem(character: '軽', romaji: 'karui', meaningId: 'ringan'),
  CharacterItem(character: '強', romaji: 'tsuyoi', meaningId: 'kuat'),
  CharacterItem(character: '弱', romaji: 'yowai', meaningId: 'lemah'),
  CharacterItem(character: '暑', romaji: 'atsui', meaningId: 'panas (cuaca)'),
  CharacterItem(character: '寒', romaji: 'samui', meaningId: 'dingin (cuaca)'),
  CharacterItem(character: '冷', romaji: 'tsumetai', meaningId: 'dingin (benda)'),
  CharacterItem(character: '忙', romaji: 'isogashii', meaningId: 'sibuk'),

  // --- Kata sifat 3 ---
  CharacterItem(character: '好', romaji: 'suki', meaningId: 'suka'),
  CharacterItem(character: '悪', romaji: 'warui', meaningId: 'buruk / jahat'),
  CharacterItem(character: '同', romaji: 'onaji', meaningId: 'sama'),
  CharacterItem(character: '違', romaji: 'chigau', meaningId: 'berbeda'),
  CharacterItem(character: '若', romaji: 'wakai', meaningId: 'muda'),
  CharacterItem(character: '太', romaji: 'futoi', meaningId: 'gemuk / tebal'),
  CharacterItem(character: '細', romaji: 'hosoi', meaningId: 'kurus / tipis'),
  CharacterItem(character: '深', romaji: 'fukai', meaningId: 'dalam'),
  CharacterItem(character: '浅', romaji: 'asai', meaningId: 'dangkal'),
  CharacterItem(character: '汚', romaji: 'kitanai', meaningId: 'kotor'),

  // --- Kata sifat 4 ---
  CharacterItem(character: '美', romaji: 'utsukushii', meaningId: 'indah'),
  CharacterItem(character: '危', romaji: 'abunai', meaningId: 'berbahaya'),
  CharacterItem(character: '便', romaji: 'benri', meaningId: 'praktis'),
  CharacterItem(character: '有', romaji: 'yuu', meaningId: 'ada / punya'),
  CharacterItem(character: '特', romaji: 'toku', meaningId: 'khusus'),
  CharacterItem(character: '必', romaji: 'hitsu', meaningId: 'perlu'),

  // --- Kata kerja 3 ---
  CharacterItem(character: '使', romaji: 'tsukau', meaningId: 'menggunakan'),
  CharacterItem(character: '作', romaji: 'tsukuru', meaningId: 'membuat'),
  CharacterItem(character: '持', romaji: 'motsu', meaningId: 'membawa / memiliki'),
  CharacterItem(character: '働', romaji: 'hataraku', meaningId: 'bekerja'),
  CharacterItem(character: '歩', romaji: 'aruku', meaningId: 'berjalan'),
  CharacterItem(character: '走', romaji: 'hashiru', meaningId: 'berlari'),
  CharacterItem(character: '止', romaji: 'tomaru', meaningId: 'berhenti'),
  CharacterItem(character: '開', romaji: 'hiraku', meaningId: 'membuka'),
  CharacterItem(character: '閉', romaji: 'shimeru', meaningId: 'menutup'),
  CharacterItem(character: '教', romaji: 'oshieru', meaningId: 'mengajar'),
  CharacterItem(character: '習', romaji: 'narau', meaningId: 'belajar dari orang'),
  CharacterItem(character: '覚', romaji: 'oboeru', meaningId: 'mengingat'),

  // --- Kata kerja 4 ---
  CharacterItem(character: '忘', romaji: 'wasureru', meaningId: 'melupakan'),
  CharacterItem(character: '考', romaji: 'kangaeru', meaningId: 'memikirkan'),
  CharacterItem(character: '始', romaji: 'hajimaru', meaningId: 'mulai'),
  CharacterItem(character: '終', romaji: 'owaru', meaningId: 'selesai'),
  CharacterItem(character: '着', romaji: 'kiru', meaningId: 'memakai baju'),
  CharacterItem(character: '洗', romaji: 'arau', meaningId: 'mencuci'),
  CharacterItem(character: '死', romaji: 'shinu', meaningId: 'mati'),
  CharacterItem(character: '泳', romaji: 'oyogu', meaningId: 'berenang'),
  CharacterItem(character: '飛', romaji: 'tobu', meaningId: 'terbang'),
  CharacterItem(character: '乗', romaji: 'noru', meaningId: 'naik kendaraan'),
  CharacterItem(character: '降', romaji: 'oriru', meaningId: 'turun'),
  CharacterItem(character: '渡', romaji: 'wataru', meaningId: 'menyeberang'),

  // --- Kata kerja 5 ---
  CharacterItem(character: '通', romaji: 'tooru', meaningId: 'melewati'),
  CharacterItem(character: '曲', romaji: 'magaru', meaningId: 'berbelok'),
  CharacterItem(character: '貸', romaji: 'kasu', meaningId: 'meminjamkan'),
  CharacterItem(character: '借', romaji: 'kariru', meaningId: 'meminjam'),
  CharacterItem(character: '返', romaji: 'kaesu', meaningId: 'mengembalikan'),
  CharacterItem(character: '送', romaji: 'okuru', meaningId: 'mengirim'),
  CharacterItem(character: '運', romaji: 'hakobu', meaningId: 'mengangkut'),
  CharacterItem(character: '集', romaji: 'atsumeru', meaningId: 'mengumpulkan'),
  CharacterItem(character: '決', romaji: 'kimeru', meaningId: 'memutuskan'),
  CharacterItem(character: '選', romaji: 'erabu', meaningId: 'memilih'),
  CharacterItem(character: '続', romaji: 'tsuzukeru', meaningId: 'melanjutkan'),
  CharacterItem(character: '比', romaji: 'kuraberu', meaningId: 'membandingkan'),

  // --- Kata kerja 6 ---
  CharacterItem(character: '育', romaji: 'sodateru', meaningId: 'membesarkan'),
  CharacterItem(character: '泣', romaji: 'naku', meaningId: 'menangis'),
  CharacterItem(character: '笑', romaji: 'warau', meaningId: 'tertawa'),
  CharacterItem(character: '怒', romaji: 'okoru', meaningId: 'marah'),
  CharacterItem(character: '願', romaji: 'negau', meaningId: 'berharap'),
  CharacterItem(character: '信', romaji: 'shinjiru', meaningId: 'percaya'),
  CharacterItem(character: '疲', romaji: 'tsukareru', meaningId: 'lelah'),
  CharacterItem(character: '困', romaji: 'komaru', meaningId: 'kesulitan'),
  CharacterItem(character: '治', romaji: 'naoru', meaningId: 'sembuh'),

  // --- Kata kerja 7 ---
  CharacterItem(character: '起', romaji: 'okiru', meaningId: 'bangun'),
  CharacterItem(character: '寝', romaji: 'neru', meaningId: 'tidur'),
  CharacterItem(character: '座', romaji: 'suwaru', meaningId: 'duduk'),
  CharacterItem(character: '仕', romaji: 'shi', meaningId: 'bekerja / melayani'),

  // --- Kata benda abstrak ---
  CharacterItem(character: '物', romaji: 'mono', meaningId: 'benda'),
  CharacterItem(character: '事', romaji: 'koto', meaningId: 'hal / peristiwa'),
  CharacterItem(character: '方', romaji: 'kata', meaningId: 'cara / arah'),
  CharacterItem(character: '者', romaji: 'sha', meaningId: 'orang / pelaku'),
  CharacterItem(character: '用', romaji: 'you', meaningId: 'keperluan'),
  CharacterItem(character: '意', romaji: 'i', meaningId: 'maksud / niat'),
  CharacterItem(character: '味', romaji: 'aji', meaningId: 'rasa'),
  CharacterItem(character: '全', romaji: 'zen', meaningId: 'seluruh'),
  CharacterItem(character: '部', romaji: 'bu', meaningId: 'bagian'),
  CharacterItem(character: '番', romaji: 'ban', meaningId: 'nomor urut'),
  CharacterItem(character: '丈', romaji: 'jou', meaningId: 'ukuran panjang'),
  CharacterItem(character: '自', romaji: 'ji', meaningId: 'diri sendiri'),
  CharacterItem(character: '切', romaji: 'setsu', meaningId: 'potong / penting'),
  CharacterItem(character: '答', romaji: 'kotae', meaningId: 'jawaban'),
  CharacterItem(character: '問', romaji: 'tou', meaningId: 'pertanyaan / bertanya'),
  CharacterItem(character: '題', romaji: 'dai', meaningId: 'judul / topik'),

  // --- Sekolah & pekerjaan lanjutan ---
  CharacterItem(character: '漢', romaji: 'kan', meaningId: 'Tiongkok / Han'),
  CharacterItem(character: '文', romaji: 'bun', meaningId: 'kalimat / tulisan'),
  CharacterItem(character: '紙', romaji: 'kami', meaningId: 'kertas'),
  CharacterItem(character: '病', romaji: 'byou', meaningId: 'sakit'),
  CharacterItem(character: '薬', romaji: 'kusuri', meaningId: 'obat'),
  CharacterItem(character: '医', romaji: 'i', meaningId: 'dokter / pengobatan'),
  CharacterItem(character: '歯', romaji: 'ha', meaningId: 'gigi'),
  CharacterItem(character: '声', romaji: 'koe', meaningId: 'suara manusia'),

  // --- Tempat lanjutan ---
  CharacterItem(character: '院', romaji: 'in', meaningId: 'lembaga (rumah sakit dll)'),
  CharacterItem(character: '局', romaji: 'kyoku', meaningId: 'kantor (pos dll)'),
  CharacterItem(character: '銀', romaji: 'gin', meaningId: 'perak'),
  CharacterItem(character: '図', romaji: 'zu', meaningId: 'gambar / peta'),
  CharacterItem(character: '館', romaji: 'kan', meaningId: 'gedung'),
  CharacterItem(character: '室', romaji: 'shitsu', meaningId: 'ruangan'),

  // --- Kata benda lanjutan ---
  CharacterItem(character: '屋', romaji: 'ya', meaningId: 'toko / rumah'),
  CharacterItem(character: '場', romaji: 'ba', meaningId: 'tempat'),
  CharacterItem(character: '所', romaji: 'tokoro', meaningId: 'tempat'),
  CharacterItem(character: '族', romaji: 'zoku', meaningId: 'suku / keluarga'),
  CharacterItem(character: '台', romaji: 'dai', meaningId: 'meja / unit'),
  CharacterItem(character: '反', romaji: 'han', meaningId: 'lawan / anti'),
];