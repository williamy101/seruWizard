class ParentKecamatan {
  //model class untuk parent dari data kecamatan berisi status code, message, dan juga value(list kecamatan)
  final String code;
  final String message;
  final List<Kecamatan> value;

  ParentKecamatan({
    required this.code,
    required this.message,
    required this.value,
  });

  factory ParentKecamatan.fromJson(Map<String, dynamic> json) {
    return ParentKecamatan(
      code: json['code'],
      message: json['messages'],
      value: (json['value'] as List)
          .map((item) => Kecamatan.fromJson(item))
          .toList(),
    );
  }
}

class Kecamatan {
  //model class untuk isi dari value parent kecamatan berisi id, idprovinsi, dan nama
  final String id;
  final String idKabupaten;
  final String name;

  Kecamatan({
    required this.id,
    required this.idKabupaten,
    required this.name,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) {
    return Kecamatan(
      id: json['id'],
      idKabupaten: json['id_kabupaten'],
      name: json['name'],
    );
  }
}
