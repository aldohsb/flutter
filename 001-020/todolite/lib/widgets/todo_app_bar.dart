import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// AppBar custom bergaya tulisan tangan di atas kertas.
class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.paper,
      elevation: 0,
      centerTitle: false,
      title: Text(
        'TodoLite',
        style: GoogleFonts.caveat(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.paperLine, height: 1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}