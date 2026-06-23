// model layer — tidak import package Flutter apapun, murni data dan logika

class SliderConfig {                                               // konfigurasi satu buah slider
  final String id;                                                 // id unik slider — dipakai sebagai key di Map
  final String label;                                              // label yang tampil di UI, misal "Ukuran"
  final String unit;                                               // satuan tampilan, misal "px" atau "%"
  final double min;                                                // nilai minimum slider
  final double max;                                                // nilai maksimum slider
  final double defaultValue;                                       // nilai awal saat app pertama dibuka
  final int divisions;                                             // jumlah langkah diskrit — null = slider kontinu

  const SliderConfig({                                             // const constructor — semua value diisi saat compile
    required this.id,
    required this.label,
    required this.unit,
    required this.min,
    required this.max,
    required this.defaultValue,
    required this.divisions,
  });
}

// daftar slider yang akan ditampilkan di layar — const karena tidak berubah saat runtime
const List<SliderConfig> sliderConfigs = [
  SliderConfig(
    id: 'size',                                                    // id untuk lookup nilai di Map state
    label: 'Ukuran Kotak',
    unit: 'px',
    min: 60,                                                       // kotak minimal 60×60px
    max: 240,                                                      // kotak maksimal 240×240px
    defaultValue: 120,                                             // mulai di tengah
    divisions: 18,                                                 // setiap langkah = 10px (240-60)/18
  ),
  SliderConfig(
    id: 'radius',
    label: 'Sudut Bulat',
    unit: 'px',
    min: 0,
    max: 60,
    defaultValue: 12,
    divisions: 12,                                                 // setiap langkah = 5px
  ),
  SliderConfig(
    id: 'opacity',
    label: 'Opacity',
    unit: '%',
    min: 10,                                                       // minimal 10% agar kotak masih terlihat
    max: 100,
    defaultValue: 100,
    divisions: 9,                                                  // setiap langkah = 10%
  ),
  SliderConfig(
    id: 'elevation',
    label: 'Ketinggian Bayangan',
    unit: 'dp',
    min: 0,
    max: 24,
    defaultValue: 8,
    divisions: 12,                                                 // setiap langkah = 2dp
  ),
];