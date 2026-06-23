import 'package:flutter/material.dart';

import '../models/quiz_result_model.dart';
import '../theme/app_colors.dart';

class LoveLanguageInfo {
  final LoveLanguage language;
  final String title;
  final String tagline;
  final String description;
  final String howToLove;
  final String warning;
  final Color color;
  final IconData icon;

  const LoveLanguageInfo({
    required this.language,
    required this.title,
    required this.tagline,
    required this.description,
    required this.howToLove,
    required this.warning,
    required this.color,
    required this.icon,
  });

  static const Map<LoveLanguage, LoveLanguageInfo> data = {

    LoveLanguage.wordsOfAffirmation: LoveLanguageInfo(
      language: LoveLanguage.wordsOfAffirmation,
      title: 'Kata-kata Afirmasi',
      tagline: 'Kata-katamu adalah caramu peduli',
      description:
          'Kamu merasa paling dihargai ketika orang-orang di sekitarmu mengungkapkan perasaan '
          'mereka melalui kata-kata — pujian tulus, ucapan terima kasih, atau sekadar '
          '"aku bangga padamu." Bagi kamu, kata-kata bukan sekadar suara; mereka adalah '
          'bukti nyata bahwa seseorang melihat dan menghargai kehadiranmu.',
      howToLove:
          'Ucapkan pujian yang spesifik dan tulus. Kirim pesan singkat yang bermakna. '
          'Jangan menahan rasa terima kasih atau kekaguman — ekspresikan langsung '
          'agar orang yang kamu sayangi tahu apa yang kamu rasakan.',
      warning:
          'Kritik yang tajam atau kata-kata yang meremehkan bisa sangat melukai perasaanmu, '
          'bahkan lebih dalam dari yang orang lain duga. Kamu perlu kata-kata yang membangun, bukan menjatuhkan.',
      color: AppColors.llWords,
      icon: Icons.chat_bubble_rounded,
    ),

    LoveLanguage.qualityTime: LoveLanguageInfo(
      language: LoveLanguage.qualityTime,
      title: 'Waktu Berkualitas',
      tagline: 'Kehadiranmu adalah hadiah terbesar',
      description:
          'Kamu menghargai perhatian penuh dari orang-orang yang berarti lebih dari segalanya. '
          'Bukan sekadar berada di ruangan yang sama — tapi benar-benar fokus, mendengarkan, '
          'dan hadir tanpa distraksi. Momen bersama yang sederhana terasa jauh lebih '
          'bermakna bagimu dibanding hal-hal besar yang dilakukan tanpa kehadiran nyata.',
      howToLove:
          'Sisihkan waktu khusus tanpa gangguan gawai. Rencanakan aktivitas bersama yang '
          'kalian berdua nikmati. Jadilah pendengar aktif — tatap mata mereka dan tunjukkan '
          'ketertarikan yang tulus pada ceritanya.',
      warning:
          'Kamu bisa merasa diabaikan ketika orang-orang di sekitarmu tampak selalu sibuk '
          'atau teralihkan, meskipun mereka secara fisik ada di dekatmu.',
      color: AppColors.llTime,
      icon: Icons.access_time_rounded,
    ),

    LoveLanguage.receivingGifts: LoveLanguageInfo(
      language: LoveLanguage.receivingGifts,
      title: 'Menerima Hadiah',
      tagline: 'Setiap pemberian menyimpan makna',
      description:
          'Hadiah bagimu bukan tentang nilai materi — melainkan tentang pemikiran di baliknya. '
          'Ketika seseorang mengingat hal-hal kecil yang kamu sukai dan menghadirkannya '
          'untukmu, itu terasa seperti mereka benar-benar memperhatikan dan mengenalmu. '
          'Pemberian adalah simbol nyata bahwa seseorang memikirkanmu.',
      howToLove:
          'Perhatikan dan catat hal-hal kecil yang disebut orang yang kamu sayangi. '
          'Beri sesuatu tanpa harus menunggu momen spesial. Pilih pemberian yang personal '
          'dan penuh perhatian — nilainya bukan di harga, tapi di makna di baliknya.',
      warning:
          'Lupa momen penting atau memberi sesuatu tanpa usaha bisa terasa seperti '
          'ketidakpedulian bagimu, meski mungkin tidak dimaksudkan demikian.',
      color: AppColors.llGifts,
      icon: Icons.card_giftcard_rounded,
    ),

    LoveLanguage.actsOfService: LoveLanguageInfo(
      language: LoveLanguage.actsOfService,
      title: 'Tindakan Pelayanan',
      tagline: 'Kepedulian dibuktikan lewat tindakan',
      description:
          'Kamu merasa dipedulikan ketika seseorang meringankan bebanmu dengan tindakan nyata. '
          'Membantu pekerjaan, menyiapkan sesuatu sebelum diminta, atau sekadar mengurus '
          'hal kecil yang kamu butuhkan — tindakan seperti ini berbicara lebih keras dari '
          'kata-kata manapun bagimu.',
      howToLove:
          'Perhatikan apa yang bisa kamu lakukan tanpa harus diminta terlebih dahulu. '
          'Tawarkan bantuan yang konkret dan spesifik. Yang paling penting: '
          'ikuti kata-katamu dengan tindakan nyata.',
      warning:
          'Kamu bisa merasa tidak dihargai ketika orang-orang sekitar tampak pasif '
          'atau tidak berinisiatif membantu, meski kamu tidak selalu mengungkapkannya.',
      color: AppColors.llService,
      icon: Icons.handshake_rounded,
    ),

    LoveLanguage.physicalTouch: LoveLanguageInfo(
      language: LoveLanguage.physicalTouch,
      title: 'Sentuhan Fisik',
      tagline: 'Kedekatan terasa nyata lewat sentuhan',
      description:
          'Sentuhan fisik yang hangat dan tulus — pelukan, tepukan di bahu, '
          'atau sekadar duduk berdekatan — adalah cara kamu merasakan koneksi yang paling kuat. '
          'Sentuhan memberi rasa aman, diperhatikan, dan diakui kehadirannya '
          'yang tidak mudah digantikan oleh cara lain.',
      howToLove:
          'Peluk lebih sering saat momen yang tepat. Tepuk bahunya sebagai tanda dukungan. '
          'High-five saat merayakan sesuatu bersama. Sentuhan kecil yang konsisten '
          'lebih bermakna dari gestur besar yang jarang.',
      warning:
          'Jarak fisik atau minimnya sentuhan bisa membuatmu merasa terputus dan tidak '
          'diakui, bahkan ketika orang lain sudah menunjukkan kepedulian dengan cara lain.',
      color: AppColors.llTouch,
      icon: Icons.favorite_rounded,
    ),

  };

  static LoveLanguageInfo of(LoveLanguage ll) => data[ll]!;
}