import 'dart:io';

// Struktur data utama untuk menampung seluruh data mahasiswa
List<Map<String, String>> dataMahasiswa = [];

void main() {
  // 1. Entri Data Mahasiswa (Minimal 10)
  entriDataMahasiswa();

  // 2. Cari dan Tampilkan Detail Mahasiswa
  cariDanTampilkanMahasiswa();
}

/// Fungsi untuk mengentri data minimal 10 mahasiswa
void entriDataMahasiswa() {
  final int jumlahMahasiswa = 10;
  print("--- Entri Data Mahasiswa (Minimal $jumlahMahasiswa) ---");

  for (int i = 0; i < jumlahMahasiswa; i++) {
    print("\nMasukkan data untuk Mahasiswa ke-${i + 1}:");

    // Input NIM (sebagai kunci pencarian)
    String nim;
    while (true) {
      stdout.write("NIM (Nomor Induk Mahasiswa): ");
      nim = stdin.readLineSync()?.trim() ?? '';

      if (nim.isEmpty) {
        print("NIM tidak boleh kosong.");
      } else if (dataMahasiswa.any((m) => m['NIM'] == nim)) {
        print("NIM sudah ada. Mohon masukkan NIM yang berbeda.");
      } else {
        break;
      }
    }

    stdout.write("Nama Lengkap: ");
    String nama = stdin.readLineSync()?.trim() ?? 'Data Kosong';

    stdout.write("Jurusan: ");
    String jurusan = stdin.readLineSync()?.trim() ?? 'Data Kosong';

    stdout.write("Tahun Angkatan (contoh: 2023): ");
    String angkatan = stdin.readLineSync()?.trim() ?? 'Data Kosong';

    // Menyimpan data dalam bentuk Map
    dataMahasiswa.add({
      'NIM': nim,
      'Nama': nama,
      'Jurusan': jurusan,
      'Angkatan': angkatan,
    });
  }
  print("\n--- Entri Data Selesai. ---");
}

/// Fungsi untuk mencari data mahasiswa berdasarkan NIM dan menampilkan detailnya
void cariDanTampilkanMahasiswa() {
  if (dataMahasiswa.isEmpty) {
    print("\nBelum ada data mahasiswa yang di entri.");
    return;
  }

  print("\n--- Pencarian Data Mahasiswa ---");
  stdout.write("Masukkan NIM Mahasiswa yang ingin dicari: ");
  String nimCari = stdin.readLineSync()?.trim() ?? '';

  // Mencari data menggunakan metode 'firstWhere'
  try {
    // Mencari Map mahasiswa yang NIM-nya sesuai dengan nimCari
    Map<String, String> mahasiswaDitemukan = dataMahasiswa.firstWhere(
      (m) => m['NIM'] == nimCari,
      // Jika tidak ditemukan, akan melempar StateError
      // Tapi kita akan tangkap dengan try-catch
    );

    print("\n--- Detail Mahasiswa Ditemukan ---");
    print("NIM: ${mahasiswaDitemukan['NIM']}");
    print("Nama: ${mahasiswaDitemukan['Nama']}");
    print("Jurusan: ${mahasiswaDitemukan['Jurusan']}");
    print("Tahun Angkatan: ${mahasiswaDitemukan['Angkatan']}");
    print("-----------------------------------");
    
  } on StateError {
    // StateError dilempar jika firstWhere tidak menemukan elemen
    print("\nMahasiswa dengan NIM '$nimCari' tidak ditemukan dalam data.");
  }
}