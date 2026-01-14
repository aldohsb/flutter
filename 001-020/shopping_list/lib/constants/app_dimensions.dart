// File ini berisi semua konstanta untuk spacing, padding, margin, radius, dan ukuran
// Dengan mendefinisikan dimensions di satu tempat, kita memastikan konsistensi
// spacing dan sizing di seluruh aplikasi, menciptakan visual rhythm yang harmonis

// Abstract class untuk mencegah instantiation
// Semua members bersifat static untuk akses langsung
abstract class AppDimensions {
  
  // === SPACING CONSTANTS ===
  // Spacing menggunakan sistem 8-point grid (8, 16, 24, 32, dst)
  // Sistem ini membantu menciptakan visual consistency dan rhythm
  
  // Spacing ekstra kecil - untuk gap minimal antar elemen
  // 4px adalah setengah dari base unit (8px), untuk spacing very tight
  static const double spacingXS = 4.0;
  
  // Spacing kecil - untuk gap antar elemen yang berdekatan
  // 8px adalah base unit, digunakan sebagai spacing fundamental
  static const double spacingS = 8.0;
  
  // Spacing medium - untuk gap standar antar komponen
  // 16px (2x base unit) adalah spacing paling umum digunakan
  static const double spacingM = 16.0;
  
  // Spacing large - untuk gap yang lebih luas antar section
  // 24px (3x base unit) untuk separasi yang jelas
  static const double spacingL = 24.0;
  
  // Spacing ekstra large - untuk gap besar antar major sections
  // 32px (4x base unit) untuk separasi maksimal
  static const double spacingXL = 32.0;
  
  // Spacing extra extra large - untuk spacing sangat besar
  // 48px (6x base unit) untuk spacing dramatis atau hero sections
  static const double spacingXXL = 48.0;

  // === PADDING CONSTANTS ===
  // Padding adalah ruang di dalam container/widget
  // Menggunakan nilai yang sama dengan spacing untuk konsistensi
  
  // Padding ekstra kecil - untuk container kecil atau compact layout
  static const double paddingXS = 4.0;
  
  // Padding kecil - untuk button, chip, atau elemen compact
  static const double paddingS = 8.0;
  
  // Padding medium - padding standar untuk cards, containers
  // 16px memberikan breathing room yang nyaman
  static const double paddingM = 16.0;
  
  // Padding large - untuk containers besar atau emphasis
  static const double paddingL = 24.0;
  
  // Padding ekstra large - untuk containers hero atau special sections
  static const double paddingXL = 32.0;

  // === BORDER RADIUS CONSTANTS ===
  // Border radius untuk rounded corners
  // Smaller radius = modern sharp look, larger radius = friendly soft look
  
  // Radius kecil - untuk elemen kecil atau subtle rounding
  // 4px memberikan sedikit softness tanpa terlalu rounded
  static const double radiusS = 4.0;
  
  // Radius medium - radius standar untuk cards dan containers
  // 8px adalah sweet spot untuk modern, friendly look
  static const double radiusM = 8.0;
  
  // Radius large - untuk cards besar atau emphasis elements
  // 12px memberikan softness yang lebih pronounced
  static const double radiusL = 12.0;
  
  // Radius ekstra large - untuk special containers atau modal
  // 16px untuk very rounded, friendly appearance
  static const double radiusXL = 16.0;
  
  // Radius circular - untuk membuat perfect circle atau pill shape
  // 100px (nilai besar) akan membuat any widget menjadi fully rounded
  static const double radiusCircular = 100.0;

  // === ICON SIZES ===
  // Ukuran standar untuk icons agar konsisten
  
  // Icon kecil - untuk inline icons atau decorative icons
  // 16px cocok untuk icon di samping text atau dalam button
  static const double iconS = 16.0;
  
  // Icon medium - ukuran standar untuk most icons
  // 24px adalah ukuran default Material Design icons
  static const double iconM = 24.0;
  
  // Icon large - untuk prominent icons atau feature icons
  // 32px untuk icons yang menjadi focal point
  static const double iconL = 32.0;
  
  // Icon ekstra large - untuk hero icons atau illustrations
  // 48px untuk icons besar dalam empty states atau splash
  static const double iconXL = 48.0;
  
  // Icon extra extra large - untuk large illustrations
  // 64px untuk very prominent visual elements
  static const double iconXXL = 64.0;

  // === BUTTON HEIGHTS ===
  // Tinggi standar untuk buttons (height yang comfortable untuk touch)
  
  // Button kecil - untuk inline actions atau compact layouts
  // 36px cukup untuk tap target tapi tetap compact
  static const double buttonHeightS = 36.0;
  
  // Button medium - tinggi standar untuk most buttons
  // 48px adalah minimum recommended touch target size (Google Material)
  static const double buttonHeightM = 48.0;
  
  // Button large - untuk primary CTAs atau prominent actions
  // 56px memberikan presence yang lebih strong
  static const double buttonHeightL = 56.0;

  // === INPUT FIELD HEIGHTS ===
  // Tinggi untuk text fields dan input elements
  
