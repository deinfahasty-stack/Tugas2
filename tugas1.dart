double hitungRataRata(List<int> nilai) {
  if (nilai.isEmpty) return 0.0;
  int total = nilai.reduce((a, b) => a + b);
  return total / nilai.length;
}

String tentukanGrade(double rataRata) {
  if (rataRata >= 85) return 'A';
  if (rataRata >= 75) return 'B';
  if (rataRata >= 65) return 'C';
  if (rataRata >= 50) return 'D';
  return 'E';
}

bool cekKelulusan({required double rataRata, required int absensi}) {
  return rataRata >= 60 && absensi <= 3;
}

void main() {
  List<Map<String, dynamic>> mahasiswa = [
    {
      'nama' : 'Asty',
      'nilai': [85,90,78,92,88],
      'absensi' : 2
    },
    {
      'nama' : 'widya',
      'nilai' : [55,60,58,52,45],
      'absensi' : 1
    },
    {
      'nama' : 'teguh',
      'nilai' : [70,75,88,65,78],
      'absensi' : 4
    },
    {
      'nama' : 'laudya',
      'nilai' : [55,70,88,52,78],
      'absensi' : 0
    },
    {
      'nama' : 'arya',
      'nilai' : [95,90,78,52,78],
      'absensi' : 3
    },
  ];

  print(' LAPORAN NILAI MAHASISWA \n');

  List<int> semuaNilai = [];
  double totalRataRataKelas = 0.0;

  for (var mhs in mahasiswa) {
    String nama = mhs['nama'];
    List<int> nilai = mhs['nilai'];
    int absensi = mhs['absensi'];

    semuaNilai.addAll(nilai);

    double rataRata = hitungRataRata(nilai);
    String grade = tentukanGrade(rataRata);
    bool lulus = cekKelulusan(rataRata: rataRata, absensi: absensi);

    totalRataRataKelas += rataRata;

    print('Nama : $nama');
    print('Nilai : $nilai');
    print('Rata-rata : ${rataRata.toStringAsFixed(1)}');
    print('Grade : $grade');
    print('Status : ${lulus? 'LULUS' : 'TIDAK LULUS'}');
    print('');
  }

  int nilaiTertinggi = semuaNilai.reduce((a,b) => a > b ? a : b);
  int nilaiTerendah = semuaNilai.reduce((a,b) => a < b ? a : b);
  double rataRataKelas = totalRataRataKelas / mahasiswa.length;

  print(' === STATISTIK KELAS ===');
  print('Nilai Tertinggi : $nilaiTertinggi');
  print('Nilai Terendah : $nilaiTerendah');
  print('Rata-rata Kelas : ${rataRataKelas.toStringAsFixed(1)}');
}
