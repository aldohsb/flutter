// Class AppStrings menyimpan semua teks statis aplikasi
// Keuntungan: mudah maintenance, mudah translate ke bahasa lain
class AppStrings {
  // Constructor private supaya tidak bisa di-instantiate
  AppStrings._();

  // === APP INFO ===
  static const String appName = 'Letterhanna';
  static const String appTagline = 'Handwriting Fonts Collection';
  static const String appDescription = 
      'Discover beautiful handwriting fonts for your creative projects';

  // === HOME SCREEN ===
  static const String homeTitle = 'Letterhanna';
  static const String welcomeMessage = 'Welcome to Letterhanna';
  static const String getStartedButton = 'Get Started';
  static const String exploreButton = 'Explore Fonts';
  static const String browseCollection = 'Browse Collection';

  // === CATALOG SCREEN ===
  static const String catalogTitle = 'Font Catalog';
  static const String searchHint = 'Search fonts...';
  static const String filterByCategory = 'Filter by Category';
  static const String sortBy = 'Sort By';
  static const String noFontsFound = 'No fonts found';

  // === PROFILE SCREEN ===
  static const String profileTitle = 'My Profile';
  static const String editProfile = 'Edit Profile';
  static const String myOrders = 'My Orders';
  static const String myFavorites = 'My Favorites';
  static const String settings = 'Settings';
  static const String logout = 'Logout';

  // === NAVIGATION LABELS ===
  static const String navHome = 'Home';
  static const String navCatalog = 'Catalog';
  static const String navCart = 'Cart';
  static const String navProfile = 'Profile';

  // === GENERAL BUTTONS ===
  static const String buttonOk = 'OK';
  static const String buttonCancel = 'Cancel';
  static const String buttonSave = 'Save';
  static const String buttonDelete = 'Delete';
  static const String buttonEdit = 'Edit';
  static const String buttonBack = 'Back';
  static const String buttonNext = 'Next';
  static const String buttonClose = 'Close';

  // === MESSAGES ===
  static const String loadingMessage = 'Loading...';
  static const String errorMessage = 'Something went wrong';
  static const String noInternetMessage = 'No internet connection';
  static const String successMessage = 'Success!';
}