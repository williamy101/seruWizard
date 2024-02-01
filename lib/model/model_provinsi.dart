class ParentProvinsi {
  //model class untuk parent dari data provinsi berisi status code, message, dan juga value(list provinsi)
  final String code;
  final String message;
  final List<Provinsi> value;

  ParentProvinsi({
    required this.code,
    required this.message,
    required this.value,
  });

  factory ParentProvinsi.fromJson(Map<String, dynamic> json) {
    return ParentProvinsi(
      code: json['code'],
      message: json['messages'],
      value: (json['value'] as List)
          .map((item) => Provinsi.fromJson(item))
          .toList(),
    );
  }
}

class Provinsi {
  //model class untuk isi dari value parent provinsi berisi id, idprovinsi, dan nama
  final String id;
  final String name;

  Provinsi({
    required this.id,
    required this.name,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(
      id: json['id'],
      name: json['name'],
    );
  }
}
