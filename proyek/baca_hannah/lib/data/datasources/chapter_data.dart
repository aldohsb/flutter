// lib/data/datasources/chapter_data.dart
// 80 Bab lengkap — baca_hannah
//
// colorIndex → AppColors.syllableColors[index % 8]:
//   0 = merah coral   (suku kata baru pertama)
//   1 = teal          (suku kata baru kedua)
//   2 = kuning        (vokal lepas / netral)
//   3 = hijau         (warisan bab sebelumnya)
//   4 = oranye        (warisan bab sebelumnya)
//   5 = ungu muda     (warisan bab sebelumnya)
//   6 = pink          (warisan bab sebelumnya)
//   7 = cyan          (warisan bab sebelumnya)
//
// 3 halaman TERAKHIR tiap bab = halaman REVIEW (semua suku kata 1 warna)

import '../models/chapter_model.dart';
import '../models/page_model.dart';

SyllableItem _s(String t, int c) => SyllableItem(text: t, colorIndex: c);
ReadingPage  _p(int n, List<SyllableItem> s) => ReadingPage(pageNumber: n, syllables: s);

// ══════════════════════════════════════════════════════════════
// FASE 1 — VOKAL "A"  (Bab 1–10)
// ══════════════════════════════════════════════════════════════

// ── BAB 1 : ba · ca ──────────────────────────────────────────
final _b1 = <ReadingPage>[
  _p(1,  [_s('ba',0)]),
  _p(2,  [_s('ca',1)]),
  _p(3,  [_s('ba',0),_s('ba',0)]),
  _p(4,  [_s('ca',1),_s('ca',1)]),
  _p(5,  [_s('ba',0),_s('ca',1)]),
  _p(6,  [_s('ca',1),_s('ba',0)]),
  _p(7,  [_s('a',2), _s('ba',0)]),
  _p(8,  [_s('ba',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('ca',1)]),
  _p(10, [_s('ca',1),_s('a',2)]),
  _p(11, [_s('ba',0),_s('ba',0),_s('ba',0)]),
  _p(12, [_s('ca',1),_s('ca',1),_s('ca',1)]),
  _p(13, [_s('ba',0),_s('ca',1),_s('ba',0)]),
  _p(14, [_s('ca',1),_s('ba',0),_s('ca',1)]),
  _p(15, [_s('a',2), _s('ba',0),_s('a',2)]),
  _p(16, [_s('ba',0),_s('ca',1)]),
  _p(17, [_s('ca',1),_s('ba',0)]),
  _p(18, [_s('a',2), _s('ba',0),_s('ca',1)]),
  _p(19, [_s('ba',0),_s('ba',0),_s('ca',1)]),
  _p(20, [_s('ca',1),_s('ba',0),_s('a',2)]),
  _p(21, [_s('ba',0),_s('a',2), _s('ca',1)]),
  _p(22, [_s('a',2), _s('ca',1),_s('ba',0)]),
  _p(23, [_s('ca',1),_s('a',2), _s('ba',0)]),
  _p(24, [_s('ba',0),_s('ca',1),_s('ca',1)]),
  _p(25, [_s('ca',1),_s('ca',1),_s('ba',0)]),
  // review 1 warna
  _p(26, [_s('ba',0),_s('ca',0)]),
  _p(27, [_s('ba',0),_s('ca',0),_s('ba',0)]),
  _p(28, [_s('ca',0),_s('ba',0),_s('ca',0)]),
];

// ── BAB 2 : da · fa ──────────────────────────────────────────
final _b2 = <ReadingPage>[
  _p(1,  [_s('da',0)]),
  _p(2,  [_s('fa',1)]),
  _p(3,  [_s('da',0),_s('da',0)]),
  _p(4,  [_s('fa',1),_s('fa',1)]),
  _p(5,  [_s('da',0),_s('fa',1)]),
  _p(6,  [_s('fa',1),_s('da',0)]),
  _p(7,  [_s('a',2), _s('da',0)]),
  _p(8,  [_s('da',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('fa',1)]),
  _p(10, [_s('fa',1),_s('a',2)]),
  _p(11, [_s('ba',3),_s('da',0)]),
  _p(12, [_s('da',0),_s('ba',3)]),
  _p(13, [_s('ca',4),_s('da',0)]),
  _p(14, [_s('da',0),_s('ca',4)]),
  _p(15, [_s('ba',3),_s('fa',1)]),
  _p(16, [_s('fa',1),_s('ba',3)]),
  _p(17, [_s('da',0),_s('fa',1),_s('da',0)]),
  _p(18, [_s('fa',1),_s('da',0),_s('fa',1)]),
  _p(19, [_s('ba',3),_s('da',0),_s('fa',1)]),
  _p(20, [_s('fa',1),_s('ba',3),_s('ca',4)]),
  _p(21, [_s('ca',4),_s('da',0),_s('ba',3)]),
  _p(22, [_s('a',2), _s('fa',1),_s('da',0)]),
  _p(23, [_s('da',0),_s('ba',3),_s('fa',1)]),
  _p(24, [_s('ba',3),_s('ca',4),_s('da',0)]),
  _p(25, [_s('fa',1),_s('ca',4),_s('ba',3)]),
  _p(26, [_s('ca',4),_s('fa',1),_s('da',0)]),
  _p(27, [_s('da',0),_s('ca',4),_s('fa',1)]),
  // review
  _p(28, [_s('da',1),_s('fa',1)]),
  _p(29, [_s('fa',1),_s('da',1),_s('fa',1)]),
  _p(30, [_s('da',1),_s('fa',1),_s('da',1)]),
];

// ── BAB 3 : ga · ha ──────────────────────────────────────────
final _b3 = <ReadingPage>[
  _p(1,  [_s('ga',0)]),
  _p(2,  [_s('ha',1)]),
  _p(3,  [_s('ga',0),_s('ga',0)]),
  _p(4,  [_s('ha',1),_s('ha',1)]),
  _p(5,  [_s('ga',0),_s('ha',1)]),
  _p(6,  [_s('ha',1),_s('ga',0)]),
  _p(7,  [_s('a',2), _s('ga',0)]),
  _p(8,  [_s('ga',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('ha',1)]),
  _p(10, [_s('ha',1),_s('a',2)]),
  _p(11, [_s('ba',3),_s('ga',0)]),
  _p(12, [_s('ga',0),_s('ba',3)]),
  _p(13, [_s('ca',4),_s('ha',1)]),
  _p(14, [_s('ha',1),_s('ca',4)]),
  _p(15, [_s('da',5),_s('ga',0)]),
  _p(16, [_s('ga',0),_s('da',5)]),
  _p(17, [_s('fa',6),_s('ha',1)]),
  _p(18, [_s('ha',1),_s('fa',6)]),
  _p(19, [_s('ga',0),_s('ha',1),_s('ga',0)]),
  _p(20, [_s('ha',1),_s('ga',0),_s('ha',1)]),
  _p(21, [_s('ba',3),_s('ga',0),_s('da',5)]),
  _p(22, [_s('ha',1),_s('ba',3),_s('ca',4)]),
  _p(23, [_s('ga',0),_s('ca',4),_s('ha',1)]),
  _p(24, [_s('da',5),_s('ha',1),_s('ba',3)]),
  _p(25, [_s('fa',6),_s('ga',0),_s('ca',4)]),
  _p(26, [_s('ca',4),_s('ga',0),_s('ha',1)]),
  _p(27, [_s('ha',1),_s('da',5),_s('ga',0)]),
  _p(28, [_s('ba',3),_s('ha',1),_s('ga',0)]),
  // review
  _p(29, [_s('ga',2),_s('ha',2)]),
  _p(30, [_s('ha',2),_s('ga',2),_s('ha',2)]),
  _p(31, [_s('ga',2),_s('ha',2),_s('ga',2)]),
];

// ── BAB 4 : ja · ka ──────────────────────────────────────────
final _b4 = <ReadingPage>[
  _p(1,  [_s('ja',0)]),
  _p(2,  [_s('ka',1)]),
  _p(3,  [_s('ja',0),_s('ja',0)]),
  _p(4,  [_s('ka',1),_s('ka',1)]),
  _p(5,  [_s('ja',0),_s('ka',1)]),
  _p(6,  [_s('ka',1),_s('ja',0)]),
  _p(7,  [_s('a',2), _s('ja',0)]),
  _p(8,  [_s('ja',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('ka',1)]),
  _p(10, [_s('ka',1),_s('a',2)]),
  _p(11, [_s('ba',3),_s('ja',0)]),
  _p(12, [_s('ka',1),_s('da',4)]),
  _p(13, [_s('ga',5),_s('ja',0)]),
  _p(14, [_s('ha',6),_s('ka',1)]),
  _p(15, [_s('ca',3),_s('ka',1)]),
  _p(16, [_s('ja',0),_s('ga',5)]),
  _p(17, [_s('ja',0),_s('ka',1),_s('ja',0)]),
  _p(18, [_s('ka',1),_s('ja',0),_s('ka',1)]),
  _p(19, [_s('ba',3),_s('ja',0),_s('ka',1)]),
  _p(20, [_s('ka',1),_s('ga',5),_s('ha',6)]),
  _p(21, [_s('da',4),_s('ka',1),_s('ba',3)]),
  _p(22, [_s('ja',0),_s('ba',3),_s('ga',5)]),
  _p(23, [_s('ha',6),_s('ja',0),_s('ca',3)]),
  _p(24, [_s('ka',1),_s('fa',7),_s('ja',0)]),
  _p(25, [_s('ja',0),_s('da',4),_s('ka',1)]),
  // review
  _p(26, [_s('ja',0),_s('ka',0)]),
  _p(27, [_s('ka',0),_s('ja',0),_s('ka',0)]),
  _p(28, [_s('ja',0),_s('ka',0),_s('ja',0)]),
];

// ── BAB 5 : la · ma ──────────────────────────────────────────
final _b5 = <ReadingPage>[
  _p(1,  [_s('la',0)]),
  _p(2,  [_s('ma',1)]),
  _p(3,  [_s('la',0),_s('la',0)]),
  _p(4,  [_s('ma',1),_s('ma',1)]),
  _p(5,  [_s('la',0),_s('ma',1)]),
  _p(6,  [_s('ma',1),_s('la',0)]),
  _p(7,  [_s('a',2), _s('la',0)]),
  _p(8,  [_s('la',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('ma',1)]),
  _p(10, [_s('ma',1),_s('a',2)]),
  _p(11, [_s('ba',3),_s('la',0)]),
  _p(12, [_s('la',0),_s('ka',4)]),
  _p(13, [_s('da',5),_s('ma',1)]),
  _p(14, [_s('ma',1),_s('ga',6)]),
  _p(15, [_s('ja',7),_s('la',0)]),
  _p(16, [_s('la',0),_s('ma',1),_s('la',0)]),
  _p(17, [_s('ma',1),_s('la',0),_s('ma',1)]),
  _p(18, [_s('ba',3),_s('la',0),_s('ma',1)]),
  _p(19, [_s('ka',4),_s('ma',1),_s('la',0)]),
  _p(20, [_s('la',0),_s('da',5),_s('ma',1)]),
  _p(21, [_s('ma',1),_s('ja',7),_s('la',0)]),
  _p(22, [_s('ga',6),_s('la',0),_s('ba',3)]),
  _p(23, [_s('la',0),_s('ha',6),_s('ma',1)]),
  _p(24, [_s('ma',1),_s('ca',3),_s('la',0)]),
  _p(25, [_s('la',0),_s('fa',5),_s('ma',1)]),
  // review
  _p(26, [_s('la',1),_s('ma',1)]),
  _p(27, [_s('ma',1),_s('la',1),_s('ma',1)]),
  _p(28, [_s('la',1),_s('ma',1),_s('la',1)]),
];

// ── BAB 6 : na · pa ──────────────────────────────────────────
final _b6 = <ReadingPage>[
  _p(1,  [_s('na',0)]),
  _p(2,  [_s('pa',1)]),
  _p(3,  [_s('na',0),_s('na',0)]),
  _p(4,  [_s('pa',1),_s('pa',1)]),
  _p(5,  [_s('na',0),_s('pa',1)]),
  _p(6,  [_s('pa',1),_s('na',0)]),
  _p(7,  [_s('a',2), _s('na',0)]),
  _p(8,  [_s('na',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('pa',1)]),
  _p(10, [_s('pa',1),_s('a',2)]),
  _p(11, [_s('ma',3),_s('na',0)]),
  _p(12, [_s('pa',1),_s('la',4)]),
  _p(13, [_s('ba',5),_s('na',0)]),
  _p(14, [_s('pa',1),_s('da',6)]),
  _p(15, [_s('ka',7),_s('na',0)]),
  _p(16, [_s('na',0),_s('pa',1),_s('na',0)]),
  _p(17, [_s('pa',1),_s('na',0),_s('pa',1)]),
  _p(18, [_s('ma',3),_s('na',0),_s('pa',1)]),
  _p(19, [_s('la',4),_s('pa',1),_s('na',0)]),
  _p(20, [_s('na',0),_s('ba',5),_s('pa',1)]),
  _p(21, [_s('pa',1),_s('ka',7),_s('na',0)]),
  _p(22, [_s('da',6),_s('na',0),_s('ma',3)]),
  _p(23, [_s('na',0),_s('ga',3),_s('pa',1)]),
  _p(24, [_s('pa',1),_s('ha',5),_s('na',0)]),
  _p(25, [_s('na',0),_s('ja',7),_s('pa',1)]),
  // review
  _p(26, [_s('na',0),_s('pa',0)]),
  _p(27, [_s('pa',0),_s('na',0),_s('pa',0)]),
  _p(28, [_s('na',0),_s('pa',0),_s('na',0)]),
];

// ── BAB 7 : ra · sa ──────────────────────────────────────────
final _b7 = <ReadingPage>[
  _p(1,  [_s('ra',0)]),
  _p(2,  [_s('sa',1)]),
  _p(3,  [_s('ra',0),_s('ra',0)]),
  _p(4,  [_s('sa',1),_s('sa',1)]),
  _p(5,  [_s('ra',0),_s('sa',1)]),
  _p(6,  [_s('sa',1),_s('ra',0)]),
  _p(7,  [_s('a',2), _s('ra',0)]),
  _p(8,  [_s('ra',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('sa',1)]),
  _p(10, [_s('sa',1),_s('a',2)]),
  _p(11, [_s('na',3),_s('ra',0)]),
  _p(12, [_s('sa',1),_s('pa',4)]),
  _p(13, [_s('ma',5),_s('ra',0)]),
  _p(14, [_s('sa',1),_s('la',6)]),
  _p(15, [_s('ba',7),_s('ra',0)]),
  _p(16, [_s('ra',0),_s('sa',1),_s('ra',0)]),
  _p(17, [_s('sa',1),_s('ra',0),_s('sa',1)]),
  _p(18, [_s('na',3),_s('ra',0),_s('sa',1)]),
  _p(19, [_s('pa',4),_s('sa',1),_s('ra',0)]),
  _p(20, [_s('ra',0),_s('ma',5),_s('sa',1)]),
  _p(21, [_s('sa',1),_s('ba',7),_s('ra',0)]),
  _p(22, [_s('la',6),_s('ra',0),_s('na',3)]),
  _p(23, [_s('ra',0),_s('ka',5),_s('sa',1)]),
  _p(24, [_s('sa',1),_s('da',4),_s('ra',0)]),
  _p(25, [_s('ra',0),_s('ga',3),_s('sa',1)]),
  // review
  _p(26, [_s('ra',1),_s('sa',1)]),
  _p(27, [_s('sa',1),_s('ra',1),_s('sa',1)]),
  _p(28, [_s('ra',1),_s('sa',1),_s('ra',1)]),
];

// ── BAB 8 : ta · wa ──────────────────────────────────────────
final _b8 = <ReadingPage>[
  _p(1,  [_s('ta',0)]),
  _p(2,  [_s('wa',1)]),
  _p(3,  [_s('ta',0),_s('ta',0)]),
  _p(4,  [_s('wa',1),_s('wa',1)]),
  _p(5,  [_s('ta',0),_s('wa',1)]),
  _p(6,  [_s('wa',1),_s('ta',0)]),
  _p(7,  [_s('a',2), _s('ta',0)]),
  _p(8,  [_s('ta',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('wa',1)]),
  _p(10, [_s('wa',1),_s('a',2)]),
  _p(11, [_s('sa',3),_s('ta',0)]),
  _p(12, [_s('wa',1),_s('ra',4)]),
  _p(13, [_s('na',5),_s('ta',0)]),
  _p(14, [_s('wa',1),_s('ma',6)]),
  _p(15, [_s('pa',7),_s('ta',0)]),
  _p(16, [_s('ta',0),_s('wa',1),_s('ta',0)]),
  _p(17, [_s('wa',1),_s('ta',0),_s('wa',1)]),
  _p(18, [_s('sa',3),_s('ta',0),_s('wa',1)]),
  _p(19, [_s('ra',4),_s('wa',1),_s('ta',0)]),
  _p(20, [_s('ta',0),_s('na',5),_s('wa',1)]),
  _p(21, [_s('wa',1),_s('pa',7),_s('ta',0)]),
  _p(22, [_s('ma',6),_s('ta',0),_s('sa',3)]),
  _p(23, [_s('ta',0),_s('ka',3),_s('wa',1)]),
  _p(24, [_s('wa',1),_s('ba',5),_s('ta',0)]),
  _p(25, [_s('ta',0),_s('da',4),_s('wa',1)]),
  // review
  _p(26, [_s('ta',0),_s('wa',0)]),
  _p(27, [_s('wa',0),_s('ta',0),_s('wa',0)]),
  _p(28, [_s('ta',0),_s('wa',0),_s('ta',0)]),
];

// ── BAB 9 : ya · za ──────────────────────────────────────────
final _b9 = <ReadingPage>[
  _p(1,  [_s('ya',0)]),
  _p(2,  [_s('za',1)]),
  _p(3,  [_s('ya',0),_s('ya',0)]),
  _p(4,  [_s('za',1),_s('za',1)]),
  _p(5,  [_s('ya',0),_s('za',1)]),
  _p(6,  [_s('za',1),_s('ya',0)]),
  _p(7,  [_s('a',2), _s('ya',0)]),
  _p(8,  [_s('ya',0),_s('a',2)]),
  _p(9,  [_s('a',2), _s('za',1)]),
  _p(10, [_s('za',1),_s('a',2)]),
  _p(11, [_s('ta',3),_s('ya',0)]),
  _p(12, [_s('za',1),_s('wa',4)]),
  _p(13, [_s('sa',5),_s('ya',0)]),
  _p(14, [_s('za',1),_s('ra',6)]),
  _p(15, [_s('na',7),_s('ya',0)]),
  _p(16, [_s('ya',0),_s('za',1),_s('ya',0)]),
  _p(17, [_s('za',1),_s('ya',0),_s('za',1)]),
  _p(18, [_s('ta',3),_s('ya',0),_s('za',1)]),
  _p(19, [_s('wa',4),_s('za',1),_s('ya',0)]),
  _p(20, [_s('ya',0),_s('sa',5),_s('za',1)]),
  _p(21, [_s('za',1),_s('na',7),_s('ya',0)]),
  _p(22, [_s('ra',6),_s('ya',0),_s('ta',3)]),
  _p(23, [_s('ya',0),_s('ma',5),_s('za',1)]),
  _p(24, [_s('za',1),_s('ba',3),_s('ya',0)]),
  _p(25, [_s('ya',0),_s('ka',4),_s('za',1)]),
  // review
  _p(26, [_s('ya',1),_s('za',1)]),
  _p(27, [_s('za',1),_s('ya',1),_s('za',1)]),
  _p(28, [_s('ya',1),_s('za',1),_s('ya',1)]),
];

// ── BAB 10 : review vokal "a" ─────────────────────────────────
final _b10 = <ReadingPage>[
  _p(1,  [_s('ba',0),_s('ca',1)]),
  _p(2,  [_s('da',0),_s('fa',1)]),
  _p(3,  [_s('ga',0),_s('ha',1)]),
  _p(4,  [_s('ja',0),_s('ka',1)]),
  _p(5,  [_s('la',0),_s('ma',1)]),
  _p(6,  [_s('na',0),_s('pa',1)]),
  _p(7,  [_s('ra',0),_s('sa',1)]),
  _p(8,  [_s('ta',0),_s('wa',1)]),
  _p(9,  [_s('ya',0),_s('za',1)]),
  _p(10, [_s('ba',0),_s('da',1),_s('ga',2)]),
  _p(11, [_s('ha',3),_s('ja',4),_s('ka',5)]),
  _p(12, [_s('la',6),_s('ma',7),_s('na',0)]),
  _p(13, [_s('pa',1),_s('ra',2),_s('sa',3)]),
  _p(14, [_s('ta',4),_s('wa',5),_s('ya',6)]),
  _p(15, [_s('za',7),_s('ba',0),_s('ca',1)]),
  _p(16, [_s('ma',0),_s('ka',1),_s('na',2)]),
  _p(17, [_s('ra',3),_s('sa',4),_s('ta',5)]),
  _p(18, [_s('ba',6),_s('wa',7),_s('ya',0)]),
  _p(19, [_s('da',1),_s('la',2),_s('pa',3)]),
  _p(20, [_s('ga',4),_s('ja',5),_s('za',6)]),
  // review 1 warna
  _p(21, [_s('ba',2),_s('ca',2),_s('da',2)]),
  _p(22, [_s('na',2),_s('pa',2),_s('ra',2)]),
  _p(23, [_s('ta',2),_s('wa',2),_s('ya',2)]),
];

// ══════════════════════════════════════════════════════════════
// FASE 2 — VOKAL "I"  (Bab 11–20)
// ══════════════════════════════════════════════════════════════

// helper untuk fase vokal i: pasangan huruf + warisan vokal a
List<ReadingPage> _faseI(String h1, String h2, int babNum) {
  // warisan vokal a (colorIndex 3–7 bergantian)
  final wa = ['ba','ca','da','fa','ga','ha','ja','ka','la','ma',
               'na','pa','ra','sa','ta','wa','ya','za'];
  int wc(int i) => 3 + (i % 5);
  final pages = <ReadingPage>[
    _p(1,  [_s(h1,0)]),
    _p(2,  [_s(h2,1)]),
    _p(3,  [_s(h1,0),_s(h1,0)]),
    _p(4,  [_s(h2,1),_s(h2,1)]),
    _p(5,  [_s(h1,0),_s(h2,1)]),
    _p(6,  [_s(h2,1),_s(h1,0)]),
    _p(7,  [_s('i',2),_s(h1,0)]),
    _p(8,  [_s(h1,0),_s('i',2)]),
    _p(9,  [_s('i',2),_s(h2,1)]),
    _p(10, [_s(h2,1),_s('i',2)]),
    _p(11, [_s(h1,0),_s(h2,1),_s(h1,0)]),
    _p(12, [_s(h2,1),_s(h1,0),_s(h2,1)]),
    // 3 pasang warisan vokal a
    _p(13, [_s(wa[babNum%wa.length],wc(0)),_s(h1,0)]),
    _p(14, [_s(h2,1),_s(wa[(babNum+1)%wa.length],wc(1))]),
    _p(15, [_s(wa[(babNum+2)%wa.length],wc(2)),_s(h2,1)]),
    _p(16, [_s(h1,0),_s(wa[(babNum+3)%wa.length],wc(3))]),
    _p(17, [_s(h1,0),_s(h2,1),_s(wa[(babNum+4)%wa.length],wc(4))]),
    _p(18, [_s(wa[(babNum+5)%wa.length],wc(0)),_s(h1,0),_s(h2,1)]),
    _p(19, [_s(h2,1),_s(wa[(babNum+6)%wa.length],wc(1)),_s(h1,0)]),
    _p(20, [_s(h1,0),_s(wa[(babNum+7)%wa.length],wc(2)),_s(h2,1)]),
    _p(21, [_s(h2,1),_s(h1,0),_s(wa[(babNum+8)%wa.length],wc(3))]),
    _p(22, [_s(wa[(babNum+9)%wa.length],wc(4)),_s(h2,1),_s(h1,0)]),
    _p(23, [_s(h1,0),_s('i',2),_s(h2,1)]),
    _p(24, [_s(h2,1),_s('i',2),_s(h1,0)]),
    _p(25, [_s('i',2),_s(h1,0),_s(h2,1)]),
    // review 1 warna
    _p(26, [_s(h1,0),_s(h2,0)]),
    _p(27, [_s(h2,0),_s(h1,0),_s(h2,0)]),
    _p(28, [_s(h1,0),_s(h2,0),_s(h1,0)]),
  ];
  return pages;
}

final _b11 = _faseI('bi','ci',0);   // Bab 11 : bi · ci
final _b12 = _faseI('di','fi',2);   // Bab 12 : di · fi
final _b13 = _faseI('gi','hi',4);   // Bab 13 : gi · hi
final _b14 = _faseI('ji','ki',6);   // Bab 14 : ji · ki
final _b15 = _faseI('li','mi',8);   // Bab 15 : li · mi
final _b16 = _faseI('ni','pi',10);  // Bab 16 : ni · pi
final _b17 = _faseI('ri','si',12);  // Bab 17 : ri · si
final _b18 = _faseI('ti','wi',14);  // Bab 18 : ti · wi
final _b19 = _faseI('yi','zi',16);  // Bab 19 : yi · zi

// Bab 20 — review vokal "i"
final _b20 = <ReadingPage>[
  _p(1,  [_s('bi',0),_s('ci',1)]),
  _p(2,  [_s('di',0),_s('fi',1)]),
  _p(3,  [_s('gi',0),_s('hi',1)]),
  _p(4,  [_s('ji',0),_s('ki',1)]),
  _p(5,  [_s('li',0),_s('mi',1)]),
  _p(6,  [_s('ni',0),_s('pi',1)]),
  _p(7,  [_s('ri',0),_s('si',1)]),
  _p(8,  [_s('ti',0),_s('wi',1)]),
  _p(9,  [_s('yi',0),_s('zi',1)]),
  _p(10, [_s('bi',0),_s('di',1),_s('gi',2)]),
  _p(11, [_s('hi',3),_s('ji',4),_s('ki',5)]),
  _p(12, [_s('li',6),_s('mi',7),_s('ni',0)]),
  _p(13, [_s('pi',1),_s('ri',2),_s('si',3)]),
  _p(14, [_s('ti',4),_s('wi',5),_s('yi',6)]),
  _p(15, [_s('zi',7),_s('bi',0),_s('ci',1)]),
  _p(16, [_s('mi',0),_s('ki',1),_s('ni',2)]),
  _p(17, [_s('ri',3),_s('si',4),_s('ti',5)]),
  _p(18, [_s('bi',6),_s('wi',7),_s('yi',0)]),
  _p(19, [_s('di',1),_s('li',2),_s('pi',3)]),
  _p(20, [_s('gi',4),_s('ji',5),_s('zi',6)]),
  // review 1 warna
  _p(21, [_s('bi',2),_s('ci',2),_s('di',2)]),
  _p(22, [_s('ni',2),_s('pi',2),_s('ri',2)]),
  _p(23, [_s('ti',2),_s('wi',2),_s('yi',2)]),
];

// ══════════════════════════════════════════════════════════════
// FASE 3 — VOKAL "U"  (Bab 21–30)
// ══════════════════════════════════════════════════════════════

List<ReadingPage> _faseU(String h1, String h2, int seed) {
  final wa = ['ba','bi','ca','ci','da','di','fa','fi','ga','gi',
               'ha','hi','ja','ji','ka','ki','la','li','ma','mi'];
  int wc(int i) => 3 + (i % 5);
  final pages = <ReadingPage>[
    _p(1,  [_s(h1,0)]),
    _p(2,  [_s(h2,1)]),
    _p(3,  [_s(h1,0),_s(h1,0)]),
    _p(4,  [_s(h2,1),_s(h2,1)]),
    _p(5,  [_s(h1,0),_s(h2,1)]),
    _p(6,  [_s(h2,1),_s(h1,0)]),
    _p(7,  [_s('u',2),_s(h1,0)]),
    _p(8,  [_s(h1,0),_s('u',2)]),
    _p(9,  [_s('u',2),_s(h2,1)]),
    _p(10, [_s(h2,1),_s('u',2)]),
    _p(11, [_s(h1,0),_s(h2,1),_s(h1,0)]),
    _p(12, [_s(h2,1),_s(h1,0),_s(h2,1)]),
    _p(13, [_s(wa[seed%wa.length],wc(0)),_s(h1,0)]),
    _p(14, [_s(h2,1),_s(wa[(seed+1)%wa.length],wc(1))]),
    _p(15, [_s(wa[(seed+2)%wa.length],wc(2)),_s(h2,1)]),
    _p(16, [_s(h1,0),_s(wa[(seed+3)%wa.length],wc(3))]),
    _p(17, [_s(h1,0),_s(h2,1),_s(wa[(seed+4)%wa.length],wc(4))]),
    _p(18, [_s(wa[(seed+5)%wa.length],wc(0)),_s(h1,0),_s(h2,1)]),
    _p(19, [_s(h2,1),_s(wa[(seed+6)%wa.length],wc(1)),_s(h1,0)]),
    _p(20, [_s(h1,0),_s(wa[(seed+7)%wa.length],wc(2)),_s(h2,1)]),
    _p(21, [_s(h2,1),_s(h1,0),_s(wa[(seed+8)%wa.length],wc(3))]),
    _p(22, [_s(wa[(seed+9)%wa.length],wc(4)),_s(h2,1),_s(h1,0)]),
    _p(23, [_s(h1,0),_s('u',2),_s(h2,1)]),
    _p(24, [_s(h2,1),_s('u',2),_s(h1,0)]),
    _p(25, [_s('u',2),_s(h1,0),_s(h2,1)]),
    _p(26, [_s(h1,0),_s(h2,0)]),
    _p(27, [_s(h2,0),_s(h1,0),_s(h2,0)]),
    _p(28, [_s(h1,0),_s(h2,0),_s(h1,0)]),
  ];
  return pages;
}

final _b21 = _faseU('bu','cu',0);
final _b22 = _faseU('du','fu',2);
final _b23 = _faseU('gu','hu',4);
final _b24 = _faseU('ju','ku',6);
final _b25 = _faseU('lu','mu',8);
final _b26 = _faseU('nu','pu',10);
final _b27 = _faseU('ru','su',12);
final _b28 = _faseU('tu','wu',14);
final _b29 = _faseU('yu','zu',16);

final _b30 = <ReadingPage>[
  _p(1,  [_s('bu',0),_s('cu',1)]),
  _p(2,  [_s('du',0),_s('fu',1)]),
  _p(3,  [_s('gu',0),_s('hu',1)]),
  _p(4,  [_s('ju',0),_s('ku',1)]),
  _p(5,  [_s('lu',0),_s('mu',1)]),
  _p(6,  [_s('nu',0),_s('pu',1)]),
  _p(7,  [_s('ru',0),_s('su',1)]),
  _p(8,  [_s('tu',0),_s('wu',1)]),
  _p(9,  [_s('yu',0),_s('zu',1)]),
  _p(10, [_s('bu',0),_s('du',1),_s('gu',2)]),
  _p(11, [_s('hu',3),_s('ju',4),_s('ku',5)]),
  _p(12, [_s('lu',6),_s('mu',7),_s('nu',0)]),
  _p(13, [_s('pu',1),_s('ru',2),_s('su',3)]),
  _p(14, [_s('tu',4),_s('wu',5),_s('yu',6)]),
  _p(15, [_s('zu',7),_s('bu',0),_s('cu',1)]),
  _p(16, [_s('mu',0),_s('ku',1),_s('nu',2)]),
  _p(17, [_s('ru',3),_s('su',4),_s('tu',5)]),
  _p(18, [_s('bu',6),_s('wu',7),_s('yu',0)]),
  _p(19, [_s('du',1),_s('lu',2),_s('pu',3)]),
  _p(20, [_s('gu',4),_s('ju',5),_s('zu',6)]),
  _p(21, [_s('bu',2),_s('cu',2),_s('du',2)]),
  _p(22, [_s('nu',2),_s('pu',2),_s('ru',2)]),
  _p(23, [_s('tu',2),_s('wu',2),_s('yu',2)]),
];

// ══════════════════════════════════════════════════════════════
// FASE 4 — VOKAL "E"  (Bab 31–40)
// ══════════════════════════════════════════════════════════════

List<ReadingPage> _faseE(String h1, String h2, int seed) {
  final wa = ['ba','bi','bu','ca','ci','cu','da','di','du','fa',
               'fi','fu','ga','gi','gu','ha','hi','hu','ja','ji'];
  int wc(int i) => 3 + (i % 5);
  return [
    _p(1,  [_s(h1,0)]),
    _p(2,  [_s(h2,1)]),
    _p(3,  [_s(h1,0),_s(h1,0)]),
    _p(4,  [_s(h2,1),_s(h2,1)]),
    _p(5,  [_s(h1,0),_s(h2,1)]),
    _p(6,  [_s(h2,1),_s(h1,0)]),
    _p(7,  [_s('e',2),_s(h1,0)]),
    _p(8,  [_s(h1,0),_s('e',2)]),
    _p(9,  [_s('e',2),_s(h2,1)]),
    _p(10, [_s(h2,1),_s('e',2)]),
    _p(11, [_s(h1,0),_s(h2,1),_s(h1,0)]),
    _p(12, [_s(h2,1),_s(h1,0),_s(h2,1)]),
    _p(13, [_s(wa[seed%wa.length],wc(0)),_s(h1,0)]),
    _p(14, [_s(h2,1),_s(wa[(seed+1)%wa.length],wc(1))]),
    _p(15, [_s(wa[(seed+2)%wa.length],wc(2)),_s(h2,1)]),
    _p(16, [_s(h1,0),_s(wa[(seed+3)%wa.length],wc(3))]),
    _p(17, [_s(h1,0),_s(h2,1),_s(wa[(seed+4)%wa.length],wc(4))]),
    _p(18, [_s(wa[(seed+5)%wa.length],wc(0)),_s(h1,0),_s(h2,1)]),
    _p(19, [_s(h2,1),_s(wa[(seed+6)%wa.length],wc(1)),_s(h1,0)]),
    _p(20, [_s(h1,0),_s(wa[(seed+7)%wa.length],wc(2)),_s(h2,1)]),
    _p(21, [_s(h2,1),_s(h1,0),_s(wa[(seed+8)%wa.length],wc(3))]),
    _p(22, [_s(wa[(seed+9)%wa.length],wc(4)),_s(h2,1),_s(h1,0)]),
    _p(23, [_s(h1,0),_s('e',2),_s(h2,1)]),
    _p(24, [_s(h2,1),_s('e',2),_s(h1,0)]),
    _p(25, [_s('e',2),_s(h1,0),_s(h2,1)]),
    _p(26, [_s(h1,0),_s(h2,0)]),
    _p(27, [_s(h2,0),_s(h1,0),_s(h2,0)]),
    _p(28, [_s(h1,0),_s(h2,0),_s(h1,0)]),
  ];
}

final _b31 = _faseE('be','ce',0);
final _b32 = _faseE('de','fe',2);
final _b33 = _faseE('ge','he',4);
final _b34 = _faseE('je','ke',6);
final _b35 = _faseE('le','me',8);
final _b36 = _faseE('ne','pe',10);
final _b37 = _faseE('re','se',12);
final _b38 = _faseE('te','we',14);
final _b39 = _faseE('ye','ze',16);

final _b40 = <ReadingPage>[
  _p(1,  [_s('be',0),_s('ce',1)]),
  _p(2,  [_s('de',0),_s('fe',1)]),
  _p(3,  [_s('ge',0),_s('he',1)]),
  _p(4,  [_s('je',0),_s('ke',1)]),
  _p(5,  [_s('le',0),_s('me',1)]),
  _p(6,  [_s('ne',0),_s('pe',1)]),
  _p(7,  [_s('re',0),_s('se',1)]),
  _p(8,  [_s('te',0),_s('we',1)]),
  _p(9,  [_s('ye',0),_s('ze',1)]),
  _p(10, [_s('be',0),_s('de',1),_s('ge',2)]),
  _p(11, [_s('he',3),_s('je',4),_s('ke',5)]),
  _p(12, [_s('le',6),_s('me',7),_s('ne',0)]),
  _p(13, [_s('pe',1),_s('re',2),_s('se',3)]),
  _p(14, [_s('te',4),_s('we',5),_s('ye',6)]),
  _p(15, [_s('ze',7),_s('be',0),_s('ce',1)]),
  _p(16, [_s('me',0),_s('ke',1),_s('ne',2)]),
  _p(17, [_s('re',3),_s('se',4),_s('te',5)]),
  _p(18, [_s('be',6),_s('we',7),_s('ye',0)]),
  _p(19, [_s('de',1),_s('le',2),_s('pe',3)]),
  _p(20, [_s('ge',4),_s('je',5),_s('ze',6)]),
  _p(21, [_s('be',2),_s('ce',2),_s('de',2)]),
  _p(22, [_s('ne',2),_s('pe',2),_s('re',2)]),
  _p(23, [_s('te',2),_s('we',2),_s('ye',2)]),
];

// ══════════════════════════════════════════════════════════════
// FASE 5 — VOKAL "O"  (Bab 41–50)
// ══════════════════════════════════════════════════════════════

List<ReadingPage> _faseO(String h1, String h2, int seed) {
  final wa = ['ba','bi','bu','be','ca','ci','cu','ce','da','di',
               'du','de','fa','fi','fu','fe','ga','gi','gu','ge'];
  int wc(int i) => 3 + (i % 5);
  return [
    _p(1,  [_s(h1,0)]),
    _p(2,  [_s(h2,1)]),
    _p(3,  [_s(h1,0),_s(h1,0)]),
    _p(4,  [_s(h2,1),_s(h2,1)]),
    _p(5,  [_s(h1,0),_s(h2,1)]),
    _p(6,  [_s(h2,1),_s(h1,0)]),
    _p(7,  [_s('o',2),_s(h1,0)]),
    _p(8,  [_s(h1,0),_s('o',2)]),
    _p(9,  [_s('o',2),_s(h2,1)]),
    _p(10, [_s(h2,1),_s('o',2)]),
    _p(11, [_s(h1,0),_s(h2,1),_s(h1,0)]),
    _p(12, [_s(h2,1),_s(h1,0),_s(h2,1)]),
    _p(13, [_s(wa[seed%wa.length],wc(0)),_s(h1,0)]),
    _p(14, [_s(h2,1),_s(wa[(seed+1)%wa.length],wc(1))]),
    _p(15, [_s(wa[(seed+2)%wa.length],wc(2)),_s(h2,1)]),
    _p(16, [_s(h1,0),_s(wa[(seed+3)%wa.length],wc(3))]),
    _p(17, [_s(h1,0),_s(h2,1),_s(wa[(seed+4)%wa.length],wc(4))]),
    _p(18, [_s(wa[(seed+5)%wa.length],wc(0)),_s(h1,0),_s(h2,1)]),
    _p(19, [_s(h2,1),_s(wa[(seed+6)%wa.length],wc(1)),_s(h1,0)]),
    _p(20, [_s(h1,0),_s(wa[(seed+7)%wa.length],wc(2)),_s(h2,1)]),
    _p(21, [_s(h2,1),_s(h1,0),_s(wa[(seed+8)%wa.length],wc(3))]),
    _p(22, [_s(wa[(seed+9)%wa.length],wc(4)),_s(h2,1),_s(h1,0)]),
    _p(23, [_s(h1,0),_s('o',2),_s(h2,1)]),
    _p(24, [_s(h2,1),_s('o',2),_s(h1,0)]),
    _p(25, [_s('o',2),_s(h1,0),_s(h2,1)]),
    _p(26, [_s(h1,0),_s(h2,0)]),
    _p(27, [_s(h2,0),_s(h1,0),_s(h2,0)]),
    _p(28, [_s(h1,0),_s(h2,0),_s(h1,0)]),
  ];
}

final _b41 = _faseO('bo','co',0);
final _b42 = _faseO('do','fo',2);
final _b43 = _faseO('go','ho',4);
final _b44 = _faseO('jo','ko',6);
final _b45 = _faseO('lo','mo',8);
final _b46 = _faseO('no','po',10);
final _b47 = _faseO('ro','so',12);
final _b48 = _faseO('to','wo',14);
final _b49 = _faseO('yo','zo',16);

final _b50 = <ReadingPage>[
  _p(1,  [_s('bo',0),_s('co',1)]),
  _p(2,  [_s('do',0),_s('fo',1)]),
  _p(3,  [_s('go',0),_s('ho',1)]),
  _p(4,  [_s('jo',0),_s('ko',1)]),
  _p(5,  [_s('lo',0),_s('mo',1)]),
  _p(6,  [_s('no',0),_s('po',1)]),
  _p(7,  [_s('ro',0),_s('so',1)]),
  _p(8,  [_s('to',0),_s('wo',1)]),
  _p(9,  [_s('yo',0),_s('zo',1)]),
  _p(10, [_s('bo',0),_s('do',1),_s('go',2)]),
  _p(11, [_s('ho',3),_s('jo',4),_s('ko',5)]),
  _p(12, [_s('lo',6),_s('mo',7),_s('no',0)]),
  _p(13, [_s('po',1),_s('ro',2),_s('so',3)]),
  _p(14, [_s('to',4),_s('wo',5),_s('yo',6)]),
  _p(15, [_s('zo',7),_s('bo',0),_s('co',1)]),
  _p(16, [_s('mo',0),_s('ko',1),_s('no',2)]),
  _p(17, [_s('ro',3),_s('so',4),_s('to',5)]),
  _p(18, [_s('bo',6),_s('wo',7),_s('yo',0)]),
  _p(19, [_s('do',1),_s('lo',2),_s('po',3)]),
  _p(20, [_s('go',4),_s('jo',5),_s('zo',6)]),
  _p(21, [_s('bo',2),_s('co',2),_s('do',2)]),
  _p(22, [_s('no',2),_s('po',2),_s('ro',2)]),
  _p(23, [_s('to',2),_s('wo',2),_s('yo',2)]),
];

// ══════════════════════════════════════════════════════════════
// FASE 6 — HURUF MATI / KVK  (Bab 51–65)
// ══════════════════════════════════════════════════════════════

// helper KVK: satu pasang akhiran konsonan
List<ReadingPage> _faseKVK(String ak1, String ak2, int seed) {
  // vokal terbuka sebagai kepala
  final heads = ['ba','bi','bu','be','bo','ca','ci','cu','ce','co',
                 'da','di','du','de','do','fa','ga','ha','ja','ka'];
  int wc(int i) => (i % 8);
  // suku kata KVK = kepala + akhiran
  String kvk1(int i) => heads[i % heads.length] + ak1;
  String kvk2(int i) => heads[(i+1) % heads.length] + ak2;
  return [
    _p(1,  [_s(kvk1(0),0)]),
    _p(2,  [_s(kvk2(0),1)]),
    _p(3,  [_s(kvk1(1),0),_s(kvk1(2),0)]),
    _p(4,  [_s(kvk2(1),1),_s(kvk2(2),1)]),
    _p(5,  [_s(kvk1(3),0),_s(kvk2(3),1)]),
    _p(6,  [_s(kvk2(4),1),_s(kvk1(4),0)]),
    _p(7,  [_s(heads[(seed)%heads.length],2),_s(kvk1(5),0)]),
    _p(8,  [_s(kvk1(6),0),_s(heads[(seed+1)%heads.length],2)]),
    _p(9,  [_s(heads[(seed+2)%heads.length],2),_s(kvk2(7),1)]),
    _p(10, [_s(kvk2(8),1),_s(heads[(seed+3)%heads.length],2)]),
    _p(11, [_s(kvk1(9),0),_s(kvk2(9),1),_s(kvk1(10),0)]),
    _p(12, [_s(kvk2(10),1),_s(kvk1(11),0),_s(kvk2(11),1)]),
    _p(13, [_s(heads[(seed+4)%heads.length],wc(4)),_s(kvk1(12),0)]),
    _p(14, [_s(kvk2(12),1),_s(heads[(seed+5)%heads.length],wc(5))]),
    _p(15, [_s(kvk1(13),0),_s(kvk2(13),1)]),
    _p(16, [_s(kvk2(14),1),_s(kvk1(14),0)]),
    _p(17, [_s(kvk1(15),0),_s(heads[(seed+6)%heads.length],2),_s(kvk2(15),1)]),
    _p(18, [_s(kvk2(16),1),_s(kvk1(16),0),_s(heads[(seed+7)%heads.length],2)]),
    _p(19, [_s(heads[(seed+8)%heads.length],wc(3)),_s(kvk1(17),0),_s(kvk2(17),1)]),
    _p(20, [_s(kvk1(18),0),_s(kvk2(18),1),_s(heads[(seed+9)%heads.length],wc(4))]),
    _p(21, [_s(kvk2(19),1),_s(heads[(seed+10)%heads.length],wc(5)),_s(kvk1(19),0)]),
    _p(22, [_s(kvk1(0),0),_s(kvk2(0),1),_s(kvk1(1),0)]),
    _p(23, [_s(kvk2(1),1),_s(kvk1(2),0),_s(kvk2(2),1)]),
    _p(24, [_s(kvk1(3),0),_s(heads[seed%heads.length],2),_s(kvk2(3),1)]),
    _p(25, [_s(kvk2(4),1),_s(kvk1(4),0),_s(heads[(seed+1)%heads.length],2)]),
    // review 1 warna
    _p(26, [_s(kvk1(5),0),_s(kvk2(5),0)]),
    _p(27, [_s(kvk2(6),0),_s(kvk1(6),0),_s(kvk2(7),0)]),
    _p(28, [_s(kvk1(7),0),_s(kvk2(8),0),_s(kvk1(8),0)]),
  ];
}

final _b51 = _faseKVK('n','n',0);   // an · in
final _b52 = _faseKVK('n','n',4);   // un · en  (seed beda)
final _b53 = _faseKVK('n','m',2);   // on · am
final _b54 = _faseKVK('m','m',6);   // im · um
final _b55 = _faseKVK('m','m',8);   // em · om
final _b56 = _faseKVK('l','l',1);   // al · il
final _b57 = _faseKVK('l','l',5);   // ul · el
final _b58 = _faseKVK('l','r',3);   // ol · ar
final _b59 = _faseKVK('r','r',7);   // ir · ur
final _b60 = _faseKVK('r','r',9);   // er · or
final _b61 = _faseKVK('s','s',0);   // as · is
final _b62 = _faseKVK('s','s',4);   // us · es
final _b63 = _faseKVK('s','t',2);   // os · at
final _b64 = _faseKVK('t','t',6);   // it · ut
final _b65 = _faseKVK('t','t',8);   // et · ot

// ══════════════════════════════════════════════════════════════
// FASE 7 — DIGRAF & KLUSTER  (Bab 66–75)
// ══════════════════════════════════════════════════════════════

List<ReadingPage> _faseDigraf(String d1, String d2, int seed) {
  // vokal-vokal untuk dikombinasikan
  final vv = ['a','i','u','e','o'];
  // pasang digraf + vokal
  String dv1(int i) => d1 + vv[i % vv.length];
  String dv2(int i) => d2 + vv[i % vv.length];
  final bases = ['ba','bi','bu','be','bo','da','di','du','de','do',
                 'ga','gi','gu','ge','go','ka','ki','ku','ke','ko'];
  int wc(int i) => 3 + (i % 5);
  return [
    _p(1,  [_s(dv1(0),0)]),
    _p(2,  [_s(dv1(1),0)]),
    _p(3,  [_s(dv2(0),1)]),
    _p(4,  [_s(dv2(1),1)]),
    _p(5,  [_s(dv1(2),0),_s(dv1(3),0)]),
    _p(6,  [_s(dv2(2),1),_s(dv2(3),1)]),
    _p(7,  [_s(dv1(4),0),_s(dv2(4),1)]),
    _p(8,  [_s(dv2(0),1),_s(dv1(0),0)]),
    _p(9,  [_s(bases[(seed)%bases.length],2),_s(dv1(1),0)]),
    _p(10, [_s(dv2(1),1),_s(bases[(seed+1)%bases.length],2)]),
    _p(11, [_s(dv1(2),0),_s(bases[(seed+2)%bases.length],2)]),
    _p(12, [_s(bases[(seed+3)%bases.length],wc(0)),_s(dv2(2),1)]),
    _p(13, [_s(dv1(3),0),_s(dv2(3),1),_s(dv1(4),0)]),
    _p(14, [_s(dv2(4),1),_s(dv1(0),0),_s(dv2(0),1)]),
    _p(15, [_s(bases[(seed+4)%bases.length],wc(1)),_s(dv1(1),0),_s(dv2(1),1)]),
    _p(16, [_s(dv1(2),0),_s(bases[(seed+5)%bases.length],wc(2)),_s(dv2(2),1)]),
    _p(17, [_s(dv2(3),1),_s(dv1(3),0),_s(bases[(seed+6)%bases.length],wc(3))]),
    _p(18, [_s(bases[(seed+7)%bases.length],wc(4)),_s(dv2(4),1),_s(dv1(4),0)]),
    _p(19, [_s(dv1(0),0),_s(dv2(0),1)]),
    _p(20, [_s(dv1(1),0),_s(bases[(seed+8)%bases.length],2),_s(dv2(1),1)]),
    _p(21, [_s(dv2(2),1),_s(dv1(2),0),_s(bases[(seed+9)%bases.length],2)]),
    _p(22, [_s(dv1(3),0),_s(dv2(3),1),_s(dv1(4),0)]),
    _p(23, [_s(dv2(4),1),_s(bases[(seed+10)%bases.length],wc(0)),_s(dv1(0),0)]),
    _p(24, [_s(bases[(seed+11)%bases.length],wc(1)),_s(dv2(0),1),_s(dv1(1),0)]),
    _p(25, [_s(dv1(2),0),_s(dv2(2),1),_s(bases[(seed+12)%bases.length],wc(2))]),
    // review 1 warna
    _p(26, [_s(dv1(0),0),_s(dv2(0),0)]),
    _p(27, [_s(dv2(1),0),_s(dv1(1),0),_s(dv2(2),0)]),
    _p(28, [_s(dv1(2),0),_s(dv2(3),0),_s(dv1(3),0)]),
  ];
}

final _b66 = _faseDigraf('ng','ng',0);  // ng (semua vokal)
final _b67 = _faseDigraf('ny','ny',2);  // ny
final _b68 = _faseDigraf('kh','kh',4);  // kh
final _b69 = _faseDigraf('sy','sy',6);  // sy
final _b70 = _faseDigraf('bl','cl',1);  // bl · cl
final _b71 = _faseDigraf('fl','gl',3);  // fl · gl
final _b72 = _faseDigraf('pl','sl',5);  // pl · sl
final _b73 = _faseDigraf('br','cr',7);  // br · cr
final _b74 = _faseDigraf('dr','fr',9);  // dr · fr
final _b75 = _faseDigraf('gr','tr',11); // gr · tr

// ══════════════════════════════════════════════════════════════
// FASE 8 — DIFTONG & REVIEW AKHIR  (Bab 76–80)
// ══════════════════════════════════════════════════════════════

// Diftong: ai, au, oi
List<ReadingPage> _faseDiftong(String df, int seed) {
  final heads = ['b','c','d','f','g','h','j','k','l','m',
                 'n','p','r','s','t','w','y','z'];
  // bentuk suku kata dengan diftong: b+ai = bai, k+au = kau
  String sd(int i) => heads[i % heads.length] + df;
  final bases = ['ba','bi','bu','be','bo','da','di','du','de','do'];
  int wc(int i) => 3 + (i % 5);
  return [
    _p(1,  [_s(sd(0),0)]),
    _p(2,  [_s(sd(1),0)]),
    _p(3,  [_s(sd(2),0)]),
    _p(4,  [_s(sd(3),1)]),
    _p(5,  [_s(sd(0),0),_s(sd(1),1)]),
    _p(6,  [_s(sd(2),1),_s(sd(3),0)]),
    _p(7,  [_s(df,2),_s(sd(0),0)]),
    _p(8,  [_s(sd(1),0),_s(df,2)]),
    _p(9,  [_s(sd(2),1),_s(sd(0),0)]),
    _p(10, [_s(sd(3),0),_s(sd(1),1)]),
    _p(11, [_s(bases[seed%bases.length],wc(0)),_s(sd(0),0)]),
    _p(12, [_s(sd(1),1),_s(bases[(seed+1)%bases.length],wc(1))]),
    _p(13, [_s(sd(0),0),_s(sd(2),1),_s(sd(1),0)]),
    _p(14, [_s(sd(3),1),_s(sd(0),0),_s(sd(2),1)]),
    _p(15, [_s(bases[(seed+2)%bases.length],wc(2)),_s(sd(1),0),_s(sd(3),1)]),
    _p(16, [_s(sd(2),1),_s(bases[(seed+3)%bases.length],wc(3)),_s(sd(0),0)]),
    _p(17, [_s(sd(4),0),_s(sd(5),1)]),
    _p(18, [_s(sd(6),1),_s(sd(7),0)]),
    _p(19, [_s(sd(4),0),_s(sd(5),1),_s(sd(6),0)]),
    _p(20, [_s(sd(7),1),_s(sd(4),0),_s(sd(5),1)]),
    _p(21, [_s(sd(0),0),_s(sd(4),1),_s(sd(2),0)]),
    _p(22, [_s(sd(5),1),_s(df,2),_s(sd(1),0)]),
    _p(23, [_s(sd(3),0),_s(sd(6),1),_s(sd(4),0)]),
    _p(24, [_s(sd(7),1),_s(bases[(seed+4)%bases.length],wc(4)),_s(sd(5),0)]),
    _p(25, [_s(sd(6),0),_s(sd(7),1),_s(df,2)]),
    // review 1 warna
    _p(26, [_s(sd(0),0),_s(sd(1),0)]),
    _p(27, [_s(sd(2),0),_s(sd(0),0),_s(sd(3),0)]),
    _p(28, [_s(sd(1),0),_s(sd(2),0),_s(sd(0),0)]),
  ];
}

final _b76 = _faseDiftong('ai',0); // Bab 76 : diftong ai
final _b77 = _faseDiftong('au',2); // Bab 77 : diftong au
final _b78 = _faseDiftong('oi',4); // Bab 78 : diftong oi

// Bab 79 — Review gabungan semua fase
final _b79 = <ReadingPage>[
  _p(1,  [_s('ba',0),_s('bi',1),_s('bu',2)]),
  _p(2,  [_s('ca',0),_s('ci',1),_s('cu',2)]),
  _p(3,  [_s('be',3),_s('bo',4)]),
  _p(4,  [_s('da',0),_s('di',1),_s('du',2)]),
  _p(5,  [_s('de',3),_s('do',4)]),
  _p(6,  [_s('ban',0),_s('bin',1),_s('bun',2)]),
  _p(7,  [_s('dan',0),_s('din',1),_s('dun',2)]),
  _p(8,  [_s('bal',0),_s('bil',1),_s('bul',2)]),
  _p(9,  [_s('dal',0),_s('dil',1),_s('dul',2)]),
  _p(10, [_s('bar',0),_s('bir',1),_s('bur',2)]),
  _p(11, [_s('nge',0),_s('nga',1)]),
  _p(12, [_s('nya',0),_s('nyi',1)]),
  _p(13, [_s('bai',0),_s('bau',1)]),
  _p(14, [_s('dai',0),_s('dau',1)]),
  _p(15, [_s('bla',0),_s('bra',1)]),
  _p(16, [_s('tra',0),_s('gra',1)]),
  _p(17, [_s('ma',0),_s('nu',1),_s('sia',2)]),
  _p(18, [_s('bu',0),_s('ku',1)]),
  _p(19, [_s('ba',0),_s('ca',1),_s('an',2)]),
  _p(20, [_s('pin',0),_s('tar',1)]),
  // review 1 warna
  _p(21, [_s('ba',2),_s('bi',2),_s('bu',2)]),
  _p(22, [_s('da',2),_s('di',2),_s('du',2)]),
  _p(23, [_s('nga',2),_s('nya',2),_s('bai',2)]),
];

// Bab 80 — Ujian Baca Bebas (kata bermakna pendek)
final _b80 = <ReadingPage>[
  _p(1,  [_s('i',0),_s('bu',1)]),
  _p(2,  [_s('a',0),_s('ya',1)]),
  _p(3,  [_s('ba',0),_s('pa',1)]),
  _p(4,  [_s('ka',0),_s('ki',1)]),
  _p(5,  [_s('ta',0),_s('ngan',1)]),
  _p(6,  [_s('ma',0),_s('ta',1)]),
  _p(7,  [_s('hi',0),_s('dup',1)]),
  _p(8,  [_s('bu',0),_s('ku',1)]),
  _p(9,  [_s('ru',0),_s('mah',1)]),
  _p(10, [_s('ma',0),_s('kan',1)]),
  _p(11, [_s('mi',0),_s('num',1)]),
  _p(12, [_s('ja',0),_s('lan',1)]),
  _p(13, [_s('ba',0),_s('nyak',1)]),
  _p(14, [_s('pin',0),_s('tar',1)]),
  _p(15, [_s('sa',0),_s('yang',1)]),
  _p(16, [_s('se',0),_s('nang',1)]),
  _p(17, [_s('ber',0),_s('main',1)]),
  _p(18, [_s('ba',0),_s('ca',1),_s('an',2)]),
  _p(19, [_s('se',0),_s('ko',1),_s('lah',2)]),
  _p(20, [_s('per',0),_s('ta',1),_s('ma',2)]),
  // review 1 warna — kata utuh
  _p(21, [_s('i',2),_s('bu',2)]),
  _p(22, [_s('bu',2),_s('ku',2)]),
  _p(23, [_s('pin',2),_s('tar',2)]),
];

// ══════════════════════════════════════════════════════════════
// DAFTAR SEMUA BAB (80 bab)
// ══════════════════════════════════════════════════════════════
final List<ChapterModel> allChapters = [
  ChapterModel(id:1,  title:'Bab 1',  theme:'ba · ca', emoji:'🐛', pages:_b1),
  ChapterModel(id:2,  title:'Bab 2',  theme:'da · fa', emoji:'🦋', pages:_b2),
  ChapterModel(id:3,  title:'Bab 3',  theme:'ga · ha', emoji:'🌟', pages:_b3),
  ChapterModel(id:4,  title:'Bab 4',  theme:'ja · ka', emoji:'🐸', pages:_b4),
  ChapterModel(id:5,  title:'Bab 5',  theme:'la · ma', emoji:'🌈', pages:_b5),
  ChapterModel(id:6,  title:'Bab 6',  theme:'na · pa', emoji:'🎈', pages:_b6),
  ChapterModel(id:7,  title:'Bab 7',  theme:'ra · sa', emoji:'🦄', pages:_b7),
  ChapterModel(id:8,  title:'Bab 8',  theme:'ta · wa', emoji:'🌺', pages:_b8),
  ChapterModel(id:9,  title:'Bab 9',  theme:'ya · za', emoji:'⚡', pages:_b9),
  ChapterModel(id:10, title:'Bab 10', theme:'Review A', emoji:'🏆', pages:_b10),
  ChapterModel(id:11, title:'Bab 11', theme:'bi · ci', emoji:'🐝', pages:_b11),
  ChapterModel(id:12, title:'Bab 12', theme:'di · fi', emoji:'🦊', pages:_b12),
  ChapterModel(id:13, title:'Bab 13', theme:'gi · hi', emoji:'🌿', pages:_b13),
  ChapterModel(id:14, title:'Bab 14', theme:'ji · ki', emoji:'🎵', pages:_b14),
  ChapterModel(id:15, title:'Bab 15', theme:'li · mi', emoji:'🍋', pages:_b15),
  ChapterModel(id:16, title:'Bab 16', theme:'ni · pi', emoji:'🎀', pages:_b16),
  ChapterModel(id:17, title:'Bab 17', theme:'ri · si', emoji:'🌸', pages:_b17),
  ChapterModel(id:18, title:'Bab 18', theme:'ti · wi', emoji:'🦜', pages:_b18),
  ChapterModel(id:19, title:'Bab 19', theme:'yi · zi', emoji:'⭐', pages:_b19),
  ChapterModel(id:20, title:'Bab 20', theme:'Review I', emoji:'🥇', pages:_b20),
  ChapterModel(id:21, title:'Bab 21', theme:'bu · cu', emoji:'🐢', pages:_b21),
  ChapterModel(id:22, title:'Bab 22', theme:'du · fu', emoji:'🦉', pages:_b22),
  ChapterModel(id:23, title:'Bab 23', theme:'gu · hu', emoji:'🌊', pages:_b23),
  ChapterModel(id:24, title:'Bab 24', theme:'ju · ku', emoji:'🎯', pages:_b24),
  ChapterModel(id:25, title:'Bab 25', theme:'lu · mu', emoji:'🍉', pages:_b25),
  ChapterModel(id:26, title:'Bab 26', theme:'nu · pu', emoji:'🎪', pages:_b26),
  ChapterModel(id:27, title:'Bab 27', theme:'ru · su', emoji:'🌻', pages:_b27),
  ChapterModel(id:28, title:'Bab 28', theme:'tu · wu', emoji:'🦋', pages:_b28),
  ChapterModel(id:29, title:'Bab 29', theme:'yu · zu', emoji:'🌙', pages:_b29),
  ChapterModel(id:30, title:'Bab 30', theme:'Review U', emoji:'🥈', pages:_b30),
  ChapterModel(id:31, title:'Bab 31', theme:'be · ce', emoji:'🌹', pages:_b31),
  ChapterModel(id:32, title:'Bab 32', theme:'de · fe', emoji:'🦚', pages:_b32),
  ChapterModel(id:33, title:'Bab 33', theme:'ge · he', emoji:'🍀', pages:_b33),
  ChapterModel(id:34, title:'Bab 34', theme:'je · ke', emoji:'🎸', pages:_b34),
  ChapterModel(id:35, title:'Bab 35', theme:'le · me', emoji:'🍊', pages:_b35),
  ChapterModel(id:36, title:'Bab 36', theme:'ne · pe', emoji:'🎠', pages:_b36),
  ChapterModel(id:37, title:'Bab 37', theme:'re · se', emoji:'🌞', pages:_b37),
  ChapterModel(id:38, title:'Bab 38', theme:'te · we', emoji:'🦅', pages:_b38),
  ChapterModel(id:39, title:'Bab 39', theme:'ye · ze', emoji:'🌠', pages:_b39),
  ChapterModel(id:40, title:'Bab 40', theme:'Review E', emoji:'🥉', pages:_b40),
  ChapterModel(id:41, title:'Bab 41', theme:'bo · co', emoji:'🐋', pages:_b41),
  ChapterModel(id:42, title:'Bab 42', theme:'do · fo', emoji:'🦊', pages:_b42),
  ChapterModel(id:43, title:'Bab 43', theme:'go · ho', emoji:'🌴', pages:_b43),
  ChapterModel(id:44, title:'Bab 44', theme:'jo · ko', emoji:'🎭', pages:_b44),
  ChapterModel(id:45, title:'Bab 45', theme:'lo · mo', emoji:'🍓', pages:_b45),
  ChapterModel(id:46, title:'Bab 46', theme:'no · po', emoji:'🎡', pages:_b46),
  ChapterModel(id:47, title:'Bab 47', theme:'ro · so', emoji:'🌅', pages:_b47),
  ChapterModel(id:48, title:'Bab 48', theme:'to · wo', emoji:'🦩', pages:_b48),
  ChapterModel(id:49, title:'Bab 49', theme:'yo · zo', emoji:'🌌', pages:_b49),
  ChapterModel(id:50, title:'Bab 50', theme:'Review O', emoji:'🎖️', pages:_b50),
  ChapterModel(id:51, title:'Bab 51', theme:'an · in', emoji:'🔤', pages:_b51),
  ChapterModel(id:52, title:'Bab 52', theme:'un · en', emoji:'🔡', pages:_b52),
  ChapterModel(id:53, title:'Bab 53', theme:'on · am', emoji:'📝', pages:_b53),
  ChapterModel(id:54, title:'Bab 54', theme:'im · um', emoji:'✏️', pages:_b54),
  ChapterModel(id:55, title:'Bab 55', theme:'em · om', emoji:'🖊️', pages:_b55),
  ChapterModel(id:56, title:'Bab 56', theme:'al · il', emoji:'🔠', pages:_b56),
  ChapterModel(id:57, title:'Bab 57', theme:'ul · el', emoji:'📖', pages:_b57),
  ChapterModel(id:58, title:'Bab 58', theme:'ol · ar', emoji:'📚', pages:_b58),
  ChapterModel(id:59, title:'Bab 59', theme:'ir · ur', emoji:'📕', pages:_b59),
  ChapterModel(id:60, title:'Bab 60', theme:'er · or', emoji:'📗', pages:_b60),
  ChapterModel(id:61, title:'Bab 61', theme:'as · is', emoji:'📘', pages:_b61),
  ChapterModel(id:62, title:'Bab 62', theme:'us · es', emoji:'📙', pages:_b62),
  ChapterModel(id:63, title:'Bab 63', theme:'os · at', emoji:'🗒️', pages:_b63),
  ChapterModel(id:64, title:'Bab 64', theme:'it · ut', emoji:'🗓️', pages:_b64),
  ChapterModel(id:65, title:'Bab 65', theme:'et · ot', emoji:'📋', pages:_b65),
  ChapterModel(id:66, title:'Bab 66', theme:'nga · ngi', emoji:'🎶', pages:_b66),
  ChapterModel(id:67, title:'Bab 67', theme:'nya · nyi', emoji:'🎼', pages:_b67),
  ChapterModel(id:68, title:'Bab 68', theme:'kha · khi', emoji:'🌺', pages:_b68),
  ChapterModel(id:69, title:'Bab 69', theme:'sya · syi', emoji:'🌸', pages:_b69),
  ChapterModel(id:70, title:'Bab 70', theme:'bla · cla', emoji:'🌱', pages:_b70),
  ChapterModel(id:71, title:'Bab 71', theme:'fla · gla', emoji:'🌿', pages:_b71),
  ChapterModel(id:72, title:'Bab 72', theme:'pla · sla', emoji:'🍃', pages:_b72),
  ChapterModel(id:73, title:'Bab 73', theme:'bra · cra', emoji:'🦁', pages:_b73),
  ChapterModel(id:74, title:'Bab 74', theme:'dra · fra', emoji:'🐯', pages:_b74),
  ChapterModel(id:75, title:'Bab 75', theme:'gra · tra', emoji:'🐻', pages:_b75),
  ChapterModel(id:76, title:'Bab 76', theme:'diftong ai', emoji:'🌈', pages:_b76),
  ChapterModel(id:77, title:'Bab 77', theme:'diftong au', emoji:'🌊', pages:_b77),
  ChapterModel(id:78, title:'Bab 78', theme:'diftong oi', emoji:'💫', pages:_b78),
  ChapterModel(id:79, title:'Bab 79', theme:'Review Gabungan', emoji:'🎓', pages:_b79),
  ChapterModel(id:80, title:'Bab 80', theme:'Baca Bebas', emoji:'🏅', pages:_b80),
];
