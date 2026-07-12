import 'character_item.dart';

/// Kumpulan kanji dasar setara JLPT N5-N4 (~243 karakter).
/// Setiap kanji dipetakan ke SATU bacaan latin yang paling umum diajarkan
/// pada level pemula (bisa kun'yomi atau on'yomi, tergantung mana yang
/// paling lazim dipakai berdiri sendiri). Urutan list disusun dari kanji
/// paling dasar (angka, waktu, orang) menuju kanji yang lebih abstrak,
/// mengikuti pola kesulitan JLPT N5 -> N4.
const List<CharacterItem> kKanjiData = [
  // --- Angka dasar ---
  CharacterItem(character: '一', romaji: 'ichi'),
  CharacterItem(character: '二', romaji: 'ni'),
  CharacterItem(character: '三', romaji: 'san'),
  CharacterItem(character: '四', romaji: 'yon'),
  CharacterItem(character: '五', romaji: 'go'),
  CharacterItem(character: '六', romaji: 'roku'),
  CharacterItem(character: '七', romaji: 'nana'),
  CharacterItem(character: '八', romaji: 'hachi'),
  CharacterItem(character: '九', romaji: 'kyuu'),
  CharacterItem(character: '十', romaji: 'juu'),
  CharacterItem(character: '百', romaji: 'hyaku'),
  CharacterItem(character: '千', romaji: 'sen'),
  CharacterItem(character: '万', romaji: 'man'),

  // --- Waktu & kalender ---
  CharacterItem(character: '円', romaji: 'en'),
  CharacterItem(character: '年', romaji: 'toshi'),
  CharacterItem(character: '月', romaji: 'tsuki'),
  CharacterItem(character: '日', romaji: 'hi'),
  CharacterItem(character: '時', romaji: 'toki'),
  CharacterItem(character: '分', romaji: 'fun'),
  CharacterItem(character: '半', romaji: 'han'),
  CharacterItem(character: '週', romaji: 'shuu'),
  CharacterItem(character: '曜', romaji: 'you'),
  CharacterItem(character: '今', romaji: 'ima'),

  // --- Orang & keluarga ---
  CharacterItem(character: '人', romaji: 'hito'),
  CharacterItem(character: '男', romaji: 'otoko'),
  CharacterItem(character: '女', romaji: 'onna'),
  CharacterItem(character: '子', romaji: 'ko'),
  CharacterItem(character: '父', romaji: 'chichi'),
  CharacterItem(character: '母', romaji: 'haha'),
  CharacterItem(character: '友', romaji: 'tomo'),
  CharacterItem(character: '先', romaji: 'saki'),
  CharacterItem(character: '生', romaji: 'sei'),
  CharacterItem(character: '私', romaji: 'watashi'),
  CharacterItem(character: '兄', romaji: 'ani'),
  CharacterItem(character: '姉', romaji: 'ane'),
  CharacterItem(character: '弟', romaji: 'otouto'),
  CharacterItem(character: '妹', romaji: 'imouto'),

  // --- Sekolah & tempat umum ---
  CharacterItem(character: '学', romaji: 'gaku'),
  CharacterItem(character: '校', romaji: 'kou'),
  CharacterItem(character: '名', romaji: 'na'),
  CharacterItem(character: '前', romaji: 'mae'),
  CharacterItem(character: '後', romaji: 'ushiro'),
  CharacterItem(character: '中', romaji: 'naka'),
  CharacterItem(character: '外', romaji: 'soto'),
  CharacterItem(character: '何', romaji: 'nani'),

  // --- Arah & posisi ---
  CharacterItem(character: '上', romaji: 'ue'),
  CharacterItem(character: '下', romaji: 'shita'),
  CharacterItem(character: '左', romaji: 'hidari'),
  CharacterItem(character: '右', romaji: 'migi'),
  CharacterItem(character: '北', romaji: 'kita'),
  CharacterItem(character: '南', romaji: 'minami'),
  CharacterItem(character: '東', romaji: 'higashi'),
  CharacterItem(character: '西', romaji: 'nishi'),

  // --- Bahasa & tulisan ---
  CharacterItem(character: '本', romaji: 'hon'),
  CharacterItem(character: '語', romaji: 'go'),
  CharacterItem(character: '話', romaji: 'hanashi'),
  CharacterItem(character: '字', romaji: 'ji'),

  // --- Kata kerja dasar 1 ---
  CharacterItem(character: '読', romaji: 'yomu'),
  CharacterItem(character: '書', romaji: 'kaku'),
  CharacterItem(character: '聞', romaji: 'kiku'),
  CharacterItem(character: '見', romaji: 'miru'),
  CharacterItem(character: '食', romaji: 'taberu'),
  CharacterItem(character: '飲', romaji: 'nomu'),
  CharacterItem(character: '行', romaji: 'iku'),
  CharacterItem(character: '来', romaji: 'kuru'),
  CharacterItem(character: '帰', romaji: 'kaeru'),
  CharacterItem(character: '出', romaji: 'deru'),
  CharacterItem(character: '入', romaji: 'hairu'),
  CharacterItem(character: '立', romaji: 'tatsu'),

  // --- Kata kerja dasar 2 ---
  CharacterItem(character: '休', romaji: 'yasumu'),
  CharacterItem(character: '買', romaji: 'kau'),
  CharacterItem(character: '売', romaji: 'uru'),
  CharacterItem(character: '待', romaji: 'matsu'),
  CharacterItem(character: '会', romaji: 'au'),
  CharacterItem(character: '言', romaji: 'iu'),
  CharacterItem(character: '思', romaji: 'omou'),
  CharacterItem(character: '知', romaji: 'shiru'),
  CharacterItem(character: '道', romaji: 'michi'),
  CharacterItem(character: '車', romaji: 'kuruma'),

  // --- Tempat ---
  CharacterItem(character: '駅', romaji: 'eki'),
  CharacterItem(character: '店', romaji: 'mise'),
  CharacterItem(character: '社', romaji: 'sha'),
  CharacterItem(character: '家', romaji: 'ie'),
  CharacterItem(character: '国', romaji: 'kuni'),
  CharacterItem(character: '町', romaji: 'machi'),
  CharacterItem(character: '村', romaji: 'mura'),
  CharacterItem(character: '山', romaji: 'yama'),
  CharacterItem(character: '川', romaji: 'kawa'),
  CharacterItem(character: '海', romaji: 'umi'),

  // --- Alam 1 ---
  CharacterItem(character: '天', romaji: 'ten'),
  CharacterItem(character: '気', romaji: 'ki'),
  CharacterItem(character: '雨', romaji: 'ame'),
  CharacterItem(character: '雪', romaji: 'yuki'),
  CharacterItem(character: '花', romaji: 'hana'),
  CharacterItem(character: '木', romaji: 'ki'),
  CharacterItem(character: '空', romaji: 'sora'),
  CharacterItem(character: '星', romaji: 'hoshi'),
  CharacterItem(character: '風', romaji: 'kaze'),
  CharacterItem(character: '雲', romaji: 'kumo'),

  // --- Alam 2 ---
  CharacterItem(character: '光', romaji: 'hikari'),
  CharacterItem(character: '音', romaji: 'oto'),
  CharacterItem(character: '地', romaji: 'chi'),
  CharacterItem(character: '森', romaji: 'mori'),
  CharacterItem(character: '林', romaji: 'hayashi'),
  CharacterItem(character: '池', romaji: 'ike'),
  CharacterItem(character: '石', romaji: 'ishi'),

  // --- Warna & tubuh ---
  CharacterItem(character: '赤', romaji: 'aka'),
  CharacterItem(character: '青', romaji: 'ao'),
  CharacterItem(character: '白', romaji: 'shiro'),
  CharacterItem(character: '黒', romaji: 'kuro'),
  CharacterItem(character: '色', romaji: 'iro'),
  CharacterItem(character: '頭', romaji: 'atama'),
  CharacterItem(character: '顔', romaji: 'kao'),
  CharacterItem(character: '目', romaji: 'me'),
  CharacterItem(character: '耳', romaji: 'mimi'),
  CharacterItem(character: '口', romaji: 'kuchi'),
  CharacterItem(character: '手', romaji: 'te'),
  CharacterItem(character: '足', romaji: 'ashi'),
  CharacterItem(character: '体', romaji: 'karada'),
  CharacterItem(character: '心', romaji: 'kokoro'),

  // ============ Tingkat N4 (lebih abstrak) ============

  // --- Kata sifat 1 ---
  CharacterItem(character: '古', romaji: 'furui'),
  CharacterItem(character: '新', romaji: 'atarashii'),
  CharacterItem(character: '大', romaji: 'dai'),
  CharacterItem(character: '小', romaji: 'shou'),
  CharacterItem(character: '高', romaji: 'takai'),
  CharacterItem(character: '安', romaji: 'yasui'),
  CharacterItem(character: '多', romaji: 'ooi'),
  CharacterItem(character: '少', romaji: 'sukunai'),
  CharacterItem(character: '長', romaji: 'nagai'),
  CharacterItem(character: '短', romaji: 'mijikai'),
  CharacterItem(character: '早', romaji: 'hayai'),
  CharacterItem(character: '明', romaji: 'akarui'),

  // --- Kata sifat 2 ---
  CharacterItem(character: '暗', romaji: 'kurai'),
  CharacterItem(character: '広', romaji: 'hiroi'),
  CharacterItem(character: '重', romaji: 'omoi'),
  CharacterItem(character: '軽', romaji: 'karui'),
  CharacterItem(character: '強', romaji: 'tsuyoi'),
  CharacterItem(character: '弱', romaji: 'yowai'),
  CharacterItem(character: '暑', romaji: 'atsui'),
  CharacterItem(character: '寒', romaji: 'samui'),
  CharacterItem(character: '冷', romaji: 'tsumetai'),
  CharacterItem(character: '忙', romaji: 'isogashii'),

  // --- Kata sifat 3 ---
  CharacterItem(character: '好', romaji: 'suki'),
  CharacterItem(character: '悪', romaji: 'warui'),
  CharacterItem(character: '同', romaji: 'onaji'),
  CharacterItem(character: '違', romaji: 'chigau'),
  CharacterItem(character: '若', romaji: 'wakai'),
  CharacterItem(character: '太', romaji: 'futoi'),
  CharacterItem(character: '細', romaji: 'hosoi'),
  CharacterItem(character: '深', romaji: 'fukai'),
  CharacterItem(character: '浅', romaji: 'asai'),
  CharacterItem(character: '汚', romaji: 'kitanai'),

  // --- Kata sifat 4 ---
  CharacterItem(character: '美', romaji: 'utsukushii'),
  CharacterItem(character: '危', romaji: 'abunai'),
  CharacterItem(character: '便', romaji: 'benri'),
  CharacterItem(character: '有', romaji: 'yuu'),
  CharacterItem(character: '特', romaji: 'toku'),
  CharacterItem(character: '必', romaji: 'hitsu'),

  // --- Kata kerja 3 ---
  CharacterItem(character: '使', romaji: 'tsukau'),
  CharacterItem(character: '作', romaji: 'tsukuru'),
  CharacterItem(character: '持', romaji: 'motsu'),
  CharacterItem(character: '働', romaji: 'hataraku'),
  CharacterItem(character: '歩', romaji: 'aruku'),
  CharacterItem(character: '走', romaji: 'hashiru'),
  CharacterItem(character: '止', romaji: 'tomaru'),
  CharacterItem(character: '開', romaji: 'hiraku'),
  CharacterItem(character: '閉', romaji: 'shimeru'),
  CharacterItem(character: '教', romaji: 'oshieru'),
  CharacterItem(character: '習', romaji: 'narau'),
  CharacterItem(character: '覚', romaji: 'oboeru'),

  // --- Kata kerja 4 ---
  CharacterItem(character: '忘', romaji: 'wasureru'),
  CharacterItem(character: '考', romaji: 'kangaeru'),
  CharacterItem(character: '始', romaji: 'hajimaru'),
  CharacterItem(character: '終', romaji: 'owaru'),
  CharacterItem(character: '着', romaji: 'kiru'),
  CharacterItem(character: '洗', romaji: 'arau'),
  CharacterItem(character: '死', romaji: 'shinu'),
  CharacterItem(character: '泳', romaji: 'oyogu'),
  CharacterItem(character: '飛', romaji: 'tobu'),
  CharacterItem(character: '乗', romaji: 'noru'),
  CharacterItem(character: '降', romaji: 'oriru'),
  CharacterItem(character: '渡', romaji: 'wataru'),

  // --- Kata kerja 5 ---
  CharacterItem(character: '通', romaji: 'tooru'),
  CharacterItem(character: '曲', romaji: 'magaru'),
  CharacterItem(character: '貸', romaji: 'kasu'),
  CharacterItem(character: '借', romaji: 'kariru'),
  CharacterItem(character: '返', romaji: 'kaesu'),
  CharacterItem(character: '送', romaji: 'okuru'),
  CharacterItem(character: '運', romaji: 'hakobu'),
  CharacterItem(character: '集', romaji: 'atsumeru'),
  CharacterItem(character: '決', romaji: 'kimeru'),
  CharacterItem(character: '選', romaji: 'erabu'),
  CharacterItem(character: '続', romaji: 'tsuzukeru'),
  CharacterItem(character: '比', romaji: 'kuraberu'),

  // --- Kata kerja 6 ---
  CharacterItem(character: '育', romaji: 'sodateru'),
  CharacterItem(character: '泣', romaji: 'naku'),
  CharacterItem(character: '笑', romaji: 'warau'),
  CharacterItem(character: '怒', romaji: 'okoru'),
  CharacterItem(character: '願', romaji: 'negau'),
  CharacterItem(character: '信', romaji: 'shinjiru'),
  CharacterItem(character: '疲', romaji: 'tsukareru'),
  CharacterItem(character: '困', romaji: 'komaru'),
  CharacterItem(character: '治', romaji: 'naoru'),

  // --- Kata kerja 7 ---
  CharacterItem(character: '起', romaji: 'okiru'),
  CharacterItem(character: '寝', romaji: 'neru'),
  CharacterItem(character: '座', romaji: 'suwaru'),
  CharacterItem(character: '仕', romaji: 'shi'),

  // --- Kata benda abstrak ---
  CharacterItem(character: '物', romaji: 'mono'),
  CharacterItem(character: '事', romaji: 'koto'),
  CharacterItem(character: '方', romaji: 'kata'),
  CharacterItem(character: '者', romaji: 'sha'),
  CharacterItem(character: '用', romaji: 'you'),
  CharacterItem(character: '意', romaji: 'i'),
  CharacterItem(character: '味', romaji: 'aji'),
  CharacterItem(character: '全', romaji: 'zen'),
  CharacterItem(character: '部', romaji: 'bu'),
  CharacterItem(character: '番', romaji: 'ban'),
  CharacterItem(character: '丈', romaji: 'jou'),
  CharacterItem(character: '自', romaji: 'ji'),
  CharacterItem(character: '切', romaji: 'setsu'),
  CharacterItem(character: '答', romaji: 'kotae'),
  CharacterItem(character: '問', romaji: 'tou'),
  CharacterItem(character: '題', romaji: 'dai'),

  // --- Sekolah & pekerjaan lanjutan ---
  CharacterItem(character: '漢', romaji: 'kan'),
  CharacterItem(character: '文', romaji: 'bun'),
  CharacterItem(character: '紙', romaji: 'kami'),
  CharacterItem(character: '病', romaji: 'byou'),
  CharacterItem(character: '薬', romaji: 'kusuri'),
  CharacterItem(character: '医', romaji: 'i'),
  CharacterItem(character: '歯', romaji: 'ha'),
  CharacterItem(character: '声', romaji: 'koe'),

  // --- Tempat lanjutan ---
  CharacterItem(character: '院', romaji: 'in'),
  CharacterItem(character: '局', romaji: 'kyoku'),
  CharacterItem(character: '銀', romaji: 'gin'),
  CharacterItem(character: '図', romaji: 'zu'),
  CharacterItem(character: '館', romaji: 'kan'),
  CharacterItem(character: '室', romaji: 'shitsu'),

  // --- Kata benda lanjutan ---
  CharacterItem(character: '屋', romaji: 'ya'),
  CharacterItem(character: '場', romaji: 'ba'),
  CharacterItem(character: '所', romaji: 'tokoro'),
  CharacterItem(character: '族', romaji: 'zoku'),
  CharacterItem(character: '台', romaji: 'dai'),
  CharacterItem(character: '反', romaji: 'han'),
];
