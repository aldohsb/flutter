// Hiragana & Katakana Data
class JapaneseAksaraData {
  // Level 1-5: a, i, u, e, o, ka, ki, ku, ke, ko
  // Level 6-10: sa, si, su, se, so
  // dst...

  static final Map<int, List<String>> hiraganaByLevel = {
    // Level 1-5: a, i, u, e, o, ka, ki, ku, ke, ko
    1: ['あ', 'い', 'う', 'え', 'お'],
    2: ['あ', 'い', 'う', 'え', 'お', 'か', 'き'],
    3: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く'],
    4: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け'],
    5: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ'],
    
    // Level 6-10: sa-so
    6: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ'],
    7: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し'],
    8: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す'],
    9: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ'],
    10: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ'],
    
    // Level 11-15: ta-to
    11: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た'],
    12: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち'],
    13: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ'],
    14: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て'],
    15: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と'],
    
    // Level 16-20: na-no
    16: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な'],
    17: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 'に'],
    18: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 'に', 'ぬ'],
    19: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 'に', 'ぬ', 'ね'],
    20: ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 'に', 'ぬ', 'ね', 'の'],
  };

  static final Map<String, String> hiraganaMap = {
    'あ': 'a', 'い': 'i', 'う': 'u', 'え': 'e', 'お': 'o',
    'か': 'ka', 'き': 'ki', 'く': 'ku', 'け': 'ke', 'こ': 'ko',
    'さ': 'sa', 'し': 'si', 'す': 'su', 'せ': 'se', 'そ': 'so',
    'た': 'ta', 'ち': 'ti', 'つ': 'tu', 'て': 'te', 'と': 'to',
    'な': 'na', 'に': 'ni', 'ぬ': 'nu', 'ね': 'ne', 'の': 'no',
    'は': 'ha', 'ひ': 'hi', 'ふ': 'hu', 'へ': 'he', 'ほ': 'ho',
    'ま': 'ma', 'み': 'mi', 'む': 'mu', 'め': 'me', 'も': 'mo',
    'や': 'ya', 'ゆ': 'yu', 'よ': 'yo',
    'ら': 'ra', 'り': 'ri', 'る': 'ru', 'れ': 're', 'ろ': 'ro',
    'わ': 'wa', 'を': 'wo', 'ん': 'n',
  };

  static final Map<String, String> katakanaMap = {
    'ア': 'a', 'イ': 'i', 'ウ': 'u', 'エ': 'e', 'オ': 'o',
    'カ': 'ka', 'キ': 'ki', 'ク': 'ku', 'ケ': 'ke', 'コ': 'ko',
    'サ': 'sa', 'シ': 'si', 'ス': 'su', 'セ': 'se', 'ソ': 'so',
    'タ': 'ta', 'チ': 'ti', 'ツ': 'tu', 'テ': 'te', 'ト': 'to',
    'ナ': 'na', 'ニ': 'ni', 'ヌ': 'nu', 'ネ': 'ne', 'ノ': 'no',
    'ハ': 'ha', 'ヒ': 'hi', 'フ': 'hu', 'ヘ': 'he', 'ホ': 'ho',
    'マ': 'ma', 'ミ': 'mi', 'ム': 'mu', 'メ': 'me', 'モ': 'mo',
    'ヤ': 'ya', 'ユ': 'yu', 'ヨ': 'yo',
    'ラ': 'ra', 'リ': 'ri', 'ル': 'ru', 'レ': 're', 'ロ': 'ro',
    'ワ': 'wa', 'ヲ': 'wo', 'ン': 'n',
  };

  // JLPT N5 Kanji (simplified, 103 kanji dasar)
  static final Map<String, String> kanjiJLPTN5 = {
    '人': 'hito', '日': 'hi', '月': 'tsuki', '火': 'hi', '水': 'mizu',
    '木': 'ki', '金': 'kin', '土': 'tsuchi', '山': 'yama', '川': 'kawa',
    '田': 'ta', '目': 'me', '口': 'kuchi', '手': 'te', '足': 'ashi',
    '心': 'kokoro', '力': 'chikara', '父': 'chichi', '母': 'haha', '兄': 'ani',
    '弟': 'ototo', '子': 'ko', '女': 'onna', '男': 'otoko', '大': 'ookii',
    '小': 'chiisai', '長': 'naga', '短': 'mijika', '高': 'taka', '低': 'hiku',
    '多': 'ooi', '少': 'sukunai', '新': 'atarashii', '古': 'furui', '好': 'suki',
    '悪': 'warui', '美': 'utsukushii', '醜': 'minikui', '黒': 'kuro', '白': 'shiro',
    '赤': 'aka', '青': 'ao', '黄': 'ki', '緑': 'midori', '色': 'iro',
    '上': 'ue', '下': 'shita', '左': 'hidari', '右': 'migi', '中': 'naka',
    '前': 'mae', '後': 'ushiro', '外': 'soto', '内': 'uchi', '東': 'higashi',
    '西': 'nishi', '南': 'minami', '北': 'kita', '朝': 'asa', '昼': 'hiru',
    '夜': 'yoru', '春': 'haru', '夏': 'natsu', '秋': 'aki', '冬': 'fuyu',
    '一': 'ichi', '二': 'ni', '三': 'san', '四': 'shi', '五': 'go',
    '六': 'roku', '七': 'shichi', '八': 'hachi', '九': 'kyu', '十': 'ju',
    '百': 'hyaku', '千': 'sen', '万': 'man', '円': 'en', '年': 'toshi',
    '月': 'gatsu', '日': 'nichi', '週': 'shuu', '時': 'ji', '分': 'fun',
    '秒': 'byou', '昨': 'saku', '今': 'ima', '明': 'asu', '来': 'kuru',
  };

  // Get aksara untuk level tertentu
  static List<String> getHiraganaForLevel(int level) {
    return hiraganaByLevel[level] ?? [];
  }

  static List<String> getKatakanaForLevel(int level) {
    // Katakana mengikuti pola yang sama, hanya ganti huruf
    final hiraganaList = getHiraganaForLevel(level - 40);
    return hiraganaList.map((h) {
      // Convert hiragana to katakana
      return _hiraganaToKatakana(h);
    }).toList();
  }

  static String _hiraganaToKatakana(String hiragana) {
    const hiraganaStr = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをん';
    const katakanaStr = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン';
    
    int index = hiraganaStr.indexOf(hiragana);
    if (index >= 0) {
      return katakanaStr[index];
    }
    return hiragana;
  }
}