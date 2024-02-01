class ParentKelurahan {
  //model class untuk parent dari data kelurahan berisi status code, message, dan juga value(list kelurahan)
  final String code;
  final String message;
  final List<Kelurahan> value;

  ParentKelurahan({
    required this.code,
    required this.message,
    required this.value,
  });

  factory ParentKelurahan.fromJson(Map<String, dynamic> json) {
    return ParentKelurahan(
      code: json['code'],
      message: json['messages'],
      value: (json['value'] as List)
          .map((item) => Kelurahan.fromJson(item))
          .toList(),
    );
  }
}

class Kelurahan {
  //model class untuk isi dari value parent kelurahan berisi id, idprovinsi, dan nama
  final String id;
  final String idKecamatan;
  final String name;

  Kelurahan({
    required this.id,
    required this.idKecamatan,
    required this.name,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) {
    return Kelurahan(
      id: json['id'],
      idKecamatan: json['id_kecamatan'],
      name: json['name'],
    );
  }
}
