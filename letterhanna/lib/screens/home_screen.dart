import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('LETTERHANNA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 22),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section - Elegant & Minimal
            _buildHeroSection(context),
            
            const SizedBox(height: 64),
            
            // Collection Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Decorative line
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFD4AF37).withOpacity(0.3),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.auto_fix_high,
                          color: Color(0xFFD4AF37),
                          size: 16,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color(0xFFD4AF37).withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Curated Collection',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          letterSpacing: 3,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Each font is carefully crafted by master typographers',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Font Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildElegantFontCard(
                    context,
                    'Bellissima Script',
                    '\$45',
                    'Romantic and flowing calligraphy',
                  ),
                  const SizedBox(height: 32),
                  _buildElegantFontCard(
                    context,
                    'Maison Nouvelle',
                    '\$38',
                    'Contemporary serif with classic roots',
                  ),
                  const SizedBox(height: 32),
                  _buildElegantFontCard(
                    context,
                    'Atelier Signature',
                    '\$52',
                    'Hand-drawn elegance for luxury brands',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 64),
            
            // Bottom Divider
            Center(
              child: Container(
                width: 60,
                height: 1,
                color: const Color(0xFFD4AF37).withOpacity(0.3),
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Hero Section - Elegant & Minimal
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 120, 24, 64),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFDF7),
            Color(0xFFFFFBF0),
          ],
        ),
      ),
      child: Column(
        children: [
          // Tagline
          Text(
            'EST. 2024',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
              color: const Color(0xFF2C1810).withOpacity(0.5),
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 24),
          
          // Main Headline
          Text(
            'Exquisite',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF2C1810),
              letterSpacing: 2,
              height: 1.2,
            ),
          ),
          Text(
            'Typography',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C1810),
              letterSpacing: 2,
              height: 1.2,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Gold line accent
          Container(
            width: 80,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFD4AF37).withOpacity(0),
                  const Color(0xFFD4AF37),
                  const Color(0xFFD4AF37).withOpacity(0),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Subtitle
          SizedBox(
            width: 300,
            child: Text(
              'Where artistry meets functionality. Discover handcrafted fonts designed for the discerning creative.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xFF5C4B3A),
                height: 1.7,
                letterSpacing: 0.3,
              ),
            ),
          ),
          
          const SizedBox(height: 36),
          
          // CTA Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 18,
              ),
            ),
            child: const Text(
              'EXPLORE COLLECTION',
              style: TextStyle(
                fontSize: 13,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Elegant Font Card
  Widget _buildElegantFontCard(
    BuildContext context,
    String title,
    String price,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(
          color: const Color(0xFFE8E2D5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1810).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview Area
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF7),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFE8E2D5),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Aa',
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF2C1810),
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
          
          // Info Section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C1810),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(0xFF8B7D6B),
                              letterSpacing: 0.3,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: const Color(0xFF2C1810).withOpacity(0.3),
                        size: 22,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C1810),
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF2C1810),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'VIEW DETAILS',
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}