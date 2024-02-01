class ParentKabupaten {
  //model class untuk parent dari data kabupaten berisi status code, message, dan juga value(list kabupaten)
  final String code;
  final String message;
  final List<Kabupaten> value;

  ParentKabupaten({
    required this.code,
    required this.message,
    required this.value,
  });

  factory ParentKabupaten.fromJson(Map<String, dynamic> json) {
    return ParentKabupaten(
      code: json['code'],
      message: json['messages'],
      value: (json['value'] as List)
          .map((item) => Kabupaten.fromJson(item))
          .toList(),
    );
  }
}

class Kabupaten {
  //model class untuk isi dari value parent kabupaten berisi id, idprovinsi, dan nama
  final String id;
  final String idProvinsi;
  final String name;

  Kabupaten({
    required this.id,
    required this.idProvinsi,
    required this.name,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) {
    return Kabupaten(
      id: json['id'],
      idProvinsi: json['id_provinsi'],
      name: json['name'],
    );
  }
}