  // Input medium - tinggi standar untuk text fields
  // 48px sama dengan button untuk visual consistency
  static const double inputHeightM = 48.0;
  
  // Input large - untuk prominent input fields
  // 56px untuk search bars atau featured inputs
  static const double inputHeightL = 56.0;

  // === CARD DIMENSIONS ===
  // Ukuran untuk cards dan similar containers
  
  // Card elevation - ketinggian shadow untuk depth
  // 2.0 memberikan subtle shadow untuk card yang floating
  static const double cardElevation = 2.0;
  
  // Card elevation hover - shadow saat hover untuk interactivity feedback
  // 4.0 lebih tinggi untuk menunjukkan element is interactive
  static const double cardElevationHover = 4.0;
  
  // Card min height - tinggi minimum untuk cards
  // 100px memastikan card tidak terlalu pendek dan punya presence
  static const double cardMinHeight = 100.0;

  // === APP BAR DIMENSIONS ===
  // Ukuran untuk app bar dan navigation elements
  
  // App bar height - tinggi standard untuk app bar
  // 56px adalah recommended height untuk Material app bar
  static const double appBarHeight = 56.0;
  
  // Bottom nav height - tinggi untuk bottom navigation bar
  // 56px konsisten dengan app bar
  static const double bottomNavHeight = 56.0;

  // === DIVIDER & BORDERS ===
  // Ketebalan untuk dividers dan borders
  
  // Divider thickness - ketebalan untuk divider lines
  // 1.0px adalah standard untuk subtle separation
  static const double dividerThickness = 1.0;
  
  // Border width - ketebalan untuk borders
  // 1.0px untuk outline yang visible tapi tidak dominan
  static const double borderWidth = 1.0;
  
  // Border width thick - untuk emphasis borders
  // 2.0px untuk borders yang perlu stand out
  static const double borderWidthThick = 2.0;

  // === LIST ITEM DIMENSIONS ===
  // Ukuran untuk list items dan tiles
  
  // List item height - tinggi standar untuk list items
  // 72px adalah recommended untuk list items dengan icon dan text
  static const double listItemHeight = 72.0;
  
  // List item compact - untuk compact list atau dense layouts
  // 56px untuk list yang lebih tight
  static const double listItemHeightCompact = 56.0;

  // === DIALOG & MODAL DIMENSIONS ===
  // Ukuran untuk dialogs, modals, dan bottom sheets
  
  // Dialog max width - lebar maksimal untuk dialogs
  // 400px mencegah dialog terlalu lebar di layar besar
  static const double dialogMaxWidth = 400.0;
  
  // Bottom sheet max height - tinggi maksimal untuk bottom sheet
  // 0.9 = 90% dari screen height, memberikan space di top
  static const double bottomSheetMaxHeight = 0.9;
  
  // Modal border radius - radius untuk top corners modal
  // 16px untuk rounded top corners yang smooth
  static const double modalBorderRadius = 16.0;

  // === RESPONSIVE BREAKPOINTS ===
  // Breakpoints untuk responsive design
  
  // Mobile breakpoint - max width untuk mobile devices
  // 600px adalah standard breakpoint untuk mobile/tablet
  static const double mobileBreakpoint = 600.0;
  
  // Tablet breakpoint - max width untuk tablets
  // 900px untuk tablet/desktop separation
  static const double tabletBreakpoint = 900.0;
  
  // Desktop breakpoint - min width untuk desktop
  // 1200px untuk large desktop layouts
  static const double desktopBreakpoint = 1200.0;

  // === ANIMATION DURATIONS ===
  // Durasi untuk animasi (dalam milliseconds)
  
  // Duration short - untuk animasi cepat dan subtle
  // 200ms untuk micro-interactions yang harus responsif
  static const int durationShort = 200;
  
  // Duration medium - durasi standar untuk most animations
  // 300ms adalah sweet spot untuk smooth tapi tidak slow
  static const int durationMedium = 300;
  
  // Duration long - untuk animasi yang lebih complex atau dramatic
  // 500ms untuk transitions yang perlu lebih visible
  static const int durationLong = 500;

  // === IMAGE SIZES ===
  // Ukuran untuk images dan thumbnails
  
  // Thumbnail small - untuk small previews atau avatars
  // 40px untuk compact image representations
  static const double thumbnailS = 40.0;
  
  // Thumbnail medium - ukuran standar untuk thumbnails
  // 80px untuk comfortable preview size
  static const double thumbnailM = 80.0;
  
  // Thumbnail large - untuk prominent images
  // 120px untuk featured images atau heroes
  static const double thumbnailL = 120.0;

  // === GRID SPACING ===
  // Spacing untuk grid layouts
  
  // Grid spacing - gap antar items dalam grid
  // 16px memberikan clear separation dalam grid
  static const double gridSpacing = 16.0;
  
  // Grid cross axis count - jumlah kolom dalam grid
  // 2 adalah standard untuk mobile grid layout
  static const int gridCrossAxisCount = 2;
  
  // Grid aspect ratio - aspect ratio untuk grid items
  // 1.0 = square items, maintaining consistent sizing
  static const double gridAspectRatio = 1.0;
}