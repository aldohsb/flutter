import '../models/ocean_trait.dart';
import '../models/quiz_question.dart';

/// Bank 50 pertanyaan tes kepribadian OCEAN (Big Five).
///
/// Setiap trait memiliki 10 pertanyaan, terdiri dari kombinasi pertanyaan
/// positif dan negatif (reverse-scored) mengikuti pola instrumen
/// kepribadian standar seperti IPIP-50/BFI agar hasil pengukuran lebih
/// seimbang dan tidak bias terhadap satu arah jawaban saja.
final List<QuizQuestion> quizQuestions = [
  // ---------------- OPENNESS (10 soal) ----------------
  const QuizQuestion(
    id: 1,
    text: 'Saya memiliki imajinasi yang kaya dan senang membayangkan hal-hal baru.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 2,
    text: 'Saya tertarik mempelajari ide-ide abstrak dan konsep yang kompleks.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 3,
    text: 'Saya senang mencoba makanan, tempat, atau pengalaman yang belum pernah saya coba.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 4,
    text: 'Saya menikmati diskusi tentang seni, musik, atau sastra.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 5,
    text: 'Saya mudah menemukan cara kreatif untuk menyelesaikan suatu masalah.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 6,
    text: 'Saya lebih suka rutinitas yang sudah pasti daripada mencoba hal baru.',
    trait: OceanTrait.openness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 7,
    text: 'Saya merasa kurang tertarik pada teori atau gagasan yang sifatnya abstrak.',
    trait: OceanTrait.openness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 8,
    text: 'Saya cenderung menghindari perubahan dalam cara saya melakukan sesuatu.',
    trait: OceanTrait.openness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 9,
    text: 'Saya senang mengeksplorasi sudut pandang yang berbeda dari pendapat saya sendiri.',
    trait: OceanTrait.openness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 10,
    text: 'Saya jarang memikirkan hal-hal di luar kebutuhan sehari-hari saya.',
    trait: OceanTrait.openness,
    isReversed: true,
  ),

  // ---------------- CONSCIENTIOUSNESS (10 soal) ----------------
  const QuizQuestion(
    id: 11,
    text: 'Saya selalu mempersiapkan rencana sebelum memulai suatu pekerjaan.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 12,
    text: 'Saya menyelesaikan tugas tepat waktu meski tidak ada yang mengawasi.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 13,
    text: 'Saya memperhatikan detail kecil agar pekerjaan saya rapi dan akurat.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 14,
    text: 'Saya menjaga barang-barang saya tetap teratur dan pada tempatnya.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 15,
    text: 'Saya gigih menyelesaikan tugas walau menghadapi banyak hambatan.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 16,
    text: 'Saya sering menunda-nunda pekerjaan hingga mendekati tenggat waktu.',
    trait: OceanTrait.conscientiousness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 17,
    text: 'Saya cenderung ceroboh dan kurang teliti dalam mengerjakan sesuatu.',
    trait: OceanTrait.conscientiousness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 18,
    text: 'Barang-barang saya sering berantakan dan sulit ditemukan saat dibutuhkan.',
    trait: OceanTrait.conscientiousness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 19,
    text: 'Saya menetapkan target pribadi dan berusaha keras untuk mencapainya.',
    trait: OceanTrait.conscientiousness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 20,
    text: 'Saya mudah kehilangan fokus dan berpindah dari satu tugas ke tugas lain tanpa menyelesaikannya.',
    trait: OceanTrait.conscientiousness,
    isReversed: true,
  ),

  // ---------------- EXTRAVERSION (10 soal) ----------------
  const QuizQuestion(
    id: 21,
    text: 'Saya merasa berenergi ketika berada di tengah banyak orang.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 22,
    text: 'Saya mudah memulai percakapan dengan orang yang baru saya kenal.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 23,
    text: 'Saya senang menjadi pusat perhatian dalam suatu acara atau kumpul-kumpul.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 24,
    text: 'Saya lebih suka menghabiskan waktu luang bersama banyak teman daripada sendirian.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 25,
    text: 'Saya cenderung berbicara aktif dan terbuka dalam diskusi kelompok.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 26,
    text: 'Saya lebih suka menyendiri daripada berada di tengah keramaian.',
    trait: OceanTrait.extraversion,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 27,
    text: 'Saya merasa lelah secara emosional setelah bersosialisasi terlalu lama.',
    trait: OceanTrait.extraversion,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 28,
    text: 'Saya cenderung diam dan menjaga jarak ketika berada di lingkungan baru.',
    trait: OceanTrait.extraversion,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 29,
    text: 'Saya merasa nyaman tampil dan berbicara di depan banyak orang.',
    trait: OceanTrait.extraversion,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 30,
    text: 'Saya butuh waktu sendiri yang cukup lama untuk memulihkan energi setelah beraktivitas sosial.',
    trait: OceanTrait.extraversion,
    isReversed: true,
  ),

  // ---------------- AGREEABLENESS (10 soal) ----------------
  const QuizQuestion(
    id: 31,
    text: 'Saya berusaha memahami perasaan orang lain sebelum menilai tindakan mereka.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 32,
    text: 'Saya senang membantu orang lain meskipun tidak diminta.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 33,
    text: 'Saya mudah mempercayai niat baik orang lain.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 34,
    text: 'Saya lebih memilih menghindari konflik dan mencari solusi damai.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 35,
    text: 'Saya memperlakukan semua orang dengan sopan, bahkan saat sedang kesal.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 36,
    text: 'Saya cenderung kritis dan cepat menilai kesalahan orang lain.',
    trait: OceanTrait.agreeableness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 37,
    text: 'Saya kurang peduli terhadap masalah yang dihadapi orang lain.',
    trait: OceanTrait.agreeableness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 38,
    text: 'Saya lebih mengutamakan kepentingan saya sendiri dibanding orang lain.',
    trait: OceanTrait.agreeableness,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 39,
    text: 'Saya mudah memaafkan kesalahan orang lain terhadap saya.',
    trait: OceanTrait.agreeableness,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 40,
    text: 'Saya sering bersikap blak-blakan tanpa memikirkan perasaan orang lain.',
    trait: OceanTrait.agreeableness,
    isReversed: true,
  ),

  // ---------------- NEUROTICISM (10 soal) ----------------
  const QuizQuestion(
    id: 41,
    text: 'Saya mudah merasa cemas ketika menghadapi situasi yang tidak pasti.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 42,
    text: 'Suasana hati saya cenderung naik turun dengan cepat.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 43,
    text: 'Saya sering merasa khawatir tentang hal-hal yang belum tentu terjadi.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 44,
    text: 'Saya mudah merasa tertekan ketika berada di bawah banyak tekanan.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 45,
    text: 'Saya cenderung memikirkan kembali kesalahan masa lalu secara berlebihan.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 46,
    text: 'Saya tetap tenang dan stabil meskipun berada dalam situasi yang menegangkan.',
    trait: OceanTrait.neuroticism,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 47,
    text: 'Saya jarang merasa gelisah meskipun menghadapi tenggat waktu yang ketat.',
    trait: OceanTrait.neuroticism,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 48,
    text: 'Saya mampu mengendalikan emosi saya dengan baik dalam situasi sulit.',
    trait: OceanTrait.neuroticism,
    isReversed: true,
  ),
  const QuizQuestion(
    id: 49,
    text: 'Saya merasa mudah panik ketika rencana saya tiba-tiba berubah.',
    trait: OceanTrait.neuroticism,
    isReversed: false,
  ),
  const QuizQuestion(
    id: 50,
    text: 'Secara umum saya merasa puas dan damai dengan kehidupan saya.',
    trait: OceanTrait.neuroticism,
    isReversed: true,
  ),
];
