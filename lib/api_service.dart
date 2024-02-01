import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seru_wizard/model/model_kabupaten.dart';
import 'package:seru_wizard/model/model_kecamatan.dart';
import 'package:seru_wizard/model/model_kelurahan.dart';
import 'package:seru_wizard/model/model_provinsi.dart';

class ApiService {
  final String apiKey =
      "8337cb9a1329cf13958780f54e3acc4b3cab5e084034128caf15f588480f28a4"; //api key untuk api wilayah indonesia dari binderbyte

  Future<List<Provinsi>> fetchProvinsi() async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.binderbyte.com/wilayah/provinsi?api_key=$apiKey")); //melakukan get untuk endpoint API data provinsi

      if (response.statusCode == 200) {
        //check jika status code 200(OK) maka melakukan decode response JSON ke model ParentProvinsi
        final jsonData = json.decode(response.body);
        ParentProvinsi parentProvinsi = ParentProvinsi.fromJson(jsonData);

        List<Provinsi> provinsiList = parentProvinsi
            .value; //lalu disini extract list provinsi dari parentprovinsi
        return provinsiList; //direturn
      } else {
        throw Exception(
            "HTTP Error: ${response.statusCode}"); //jika statuscode bukan 200 maka akan mengirimkan exception berisi statuscode yang ada
      }
    } catch (e) {
      //catch disini untuk menangkap error selama berjalannya http request dan di print ke console dan di throw
      print("Error fetching provinsi: $e");
      throw e;
    }
  }

  //sisanya sama hanya beda endpoint
  Future<List<Kabupaten>> fetchKabupaten(String idProvinsi) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.binderbyte.com/wilayah/kabupaten?api_key=$apiKey&id_provinsi=$idProvinsi")); //menggunakan id provinsi untuk mengakses kabupaten

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ParentKabupaten parentKabupaten = ParentKabupaten.fromJson(jsonData);

        List<Kabupaten> kabupatenList = parentKabupaten.value;
        return kabupatenList;
      } else {
        throw Exception("HTTP Error: ${response.statusCode}");
      }
    } catch (error) {
      print('Error fetching Kabupaten: $error');
      throw Exception('HTTP Error: $error');
    }
  }

  Future<List<Kecamatan>> fetchKecamatan(String idKabupaten) async {
    final response = await http.get(Uri.parse(
        "https://api.binderbyte.com/wilayah/kecamatan?api_key=$apiKey&id_kabupaten=$idKabupaten")); //menggunakan id kabupaten untuk mengakses kecamatan

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ParentKecamatan parentKecamatan = ParentKecamatan.fromJson(jsonData);

      List<Kecamatan> kecamatanList = parentKecamatan.value;

      return kecamatanList;
    } else {
      throw Exception("HTTP Error: ${response.statusCode}");
    }
  }

  Future<List<Kelurahan>> fetchKelurahan(String idKecamatan) async {
    final response = await http.get(Uri.parse(
        "https://api.binderbyte.com/wilayah/kelurahan?api_key=$apiKey&id_kecamatan=$idKecamatan")); //menggunakan id kecamatan untuk mengakses kelurahan

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ParentKelurahan parentKelurahan = ParentKelurahan.fromJson(jsonData);

      List<Kelurahan> kelurahanList = parentKelurahan.value;

      return kelurahanList;
    } else {
      throw Exception("HTTP Error: ${response.statusCode}");
    }
  }
}
