import '../models/food_model.dart';
import '../utils/constants.dart';

class FoodData {
  static List<FoodModel> getAllFoods() {
    return [
      // DAGING & UNGGAS (20 items)
      FoodModel(name: 'Daging Sapi', category: FoodCategory.daging, carbs: 0, protein: 26, fat: 15, calories: 250, rating: 4, description: 'Sumber protein berkualitas tinggi', tips: 'Pilih potongan yang berlemak untuk keto'),
      FoodModel(name: 'Ayam (dada)', category: FoodCategory.daging, carbs: 0, protein: 31, fat: 3.6, calories: 165, rating: 4, description: 'Protein tinggi, rendah lemak', tips: 'Tambahkan minyak kelapa saat memasak'),
      FoodModel(name: 'Ayam (paha)', category: FoodCategory.daging, carbs: 0, protein: 26, fat: 7, calories: 209, rating: 4, description: 'Lebih berlemak dari dada ayam', tips: 'Bagus untuk keto dengan kulitnya'),
      FoodModel(name: 'Bebek', category: FoodCategory.daging, carbs: 0, protein: 19, fat: 28, calories: 337, rating: 4, description: 'Tinggi lemak sehat', tips: 'Bebek bakar tanpa saus manis'),
      FoodModel(name: 'Kambing', category: FoodCategory.daging, carbs: 0, protein: 25, fat: 21, calories: 294, rating: 4, description: 'Kaya zat besi', tips: 'Tongseng tanpa nasi cocok untuk keto'),
      FoodModel(name: 'Hati Sapi', category: FoodCategory.daging, carbs: 3.9, protein: 20, fat: 4, calories: 135, rating: 4, description: 'Tinggi vitamin A & B12', tips: 'Batasi porsi karena ada karbohidrat'),
      FoodModel(name: 'Hati Ayam', category: FoodCategory.daging, carbs: 0.7, protein: 24, fat: 6, calories: 167, rating: 4, description: 'Kaya nutrisi', tips: 'Hindari yang digoreng tepung'),
      FoodModel(name: 'Ampela', category: FoodCategory.daging, carbs: 0, protein: 18, fat: 2.7, calories: 94, rating: 4, description: 'Rendah kalori', tips: 'Bakar atau rebus'),
      FoodModel(name: 'Sosis Sapi', category: FoodCategory.daging, carbs: 3.5, protein: 13, fat: 25, calories: 301, rating: 3, description: 'Tinggi lemak', tips: 'Pilih yang tanpa filler/tepung'),
      FoodModel(name: 'Bakso Sapi', category: FoodCategory.daging, carbs: 8, protein: 12, fat: 10, calories: 180, rating: 2, description: 'Mengandung tepung', tips: 'Batasi konsumsi, pilih yang homemade'),
      FoodModel(name: 'Daging Cincang', category: FoodCategory.daging, carbs: 0, protein: 26, fat: 15, calories: 250, rating: 4, description: 'Serbaguna untuk masakan', tips: 'Buat burger tanpa roti'),
      FoodModel(name: 'Sate Ayam', category: FoodCategory.daging, carbs: 2, protein: 27, fat: 8, calories: 190, rating: 3, description: 'Bumbu kecap mengandung gula', tips: 'Minta tanpa saus kecap manis'),
      FoodModel(name: 'Daging Asap', category: FoodCategory.daging, carbs: 1, protein: 26, fat: 18, calories: 280, rating: 4, description: 'Awet dan praktis', tips: 'Cek label, hindari yang ada gula'),
      FoodModel(name: 'Kornet', category: FoodCategory.daging, carbs: 4, protein: 24, fat: 12, calories: 217, rating: 3, description: 'Daging kalengan', tips: 'Baca komposisi, pilih low carb'),
      FoodModel(name: 'Nugget Ayam', category: FoodCategory.daging, carbs: 15, protein: 12, fat: 18, calories: 280, rating: 2, description: 'Tinggi tepung', tips: 'Hindari atau pilih yang protein tinggi'),
      FoodModel(name: 'Rendang', category: FoodCategory.daging, carbs: 4, protein: 22, fat: 30, calories: 375, rating: 3, description: 'Santan tinggi lemak', tips: 'Makan tanpa nasi, porsi kecil'),
      FoodModel(name: 'Daging Giling', category: FoodCategory.daging, carbs: 0, protein: 26, fat: 15, calories: 250, rating: 4, description: 'Praktis untuk berbagai masakan', tips: 'Buat meatball tanpa tepung'),
      FoodModel(name: 'Ayam Geprek', category: FoodCategory.daging, carbs: 10, protein: 25, fat: 20, calories: 320, rating: 2, description: 'Digoreng tepung', tips: 'Hindari lapisan tepung'),
      FoodModel(name: 'Kulit Ayam Crispy', category: FoodCategory.daging, carbs: 12, protein: 18, fat: 35, calories: 420, rating: 2, description: 'Tinggi lemak dan tepung', tips: 'Kulit panggang tanpa tepung lebih baik'),

      // IKAN & SEAFOOD (25 items)
      FoodModel(name: 'Ikan Salmon', category: FoodCategory.ikan, carbs: 0, protein: 20, fat: 13, calories: 208, rating: 4, description: 'Omega-3 tinggi', tips: 'Panggang atau steam'),
      FoodModel(name: 'Ikan Tuna', category: FoodCategory.ikan, carbs: 0, protein: 30, fat: 1, calories: 132, rating: 4, description: 'Protein super tinggi', tips: 'Tambahkan minyak zaitun'),
      FoodModel(name: 'Ikan Kembung', category: FoodCategory.ikan, carbs: 0, protein: 22, fat: 8, calories: 168, rating: 4, description: 'Ikan lokal bergizi', tips: 'Bakar atau goreng dengan minyak kelapa'),
      FoodModel(name: 'Ikan Lele', category: FoodCategory.ikan, carbs: 0, protein: 18, fat: 4, calories: 110, rating: 4, description: 'Murah dan berprotein', tips: 'Pepes lele tanpa nasi'),
      FoodModel(name: 'Ikan Nila', category: FoodCategory.ikan, carbs: 0, protein: 20, fat: 2.5, calories: 96, rating: 4, description: 'Rendah kalori', tips: 'Bakar dengan bumbu rempah'),
      FoodModel(name: 'Ikan Gurame', category: FoodCategory.ikan, carbs: 0, protein: 19, fat: 3, calories: 104, rating: 4, description: 'Ikan air tawar populer', tips: 'Goreng tanpa tepung'),
      FoodModel(name: 'Ikan Tongkol', category: FoodCategory.ikan, carbs: 0, protein: 24, fat: 2, calories: 144, rating: 4, description: 'Mirip tuna, lebih terjangkau', tips: 'Pepes atau bumbu kuning'),
      FoodModel(name: 'Ikan Teri', category: FoodCategory.ikan, carbs: 0, protein: 10, fat: 2, calories: 77, rating: 4, description: 'Tinggi kalsium', tips: 'Goreng kering sebagai camilan'),
      FoodModel(name: 'Udang', category: FoodCategory.ikan, carbs: 0.2, protein: 24, fat: 0.3, calories: 99, rating: 4, description: 'Rendah kalori tinggi protein', tips: 'Tumis dengan mentega'),
      FoodModel(name: 'Cumi-cumi', category: FoodCategory.ikan, carbs: 3.1, protein: 15, fat: 1.4, calories: 92, rating: 4, description: 'Sumber protein laut', tips: 'Hindari yang digoreng tepung'),
      FoodModel(name: 'Kerang', category: FoodCategory.ikan, carbs: 5, protein: 12, fat: 2, calories: 86, rating: 3, description: 'Mengandung zinc', tips: 'Rebus atau tumis'),
      FoodModel(name: 'Kepiting', category: FoodCategory.ikan, carbs: 0, protein: 18, fat: 1, calories: 87, rating: 4, description: 'Rendah lemak', tips: 'Kepiting saus padang tanpa nasi'),
      FoodModel(name: 'Lobster', category: FoodCategory.ikan, carbs: 1.3, protein: 19, fat: 0.9, calories: 90, rating: 4, description: 'Mewah dan sehat', tips: 'Panggang dengan butter'),
      FoodModel(name: 'Ikan Cakalang', category: FoodCategory.ikan, carbs: 0, protein: 25, fat: 5, calories: 150, rating: 4, description: 'Ikan asap khas', tips: 'Rica-rica tanpa nasi'),
      FoodModel(name: 'Ikan Bandeng', category: FoodCategory.ikan, carbs: 0, protein: 20, fat: 4.8, calories: 129, rating: 4, description: 'Presto bandeng enak', tips: 'Presto atau bakar'),
      FoodModel(name: 'Ikan Patin', category: FoodCategory.ikan, carbs: 0, protein: 16, fat: 4, calories: 100, rating: 4, description: 'Daging lembut', tips: 'Pepes patin'),
      FoodModel(name: 'Ikan Kakap', category: FoodCategory.ikan, carbs: 0, protein: 20, fat: 1.3, calories: 100, rating: 4, description: 'Ikan premium', tips: 'Steam dengan jahe'),
      FoodModel(name: 'Ikan Sarden Kalengan', category: FoodCategory.ikan, carbs: 2, protein: 21, fat: 11, calories: 208, rating: 4, description: 'Praktis dan bergizi', tips: 'Pilih dalam minyak, bukan saus tomat'),
      FoodModel(name: 'Ikan Asin', category: FoodCategory.ikan, carbs: 0, protein: 42, fat: 1, calories: 186, rating: 4, description: 'Awet, tinggi protein', tips: 'Goreng atau bakar, batasi karena garam tinggi'),
      FoodModel(name: 'Cumi Asin', category: FoodCategory.ikan, carbs: 2, protein: 40, fat: 2, calories: 188, rating: 4, description: 'Awet dan gurih', tips: 'Goreng tanpa tepung'),
      FoodModel(name: 'Kerang Hijau', category: FoodCategory.ikan, carbs: 7, protein: 24, fat: 4, calories: 172, rating: 3, description: 'Tinggi zat besi', tips: 'Rebus dalam kuah bening'),
      FoodModel(name: 'Tiram', category: FoodCategory.ikan, carbs: 5, protein: 9, fat: 2, calories: 68, rating: 3, description: 'Tinggi zinc', tips: 'Makan mentah atau panggang'),
      FoodModel(name: 'Belut', category: FoodCategory.ikan, carbs: 0, protein: 18, fat: 2, calories: 90, rating: 4, description: 'Tinggi vitamin B12', tips: 'Goreng bumbu atau sup'),
      FoodModel(name: 'Sotong', category: FoodCategory.ikan, carbs: 3, protein: 16, fat: 1.5, calories: 92, rating: 4, description: 'Mirip cumi', tips: 'Goreng mentega'),
      FoodModel(name: 'Ikan Mujair', category: FoodCategory.ikan, carbs: 0, protein: 20, fat: 2, calories: 96, rating: 4, description: 'Ikan air tawar murah', tips: 'Goreng atau bakar'),

      // TELUR (10 items)
      // CEMILAN (15 items)
      FoodModel(name: 'Keripik Kale', category: FoodCategory.cemilan, carbs: 4, protein: 2, fat: 0.5, calories: 30, rating: 4, description: 'Snack sehat', tips: 'Panggang sendiri lebih baik'),
      FoodModel(name: 'Telur Rebus', category: FoodCategory.cemilan, carbs: 1.1, protein: 13, fat: 11, calories: 155, rating: 4, description: 'Snack protein tinggi', tips: 'Bawa kemana-mana'),
      FoodModel(name: 'Kacang Almond Panggang', category: FoodCategory.cemilan, carbs: 22, protein: 21, fat: 49, calories: 579, rating: 4, description: 'Camilan premium', tips: '10-15 butir cukup'),
      FoodModel(name: 'Dark Chocolate 85%', category: FoodCategory.cemilan, carbs: 15, protein: 8, fat: 45, calories: 598, rating: 4, description: 'Coklat rendah gula', tips: '1-2 kotak sehari'),
      FoodModel(name: 'Jerky Daging', category: FoodCategory.cemilan, carbs: 3, protein: 33, fat: 7, calories: 410, rating: 4, description: 'Daging kering', tips: 'Cek label, pilih low sugar'),
      FoodModel(name: 'Seaweed Snack', category: FoodCategory.cemilan, carbs: 1, protein: 1, fat: 2, calories: 30, rating: 4, description: 'Rumput laut kriuk', tips: 'Rendah kalori, kaya iodium'),
      FoodModel(name: 'Cheese Crisps', category: FoodCategory.cemilan, carbs: 1, protein: 25, fat: 28, calories: 360, rating: 4, description: 'Keju panggang kriuk', tips: 'Bikin sendiri lebih murah'),
      FoodModel(name: 'Edamame Panggang', category: FoodCategory.cemilan, carbs: 9, protein: 11, fat: 5, calories: 122, rating: 3, description: 'Kedelai panggang', tips: 'Porsi kecil'),
      FoodModel(name: 'Keripik Kentang', category: FoodCategory.cemilan, carbs: 53, protein: 6, fat: 35, calories: 536, rating: 1, description: 'Tinggi karbo', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Kerupuk', category: FoodCategory.cemilan, carbs: 65, protein: 8, fat: 20, calories: 480, rating: 1, description: 'Tepung tapioka', tips: 'HINDARI - tinggi pati'),
      FoodModel(name: 'Kue Kering', category: FoodCategory.cemilan, carbs: 68, protein: 7, fat: 18, calories: 450, rating: 1, description: 'Tinggi tepung dan gula', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Coklat Susu', category: FoodCategory.cemilan, carbs: 59, protein: 8, fat: 31, calories: 535, rating: 1, description: 'Tinggi gula', tips: 'HINDARI, pilih dark 85%+'),
      FoodModel(name: 'Permen', category: FoodCategory.cemilan, carbs: 98, protein: 0, fat: 0, calories: 394, rating: 1, description: 'Gula murni', tips: 'HINDARI sepenuhnya'),
      FoodModel(name: 'Popcorn', category: FoodCategory.cemilan, carbs: 78, protein: 13, fat: 4, calories: 387, rating: 1, description: 'Biji-bijian', tips: 'HINDARI untuk keto'),

      // LAINNYA (18 items) - Total jadi 200 items
      FoodModel(name: 'Tahu', category: FoodCategory.lainnya, carbs: 1.9, protein: 8, fat: 4.8, calories: 76, rating: 4, description: 'Protein nabati', tips: 'Goreng crispy atau bacem'),
      FoodModel(name: 'Tempe', category: FoodCategory.lainnya, carbs: 9, protein: 19, fat: 11, calories: 193, rating: 3, description: 'Fermentasi kedelai', tips: 'Porsi sedang, ada karbohidrat'),
      FoodModel(name: 'Oncom', category: FoodCategory.lainnya, carbs: 13, protein: 13, fat: 6, calories: 156, rating: 3, description: 'Fermentasi ampas tahu', tips: 'Khas Jawa Barat, porsi kecil'),
      FoodModel(name: 'Agar-agar Plain', category: FoodCategory.lainnya, carbs: 0.5, protein: 0.5, fat: 0, calories: 3, rating: 4, description: 'Rendah kalori', tips: 'Dessert dengan pemanis keto'),
      FoodModel(name: 'Jelly Tanpa Gula', category: FoodCategory.lainnya, carbs: 2, protein: 1.5, fat: 0, calories: 13, rating: 4, description: 'Low carb dessert', tips: 'Dengan stevia atau erythritol'),
      FoodModel(name: 'Shirataki Noodles', category: FoodCategory.lainnya, carbs: 0.2, protein: 0, fat: 0, calories: 10, rating: 4, description: 'Mie konjac', tips: 'Pengganti mie sempurna'),
      FoodModel(name: 'Mie Instan', category: FoodCategory.lainnya, carbs: 52, protein: 10, fat: 20, calories: 436, rating: 1, description: 'Tinggi tepung', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Roti Tawar', category: FoodCategory.lainnya, carbs: 49, protein: 9, fat: 3.2, calories: 265, rating: 1, description: 'Tepung terigu', tips: 'HINDARI atau ganti roti keto'),
      FoodModel(name: 'Nasi Putih', category: FoodCategory.lainnya, carbs: 28, protein: 2.7, fat: 0.3, calories: 130, rating: 1, description: 'Makanan pokok', tips: 'HINDARI - ini yang dihindari di keto'),
      FoodModel(name: 'Gula Pasir', category: FoodCategory.lainnya, carbs: 100, protein: 0, fat: 0, calories: 387, rating: 1, description: 'Karbohidrat murni', tips: 'HINDARI - musuh utama keto'),
      FoodModel(name: 'Pemanis Stevia', category: FoodCategory.lainnya, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Pemanis alami zero carb', tips: 'Alternatif gula terbaik untuk keto'),
      FoodModel(name: 'Erythritol', category: FoodCategory.lainnya, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Sugar alcohol keto-friendly', tips: 'Tidak mempengaruhi gula darah'),
      FoodModel(name: 'Monk Fruit', category: FoodCategory.lainnya, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Pemanis buah natural', tips: 'Sangat manis, pakai sedikit'),
      FoodModel(name: 'Xylitol', category: FoodCategory.lainnya, carbs: 2.4, protein: 0, fat: 0, calories: 10, rating: 3, description: 'Sugar alcohol', tips: 'Boleh tapi batasi, bisa pencahar'),
      FoodModel(name: 'Psyllium Husk', category: FoodCategory.lainnya, carbs: 8, protein: 0, fat: 0, calories: 30, rating: 4, description: 'Serat larut', tips: 'Bagus untuk pencernaan dan baking keto'),
      FoodModel(name: 'Tepung Almond', category: FoodCategory.lainnya, carbs: 10, protein: 21, fat: 50, calories: 571, rating: 4, description: 'Tepung keto', tips: 'Pengganti tepung terigu untuk baking'),
      FoodModel(name: 'Tepung Kelapa', category: FoodCategory.lainnya, carbs: 21, protein: 18, fat: 16, calories: 354, rating: 4, description: 'Tepung tinggi serat', tips: 'Serap banyak cairan, pakai sedikit'),
      FoodModel(name: 'Cuka Apel', category: FoodCategory.lainnya, carbs: 0.1, protein: 0, fat: 0, calories: 3, rating: 4, description: 'Apple cider vinegar', tips: 'Detox, 1 sdm dalam air hangat'),

      // SAYURAN (35 items)
      FoodModel(name: 'Bayam', category: FoodCategory.sayuran, carbs: 1.4, protein: 2.9, fat: 0.4, calories: 23, rating: 4, description: 'Kaya zat besi', tips: 'Tumis dengan bawang putih'),
      FoodModel(name: 'Kangkung', category: FoodCategory.sayuran, carbs: 2, protein: 3, fat: 0.3, calories: 19, rating: 4, description: 'Sayur populer Indonesia', tips: 'Tumis cah atau plecing'),
      FoodModel(name: 'Sawi Hijau', category: FoodCategory.sayuran, carbs: 2.2, protein: 1.5, fat: 0.2, calories: 13, rating: 4, description: 'Rendah kalori', tips: 'Tumis atau sup'),
      FoodModel(name: 'Brokoli', category: FoodCategory.sayuran, carbs: 7, protein: 2.8, fat: 0.4, calories: 34, rating: 4, description: 'Superfood cruciferous', tips: 'Steam atau tumis'),
      FoodModel(name: 'Kembang Kol', category: FoodCategory.sayuran, carbs: 5, protein: 1.9, fat: 0.3, calories: 25, rating: 4, description: 'Pengganti nasi', tips: 'Bikin cauliflower rice'),
      FoodModel(name: 'Kubis', category: FoodCategory.sayuran, carbs: 5.8, protein: 1.3, fat: 0.1, calories: 25, rating: 4, description: 'Kol/kubis rendah karbo', tips: 'Coleslaw dengan mayo'),
      FoodModel(name: 'Selada', category: FoodCategory.sayuran, carbs: 2.9, protein: 1.4, fat: 0.2, calories: 15, rating: 4, description: 'Dasar salad', tips: 'Salad dengan olive oil'),
      FoodModel(name: 'Timun', category: FoodCategory.sayuran, carbs: 3.6, protein: 0.7, fat: 0.1, calories: 16, rating: 4, description: 'Sangat rendah kalori', tips: 'Lalapan atau acar'),
      FoodModel(name: 'Tomat', category: FoodCategory.sayuran, carbs: 3.9, protein: 0.9, fat: 0.2, calories: 18, rating: 4, description: 'Kaya likopen', tips: 'Batasi porsi, ada gula alami'),
      FoodModel(name: 'Terong', category: FoodCategory.sayuran, carbs: 5.9, protein: 1, fat: 0.2, calories: 25, rating: 4, description: 'Serat tinggi', tips: 'Bakar atau tumis balado'),
      FoodModel(name: 'Labu Siam', category: FoodCategory.sayuran, carbs: 4.5, protein: 0.8, fat: 0.1, calories: 19, rating: 4, description: 'Sayur lokal bergizi', tips: 'Tumis atau sayur asem'),
      FoodModel(name: 'Pare', category: FoodCategory.sayuran, carbs: 4.3, protein: 1, fat: 0.2, calories: 17, rating: 4, description: 'Menurunkan gula darah', tips: 'Tumis atau isi'),
      FoodModel(name: 'Wortel', category: FoodCategory.sayuran, carbs: 9.6, protein: 0.9, fat: 0.2, calories: 41, rating: 3, description: 'Tinggi vitamin A', tips: 'Batasi porsi, agak tinggi karbo'),
      FoodModel(name: 'Kacang Panjang', category: FoodCategory.sayuran, carbs: 8, protein: 2.6, fat: 0.4, calories: 47, rating: 4, description: 'Serat tinggi', tips: 'Tumis atau pecel'),
      FoodModel(name: 'Buncis', category: FoodCategory.sayuran, carbs: 7, protein: 1.8, fat: 0.2, calories: 31, rating: 4, description: 'Mirip kacang panjang', tips: 'Tumis mentega'),
      FoodModel(name: 'Jamur Tiram', category: FoodCategory.sayuran, carbs: 4, protein: 3, fat: 0.4, calories: 33, rating: 4, description: 'Tekstur seperti daging', tips: 'Tumis kriuk atau sup'),
      FoodModel(name: 'Jamur Merang', category: FoodCategory.sayuran, carbs: 4.3, protein: 2.8, fat: 0.8, calories: 35, rating: 4, description: 'Jamur dalam kaleng', tips: 'Cap cay atau tumis'),
      FoodModel(name: 'Jamur Kancing', category: FoodCategory.sayuran, carbs: 3.3, protein: 3.1, fat: 0.3, calories: 22, rating: 4, description: 'Champignon', tips: 'Tumis butter atau pizza topping'),
      FoodModel(name: 'Tauge', category: FoodCategory.sayuran, carbs: 5.9, protein: 3, fat: 0.2, calories: 30, rating: 4, description: 'Kecambah kacang hijau', tips: 'Rebus sebentar, jangan terlalu lama'),
      FoodModel(name: 'Daun Singkong', category: FoodCategory.sayuran, carbs: 7, protein: 6.8, fat: 1.2, calories: 73, rating: 4, description: 'Tinggi protein untuk sayur', tips: 'Tumis atau gulai'),
      FoodModel(name: 'Paprika', category: FoodCategory.sayuran, carbs: 6, protein: 1, fat: 0.3, calories: 31, rating: 4, description: 'Kaya vitamin C', tips: 'Tumis atau salad'),
      FoodModel(name: 'Seledri', category: FoodCategory.sayuran, carbs: 3, protein: 0.7, fat: 0.2, calories: 16, rating: 4, description: 'Sangat rendah kalori', tips: 'Taburan sup atau jus'),
      FoodModel(name: 'Daun Bawang', category: FoodCategory.sayuran, carbs: 7.3, protein: 1.8, fat: 0.2, calories: 32, rating: 4, description: 'Penyedap masakan', tips: 'Taburan hampir semua masakan'),
      FoodModel(name: 'Kol Ungu', category: FoodCategory.sayuran, carbs: 7.4, protein: 1.4, fat: 0.2, calories: 31, rating: 4, description: 'Antioksidan tinggi', tips: 'Coleslaw warna-warni'),
      FoodModel(name: 'Pakcoy', category: FoodCategory.sayuran, carbs: 2.2, protein: 1.5, fat: 0.2, calories: 13, rating: 4, description: 'Sawi oriental', tips: 'Tumis simple atau sup'),
      FoodModel(name: 'Kailan', category: FoodCategory.sayuran, carbs: 4.6, protein: 2.8, fat: 0.6, calories: 35, rating: 4, description: 'Chinese kale', tips: 'Tumis saus tiram (skip gula)'),
      FoodModel(name: 'Asparagus', category: FoodCategory.sayuran, carbs: 3.9, protein: 2.2, fat: 0.1, calories: 20, rating: 4, description: 'Sayur premium', tips: 'Panggang atau tumis butter'),
      FoodModel(name: 'Zucchini', category: FoodCategory.sayuran, carbs: 3.1, protein: 1.2, fat: 0.3, calories: 17, rating: 4, description: 'Timun Jepang', tips: 'Bikin zoodles pengganti mie'),
      FoodModel(name: 'Lobak', category: FoodCategory.sayuran, carbs: 3.4, protein: 0.7, fat: 0.1, calories: 16, rating: 4, description: 'Radish putih', tips: 'Soup atau tumis'),
      FoodModel(name: 'Bawang Bombay', category: FoodCategory.sayuran, carbs: 9.3, protein: 1.1, fat: 0.1, calories: 40, rating: 3, description: 'Bumbu dasar', tips: 'Pakai secukupnya, jangan berlebihan'),
      FoodModel(name: 'Bawang Putih', category: FoodCategory.sayuran, carbs: 33, protein: 6.4, fat: 0.5, calories: 149, rating: 3, description: 'Bumbu wajib', tips: 'Pakai sedikit untuk aroma'),
      FoodModel(name: 'Cabai Hijau', category: FoodCategory.sayuran, carbs: 9.5, protein: 2, fat: 0.2, calories: 40, rating: 4, description: 'Pedas sehat', tips: 'Sambal mentah atau tumis'),
      FoodModel(name: 'Cabai Merah', category: FoodCategory.sayuran, carbs: 8.8, protein: 1.9, fat: 0.4, calories: 40, rating: 4, description: 'Kaya capsaicin', tips: 'Bakar metabolisme'),
      FoodModel(name: 'Kentang', category: FoodCategory.sayuran, carbs: 17, protein: 2, fat: 0.1, calories: 77, rating: 1, description: 'Tinggi pati', tips: 'HINDARI - terlalu tinggi karbo'),
      FoodModel(name: 'Ubi Jalar', category: FoodCategory.sayuran, carbs: 20, protein: 1.6, fat: 0.1, calories: 86, rating: 1, description: 'Makanan pokok alternatif', tips: 'HINDARI untuk keto ketat'),

      // BUAH (20 items)
      FoodModel(name: 'Alpukat', category: FoodCategory.buah, carbs: 8.5, protein: 2, fat: 15, calories: 160, rating: 4, description: 'Superfood keto', tips: 'Jus tanpa gula atau salad'),
      FoodModel(name: 'Kelapa Muda', category: FoodCategory.buah, carbs: 9, protein: 3.3, fat: 33, calories: 354, rating: 4, description: 'Elektrolit alami', tips: 'Air kelapa segar tanpa gula'),
      FoodModel(name: 'Stroberi', category: FoodCategory.buah, carbs: 7.7, protein: 0.7, fat: 0.3, calories: 32, rating: 3, description: 'Buah berry rendah gula', tips: 'Porsi kecil, 5-7 buah'),
      FoodModel(name: 'Raspberry', category: FoodCategory.buah, carbs: 12, protein: 1.2, fat: 0.7, calories: 52, rating: 3, description: 'Tinggi serat', tips: 'Topping yogurt'),
      FoodModel(name: 'Blackberry', category: FoodCategory.buah, carbs: 10, protein: 1.4, fat: 0.5, calories: 43, rating: 3, description: 'Antioksidan tinggi', tips: 'Camilan kecil'),
      FoodModel(name: 'Belimbing', category: FoodCategory.buah, carbs: 6.7, protein: 1, fat: 0.3, calories: 31, rating: 3, description: 'Buah tropis segar', tips: 'Rujak tanpa gula'),
      FoodModel(name: 'Jambu Air', category: FoodCategory.buah, carbs: 5.7, protein: 0.6, fat: 0.3, calories: 25, rating: 3, description: 'Rendah kalori', tips: 'Camilan segar, 1-2 buah'),
      FoodModel(name: 'Jambu Biji', category: FoodCategory.buah, carbs: 14.3, protein: 2.6, fat: 1, calories: 68, rating: 2, description: 'Vitamin C tinggi', tips: 'Batasi, agak tinggi gula'),
      FoodModel(name: 'Melon', category: FoodCategory.buah, carbs: 8, protein: 0.8, fat: 0.2, calories: 34, rating: 3, description: 'Segar dan berair', tips: 'Porsi sangat kecil'),
      FoodModel(name: 'Semangka', category: FoodCategory.buah, carbs: 7.6, protein: 0.6, fat: 0.2, calories: 30, rating: 3, description: 'Hidrasi tinggi', tips: 'Porsi kecil sebagai camilan'),
      FoodModel(name: 'Pepaya', category: FoodCategory.buah, carbs: 11, protein: 0.5, fat: 0.3, calories: 43, rating: 2, description: 'Melancarkan pencernaan', tips: 'Batasi konsumsi'),
      FoodModel(name: 'Mangga', category: FoodCategory.buah, carbs: 15, protein: 0.8, fat: 0.4, calories: 60, rating: 1, description: 'Tinggi gula', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Pisang', category: FoodCategory.buah, carbs: 23, protein: 1.1, fat: 0.3, calories: 89, rating: 1, description: 'Sumber energi cepat', tips: 'HINDARI - terlalu tinggi karbo'),
      FoodModel(name: 'Apel', category: FoodCategory.buah, carbs: 14, protein: 0.3, fat: 0.2, calories: 52, rating: 2, description: 'Buah populer', tips: 'Batasi, agak tinggi gula'),
      FoodModel(name: 'Jeruk', category: FoodCategory.buah, carbs: 12, protein: 0.9, fat: 0.1, calories: 47, rating: 2, description: 'Vitamin C tinggi', tips: 'Satu jeruk kecil oke'),
      FoodModel(name: 'Anggur', category: FoodCategory.buah, carbs: 18, protein: 0.7, fat: 0.2, calories: 69, rating: 1, description: 'Tinggi gula', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Nanas', category: FoodCategory.buah, carbs: 13, protein: 0.5, fat: 0.1, calories: 50, rating: 2, description: 'Enzim bromelain', tips: 'Batasi porsi sangat kecil'),
      FoodModel(name: 'Durian', category: FoodCategory.buah, carbs: 27, protein: 1.5, fat: 5.3, calories: 147, rating: 1, description: 'Raja buah tinggi kalori', tips: 'HINDARI - tinggi karbo dan kalori'),
      FoodModel(name: 'Salak', category: FoodCategory.buah, carbs: 21, protein: 0.4, fat: 0.4, calories: 82, rating: 1, description: 'Buah lokal', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Lemon', category: FoodCategory.buah, carbs: 9, protein: 1.1, fat: 0.3, calories: 29, rating: 4, description: 'Detox alami', tips: 'Air lemon tanpa gula sangat baik'),

      // KACANG & BIJI (15 items)
      FoodModel(name: 'Kacang Almond', category: FoodCategory.kacang, carbs: 22, protein: 21, fat: 49, calories: 579, rating: 4, description: 'Kaya vitamin E', tips: 'Camilan sehat, 10-15 butir'),
      FoodModel(name: 'Kacang Mete', category: FoodCategory.kacang, carbs: 30, protein: 18, fat: 44, calories: 553, rating: 3, description: 'Agak tinggi karbo', tips: 'Batasi porsi, 5-8 butir'),
      FoodModel(name: 'Kacang Tanah', category: FoodCategory.kacang, carbs: 16, protein: 26, fat: 49, calories: 567, rating: 3, description: 'Protein tinggi', tips: 'Rebus lebih baik dari goreng'),
      FoodModel(name: 'Kacang Kenari', category: FoodCategory.kacang, carbs: 14, protein: 15, fat: 65, calories: 654, rating: 4, description: 'Omega-3 tinggi', tips: 'Camilan premium'),
      FoodModel(name: 'Kacang Macadamia', category: FoodCategory.kacang, carbs: 14, protein: 8, fat: 76, calories: 718, rating: 4, description: 'Lemak sehat tinggi', tips: 'Snack terbaik untuk keto'),
      FoodModel(name: 'Kacang Brazil', category: FoodCategory.kacang, carbs: 12, protein: 14, fat: 66, calories: 656, rating: 4, description: 'Selenium super tinggi', tips: 'Cukup 2-3 butir per hari'),
      FoodModel(name: 'Kacang Pistachio', category: FoodCategory.kacang, carbs: 28, protein: 20, fat: 45, calories: 560, rating: 3, description: 'Kaya antioksidan', tips: 'Batasi 10-15 butir'),
      FoodModel(name: 'Biji Bunga Matahari', category: FoodCategory.kacang, carbs: 20, protein: 21, fat: 51, calories: 584, rating: 3, description: 'Kwaci', tips: 'Camilan, skip yang bergula'),
      FoodModel(name: 'Biji Labu', category: FoodCategory.kacang, carbs: 11, protein: 30, fat: 49, calories: 559, rating: 4, description: 'Zinc tinggi', tips: 'Panggang tanpa garam berlebih'),
      FoodModel(name: 'Biji Chia', category: FoodCategory.kacang, carbs: 42, protein: 17, fat: 31, calories: 486, rating: 4, description: 'Serat super tinggi', tips: '1-2 sdm dalam smoothie'),
      FoodModel(name: 'Biji Rami', category: FoodCategory.kacang, carbs: 29, protein: 18, fat: 42, calories: 534, rating: 4, description: 'Flaxseed omega-3', tips: 'Giling sebelum konsumsi'),
      FoodModel(name: 'Wijen', category: FoodCategory.kacang, carbs: 23, protein: 18, fat: 50, calories: 573, rating: 4, description: 'Kalsium tinggi', tips: 'Taburan salad atau tumisan'),
      FoodModel(name: 'Kacang Merah', category: FoodCategory.kacang, carbs: 63, protein: 24, fat: 0.8, calories: 333, rating: 1, description: 'Tinggi karbohidrat', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Kacang Hijau', category: FoodCategory.kacang, carbs: 63, protein: 24, fat: 1.2, calories: 347, rating: 1, description: 'Tinggi pati', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Edamame', category: FoodCategory.kacang, carbs: 9, protein: 11, fat: 5, calories: 122, rating: 3, description: 'Kedelai Jepang', tips: 'Rebus dengan garam, porsi kecil'),

      // SUSU & PRODUK (20 items)
      FoodModel(name: 'Keju Cheddar', category: FoodCategory.susu, carbs: 1.3, protein: 25, fat: 33, calories: 402, rating: 4, description: 'Tinggi lemak dan protein', tips: 'Topping atau camilan'),
      FoodModel(name: 'Keju Mozzarella', category: FoodCategory.susu, carbs: 2.2, protein: 22, fat: 22, calories: 280, rating: 4, description: 'Keju pizza', tips: 'Leleh di atas daging'),
      FoodModel(name: 'Keju Parmesan', category: FoodCategory.susu, carbs: 4.1, protein: 36, fat: 25, calories: 431, rating: 4, description: 'Keju keras', tips: 'Taburan pasta shirataki'),
      FoodModel(name: 'Keju Cream', category: FoodCategory.susu, carbs: 4, protein: 6, fat: 34, calories: 342, rating: 4, description: 'Krim keju', tips: 'Spread atau saus'),
      FoodModel(name: 'Mentega', category: FoodCategory.susu, carbs: 0.1, protein: 0.9, fat: 81, calories: 717, rating: 4, description: 'Lemak murni', tips: 'Masak atau olesan'),
      FoodModel(name: 'Ghee', category: FoodCategory.susu, carbs: 0, protein: 0, fat: 100, calories: 900, rating: 4, description: 'Clarified butter', tips: 'Tahan panas tinggi'),
      FoodModel(name: 'Yogurt Plain', category: FoodCategory.susu, carbs: 4.7, protein: 10, fat: 3.3, calories: 61, rating: 3, description: 'Probiotik', tips: 'Pilih full fat, tanpa gula'),
      FoodModel(name: 'Yogurt Greek', category: FoodCategory.susu, carbs: 3.6, protein: 10, fat: 5, calories: 97, rating: 4, description: 'Protein lebih tinggi', tips: 'Plain full fat terbaik'),
      FoodModel(name: 'Krim Kental', category: FoodCategory.susu, carbs: 3, protein: 2.1, fat: 37, calories: 345, rating: 4, description: 'Heavy cream', tips: 'Untuk kopi atau masakan'),
      FoodModel(name: 'Susu Sapi Full Cream', category: FoodCategory.susu, carbs: 5, protein: 3.4, fat: 3.5, calories: 61, rating: 3, description: 'Susu murni', tips: 'Batasi 1 gelas per hari'),
      FoodModel(name: 'Susu Almond', category: FoodCategory.susu, carbs: 1.5, protein: 1, fat: 2.5, calories: 30, rating: 4, description: 'Alternatif rendah karbo', tips: 'Pilih unsweetened'),
      FoodModel(name: 'Santan Kelapa', category: FoodCategory.susu, carbs: 6, protein: 2.3, fat: 24, calories: 230, rating: 4, description: 'Lemak MCT', tips: 'Kare atau gulai tanpa gula'),
      FoodModel(name: 'Susu Kental Manis', category: FoodCategory.susu, carbs: 55, protein: 8, fat: 9, calories: 321, rating: 1, description: 'Sangat tinggi gula', tips: 'HINDARI sepenuhnya'),
      FoodModel(name: 'Susu Kedelai', category: FoodCategory.susu, carbs: 1.7, protein: 3.3, fat: 1.8, calories: 33, rating: 3, description: 'Alternatif nabati', tips: 'Pilih tanpa gula'),
      FoodModel(name: 'Es Krim', category: FoodCategory.susu, carbs: 24, protein: 3.5, fat: 11, calories: 207, rating: 1, description: 'Dessert tinggi gula', tips: 'HINDARI atau bikin versi keto'),
      FoodModel(name: 'Whey Protein', category: FoodCategory.susu, carbs: 3, protein: 80, fat: 2, calories: 354, rating: 4, description: 'Suplemen protein', tips: 'Post workout atau smoothie'),
      FoodModel(name: 'Keju Feta', category: FoodCategory.susu, carbs: 4.1, protein: 14, fat: 21, calories: 264, rating: 4, description: 'Keju Yunani', tips: 'Salad mediterania'),
      FoodModel(name: 'Keju Cottage', category: FoodCategory.susu, carbs: 3.4, protein: 11, fat: 4.3, calories: 98, rating: 4, description: 'Rendah kalori', tips: 'Camilan protein'),
      FoodModel(name: 'Susu Coklat', category: FoodCategory.susu, carbs: 26, protein: 8, fat: 8, calories: 208, rating: 1, description: 'Minuman tinggi gula', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Butter Milk', category: FoodCategory.susu, carbs: 4.8, protein: 3.3, fat: 0.9, calories: 40, rating: 3, description: 'Susu fermentasi', tips: 'Marinade ayam'),

      // MINYAK & LEMAK (15 items)
      FoodModel(name: 'Minyak Kelapa', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 862, rating: 4, description: 'MCT tinggi', tips: 'Terbaik untuk keto'),
      FoodModel(name: 'Minyak Zaitun', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 4, description: 'Lemak sehat', tips: 'Extra virgin untuk salad'),
      FoodModel(name: 'Minyak Alpukat', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 4, description: 'Tahan panas tinggi', tips: 'Menumis atau memanggang'),
      FoodModel(name: 'Minyak MCT', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 855, rating: 4, description: 'Energi cepat', tips: 'Tambah ke kopi atau smoothie'),
      FoodModel(name: 'Minyak Wijen', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 4, description: 'Aroma khas', tips: 'Finishing oil'),
      FoodModel(name: 'Minyak Goreng Sawit', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 3, description: 'Minyak umum', tips: 'Ganti dengan kelapa lebih baik'),
      FoodModel(name: 'Minyak Kanola', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 3, description: 'Netral', tips: 'Oke untuk menumis'),
      FoodModel(name: 'Lemak Sapi', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 902, rating: 4, description: 'Tallow', tips: 'Tahan panas sangat tinggi'),
      FoodModel(name: 'Minyak Biji Rami', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 4, description: 'Omega-3', tips: 'Jangan dipanaskan'),
      FoodModel(name: 'Mayones', category: FoodCategory.minyak, carbs: 0.6, protein: 1.4, fat: 79, calories: 680, rating: 4, description: 'Saus keto friendly', tips: 'Pilih yang tanpa gula'),
      FoodModel(name: 'Minyak Kacang', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 884, rating: 3, description: 'Aroma kacang', tips: 'Untuk tumis oriental'),
      FoodModel(name: 'Minyak Jagung', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 900, rating: 2, description: 'Omega-6 tinggi', tips: 'Kurang ideal untuk keto'),
      FoodModel(name: 'Margarin', category: FoodCategory.minyak, carbs: 0.8, protein: 0.2, fat: 80, calories: 717, rating: 2, description: 'Trans fat', tips: 'Ganti dengan butter'),
      FoodModel(name: 'Minyak Ikan', category: FoodCategory.minyak, carbs: 0, protein: 0, fat: 100, calories: 902, rating: 4, description: 'Omega-3 suplemen', tips: 'Kapsul atau cair'),

      // BUMBU & REMPAH (20 items)
      FoodModel(name: 'Garam', category: FoodCategory.bumbu, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Elektrolit penting', tips: 'Penting untuk keto flu'),
      FoodModel(name: 'Merica Hitam', category: FoodCategory.bumbu, carbs: 64, protein: 10, fat: 3.3, calories: 251, rating: 4, description: 'Pakai sedikit', tips: 'Meningkatkan penyerapan nutrisi'),
      FoodModel(name: 'Kunyit', category: FoodCategory.bumbu, carbs: 3.2, protein: 2.8, fat: 1.3, calories: 29, rating: 4, description: 'Anti-inflamasi', tips: 'Jamu atau masakan'),
      FoodModel(name: 'Jahe', category: FoodCategory.bumbu, carbs: 18, protein: 1.8, fat: 0.8, calories: 80, rating: 4, description: 'Hangatkan tubuh', tips: 'Wedang jahe tanpa gula'),
      FoodModel(name: 'Lengkuas', category: FoodCategory.bumbu, carbs: 15, protein: 1, fat: 0.3, calories: 71, rating: 4, description: 'Aroma khas', tips: 'Bumbu kari atau sup'),
      FoodModel(name: 'Serai', category: FoodCategory.bumbu, carbs: 25, protein: 1.8, fat: 0.5, calories: 99, rating: 4, description: 'Aroma segar', tips: 'Memarkan dan buang sebelum dimakan'),
      FoodModel(name: 'Daun Jeruk', category: FoodCategory.bumbu, carbs: 11, protein: 1.5, fat: 0.5, calories: 53, rating: 4, description: 'Wangi citrus', tips: 'Iris halus atau buang setelah masak'),
      FoodModel(name: 'Daun Salam', category: FoodCategory.bumbu, carbs: 75, protein: 7.6, fat: 8.4, calories: 313, rating: 4, description: 'Bumbu rebusan', tips: 'Buang sebelum dimakan'),
      FoodModel(name: 'Ketumbar', category: FoodCategory.bumbu, carbs: 55, protein: 12, fat: 18, calories: 298, rating: 4, description: 'Biji atau daun', tips: 'Bumbu kari'),
      FoodModel(name: 'Jintan', category: FoodCategory.bumbu, carbs: 44, protein: 18, fat: 22, calories: 375, rating: 4, description: 'Cumin', tips: 'Bumbu daging'),
      FoodModel(name: 'Pala', category: FoodCategory.bumbu, carbs: 49, protein: 5.8, fat: 36, calories: 525, rating: 4, description: 'Parut sedikit', tips: 'Sup atau kue keto'),
      FoodModel(name: 'Cengkeh', category: FoodCategory.bumbu, carbs: 61, protein: 6, fat: 20, calories: 323, rating: 4, description: 'Aroma kuat', tips: 'Sedikit saja cukup'),
      FoodModel(name: 'Kayu Manis', category: FoodCategory.bumbu, carbs: 81, protein: 4, fat: 1.2, calories: 247, rating: 4, description: 'Cinnamon', tips: 'Kopi atau smoothie'),
      FoodModel(name: 'Vanili', category: FoodCategory.bumbu, carbs: 13, protein: 0.1, fat: 0.1, calories: 12, rating: 4, description: 'Ekstrak atau polong', tips: 'Dessert keto'),
      FoodModel(name: 'Kemiri', category: FoodCategory.bumbu, carbs: 8, protein: 19, fat: 66, calories: 684, rating: 4, description: 'Pengental bumbu', tips: 'Bumbu pecel atau rendang'),
      FoodModel(name: 'Kecap Manis', category: FoodCategory.bumbu, carbs: 33, protein: 5.6, fat: 0.1, calories: 154, rating: 1, description: 'Sangat tinggi gula', tips: 'HINDARI atau ganti kecap asin'),
      FoodModel(name: 'Kecap Asin', category: FoodCategory.bumbu, carbs: 8, protein: 5.5, fat: 0, calories: 53, rating: 3, description: 'Rendah gula', tips: 'Gunakan secukupnya'),
      FoodModel(name: 'Saus Tiram', category: FoodCategory.bumbu, carbs: 18, protein: 2.1, fat: 0.5, calories: 81, rating: 2, description: 'Mengandung gula', tips: 'Batasi penggunaan'),
      FoodModel(name: 'Saus Sambal', category: FoodCategory.bumbu, carbs: 12, protein: 1.5, fat: 0.3, calories: 55, rating: 3, description: 'Pedas', tips: 'Cek label, pilih low sugar'),
      FoodModel(name: 'Terasi', category: FoodCategory.bumbu, carbs: 8, protein: 25, fat: 5, calories: 176, rating: 4, description: 'Umami kuat', tips: 'Sambal terasi keto friendly'),

      // MINUMAN (20 items)
      FoodModel(name: 'Air Putih', category: FoodCategory.minuman, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Hidrasi penting', tips: 'Minum 2-3 liter per hari'),
      FoodModel(name: 'Kopi Hitam', category: FoodCategory.minuman, carbs: 0, protein: 0.3, fat: 0, calories: 2, rating: 4, description: 'Tanpa gula', tips: 'Boost energi dan metabolisme'),
      FoodModel(name: 'Teh Hijau', category: FoodCategory.minuman, carbs: 0, protein: 0, fat: 0, calories: 1, rating: 4, description: 'Antioksidan', tips: 'Tanpa gula, 2-3 cangkir sehari'),
      FoodModel(name: 'Teh Hitam', category: FoodCategory.minuman, carbs: 0.3, protein: 0, fat: 0, calories: 1, rating: 4, description: 'Kafein lebih tinggi', tips: 'Tanpa gula tentunya'),
      FoodModel(name: 'Kopi Susu', category: FoodCategory.minuman, carbs: 9, protein: 6, fat: 6, calories: 120, rating: 3, description: 'Dengan susu', tips: 'Gunakan krim atau santan, tanpa gula'),
      FoodModel(name: 'Air Kelapa', category: FoodCategory.minuman, carbs: 9, protein: 1.7, fat: 0.2, calories: 46, rating: 3, description: 'Elektrolit alami', tips: 'Porsi kecil, 1 gelas max'),
      FoodModel(name: 'Jus Lemon', category: FoodCategory.minuman, carbs: 2, protein: 0.1, fat: 0, calories: 7, rating: 4, description: 'Detox', tips: 'Tanpa gula, campur air hangat'),
      FoodModel(name: 'Susu Almond Tanpa Gula', category: FoodCategory.minuman, carbs: 1.5, protein: 1, fat: 2.5, calories: 30, rating: 4, description: 'Alternatif susu', tips: 'Latte atau smoothie'),
      FoodModel(name: 'Bone Broth', category: FoodCategory.minuman, carbs: 0, protein: 6, fat: 2, calories: 50, rating: 4, description: 'Kaldu tulang', tips: 'Kaya kolagen dan elektrolit'),
      FoodModel(name: 'Teh Herbal', category: FoodCategory.minuman, carbs: 0.5, protein: 0, fat: 0, calories: 2, rating: 4, description: 'Chamomile, mint, dll', tips: 'Relaksasi tanpa kalori'),
      FoodModel(name: 'Soda Diet', category: FoodCategory.minuman, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 2, description: 'Pemanis buatan', tips: 'Hindari jika bisa, picu nafsu makan'),
      FoodModel(name: 'Kombucha', category: FoodCategory.minuman, carbs: 7, protein: 0, fat: 0, calories: 30, rating: 3, description: 'Teh fermentasi', tips: 'Pilih low sugar, porsi kecil'),
      FoodModel(name: 'Bulletproof Coffee', category: FoodCategory.minuman, carbs: 0, protein: 1, fat: 30, calories: 300, rating: 4, description: 'Kopi + butter + MCT', tips: 'Sarapan keto sempurna'),
      FoodModel(name: 'Jus Jeruk', category: FoodCategory.minuman, carbs: 26, protein: 1.7, fat: 0.5, calories: 112, rating: 1, description: 'Tinggi gula alami', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Jus Apel', category: FoodCategory.minuman, carbs: 28, protein: 0.2, fat: 0.3, calories: 117, rating: 1, description: 'Sangat tinggi gula', tips: 'HINDARI sepenuhnya'),
      FoodModel(name: 'Teh Manis', category: FoodCategory.minuman, carbs: 25, protein: 0, fat: 0, calories: 100, rating: 1, description: 'Minuman bergula', tips: 'HINDARI untuk keto'),
      FoodModel(name: 'Es Teh Tawar', category: FoodCategory.minuman, carbs: 0.3, protein: 0, fat: 0, calories: 1, rating: 4, description: 'Tanpa gula', tips: 'Sempurna untuk keto'),
      FoodModel(name: 'Air Mineral', category: FoodCategory.minuman, carbs: 0, protein: 0, fat: 0, calories: 0, rating: 4, description: 'Dengan mineral', tips: 'Elektrolit alami'),
      FoodModel(name: 'Wedang Jahe', category: FoodCategory.minuman, carbs: 2, protein: 0.2, fat: 0, calories: 10, rating: 4, description: 'Tanpa gula', tips: 'Hangatkan tubuh'),
      FoodModel(name: 'Bir', category: FoodCategory.minuman, carbs: 13, protein: 1.6, fat: 0, calories: 153, rating: 1, description: 'Alkohol tinggi karbo', tips: 'HINDARI untuk keto'),

      // CEMILAN (15 items)
      FoodModel(name: 'Keripik Kale', category: FoodCategory.cemilan, carbs: 4, protein: 2, fat: 0.5, calories: 30, rating: 4, description: 'Snack sehat', tips: 'Panggang sendiri lebih baik'),
      FoodModel(name: 'Telur  Ayam', category: FoodCategory.telur, carbs: 0.6, protein: 13, fat: 11, calories: 155, rating: 4, description: 'Superfood untuk keto', tips: 'Rebus, ceplok, atau dadar'),
      FoodModel(name: 'Telur Bebek', category: FoodCategory.telur, carbs: 1.5, protein: 13, fat: 14, calories: 185, rating: 4, description: 'Lebih besar dari telur ayam', tips: 'Telur asin cocok untuk keto'),
      FoodModel(name: 'Telur Puyuh', category: FoodCategory.telur, carbs: 0.4, protein: 13, fat: 11, calories: 158, rating: 4, description: 'Ukuran mini, gizi sama', tips: 'Rebus untuk camilan'),
      FoodModel(name: 'Telur Asin', category: FoodCategory.telur, carbs: 0.5, protein: 14, fat: 13, calories: 180, rating: 4, description: 'Telur bebek yang diasinkan', tips: 'Lauk pendamping sayur'),
      FoodModel(name: 'Telur Dadar', category: FoodCategory.telur, carbs: 1, protein: 10, fat: 12, calories: 154, rating: 4, description: 'Praktis dan cepat', tips: 'Tambahkan sayuran'),
      FoodModel(name: 'Telur Ceplok', category: FoodCategory.telur, carbs: 0.6, protein: 13, fat: 15, calories: 196, rating: 4, description: 'Digoreng dengan minyak', tips: 'Gunakan minyak kelapa atau butter'),
      FoodModel(name: 'Telur Rebus', category: FoodCategory.telur, carbs: 1.1, protein: 13, fat: 11, calories: 155, rating: 4, description: 'Cara tersehat', tips: 'Rebus setengah matang lebih enak'),
      FoodModel(name: 'Telur Orak-arik', category: FoodCategory.telur, carbs: 1.5, protein: 11, fat: 13, calories: 166, rating: 4, description: 'Scrambled egg', tips: 'Tambah butter dan keju'),
      FoodModel(name: 'Telur Mata Sapi', category: FoodCategory.telur, carbs: 0.6, protein: 13, fat: 15, calories: 196, rating: 4, description: 'Ceplok 2 sisi', tips: 'Kuning setengah matang ideal'),
      FoodModel(name: 'Martabak Telur', category: FoodCategory.telur, carbs: 28, protein: 15, fat: 18, calories: 340, rating: 1, description: 'Mengandung tepung tinggi', tips: 'Hindari, terlalu banyak karbohidrat'),
    ];
  }
  
  // Get total food count
  static int getTotalFoodCount() {
    return getAllFoods().length;
  }
  
  // Get food count by category
  static int getFoodCountByCategory(FoodCategory category) {
    return getAllFoods().where((food) => food.category == category).length;
  }
  
  // Get food count by rating
  static int getFoodCountByRating(int rating) {
    return getAllFoods().where((food) => food.rating == rating).length;
  }
  
  // Get recommended foods (rating 4)
  static List<FoodModel> getRecommendedFoods() {
    return getAllFoods().where((food) => food.rating == 4).toList();
  }
  
  // Get foods to avoid (rating 1)
  static List<FoodModel> getFoodsToAvoid() {
    return getAllFoods().where((food) => food.rating == 1).toList();
  }
  
  // Get random food by rating
  static FoodModel? getRandomFoodByRating(int rating) {
    final foods = getAllFoods().where((food) => food.rating == rating).toList();
    if (foods.isEmpty) return null;
    foods.shuffle();
    return foods.first;
  }
  
  // Get foods by multiple categories
  static List<FoodModel> getFoodsByCategories(List<FoodCategory> categories) {
    return getAllFoods().where((food) => categories.contains(food.category)).toList();
  }
  
  // Search foods by name
  static List<FoodModel> searchFoodsByName(String query) {
    final lowerQuery = query.toLowerCase();
    return getAllFoods()
        .where((food) => food.name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}

      