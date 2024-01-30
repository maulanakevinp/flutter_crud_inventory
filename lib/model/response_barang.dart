class ResponseBarang {
  final String pesan;
  final bool sukses;
  final List<Barang>? barang;
  final int? lastId;

  ResponseBarang({
    required this.pesan,
    required this.sukses,
    this.barang,
    this.lastId,
  });

  factory ResponseBarang.fromJson(Map<String, dynamic> json) => ResponseBarang(
      pesan: json["pesan"],
      sukses: json["sukses"],
      barang: json["barang"] == null
          ? null
          : List<Barang>.from(json["barang"].map((x) => Barang.fromJson(x))),
      lastId: json['last_id']);
}

class Barang {
  final String? barangId;
  final String? barangNama;
  final String? barangJumlah;
  final String? barangGambar;

  Barang({
    this.barangId,
    this.barangNama,
    this.barangJumlah,
    this.barangGambar,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        barangId: json["barang_id"],
        barangNama: json["barang_nama"],
        barangJumlah: json["barang_jumlah"],
        barangGambar: json["barang_gambar"],
      );
}
