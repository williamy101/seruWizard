import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:seru_wizard/api_service.dart';
import 'package:seru_wizard/config/app_color.dart';
import 'package:seru_wizard/config/app_route.dart';
import 'package:seru_wizard/model/model_kabupaten.dart';
import 'package:seru_wizard/model/model_kecamatan.dart';
import 'package:seru_wizard/model/model_kelurahan.dart';
import 'package:seru_wizard/model/model_provinsi.dart';
import 'package:seru_wizard/widget/button_custom.dart';

class WizardOne extends StatefulWidget {
  WizardOne({Key? key}) : super(key: key);

  @override
  State<WizardOne> createState() => _WizardOneState();
}

class _WizardOneState extends State<WizardOne> {
  //formkey sebagai key dari widget Form
  final formKey = GlobalKey<FormState>();

  //controller untuk pengelolaan value textformfield
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _biodataController = TextEditingController();
  final TextEditingController _searchControllerProv = TextEditingController();
  final TextEditingController _searchControllerKab = TextEditingController();
  final TextEditingController _searchControllerKec = TextEditingController();
  final TextEditingController _searchControllerKel = TextEditingController();

  //instance dari class ApiService
  ApiService apiService = ApiService();

  //List untuk menyimpan data2 yang diambil dari API
  List<Provinsi> provinsiList = [];
  List<Kabupaten> kabupatenList = [];
  List<Kecamatan> kecamatanList = [];
  List<Kelurahan> kelurahanList = [];

  //variabel untuk menyimpan ID yang dipilih dari dropdown
  String? getProv;
  String? getKab;
  String? getKec;
  String? getKel;

  @override
  void initState() {
    super.initState();
    //memanggil fungsi fetchData saat memulai/inisialisasi state
    fetchData();
  }

  //fungsi untuk mengambil data dari API
  Future<void> fetchData() async {
    //fetch data provinsi
    provinsiList = await apiService.fetchProvinsi();

    //jika provinsi tidak kosong, fetch kabupaten
    if (provinsiList.isNotEmpty) {
      setState(() {});
      kabupatenList = await apiService.fetchKabupaten(provinsiList.first.id);
    }

    //jika kabupaten tidak kosong, fetch kecamatan
    if (kabupatenList.isNotEmpty) {
      setState(() {});
      kecamatanList = await apiService.fetchKecamatan(kabupatenList.first.id);
    }

    //jika kecamatan tidak kosong, ambil kelurahan
    if (kecamatanList.isNotEmpty) {
      setState(() {});
      kelurahanList = await apiService.fetchKelurahan(kecamatanList.first.id);
    }

    //update tampilan
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColor.primary,
        title: Text(
          'Data Diri',
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey[200]!,
                          width: 0.4,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(children: [
                        Row(
                          children: [
                            //membuat textformfield nama depan, menggunakan TextFormField karena menyediakan validator
                            //Expanded disini agar textfield nama depan dan belakang ukurannya menyesuaikan layar dan konfigurasi yang ada
                            Expanded(
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                  label: Text(
                                    'Nama Depan',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama depan tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                }, //validator ini agar muncul error message ketika value kosong
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.secondary,
                                      width: 1.0,
                                    ),
                                  ),
                                  label: Text(
                                    'Nama Belakang',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama belakang tidak boleh kosong';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _biodataController,
                          maxLines:
                              4, //maxlines diatur 4 agar textformfield menjadi text area.
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                                width: 1.0,
                              ),
                            ),
                            label: Text(
                              'Biodata',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Biodata tidak boleh kosong';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Pilih Provinsi'),
                        ),
                        const SizedBox(height: 4.0),
                        //dropdownsearch untuk membuat dropdown dengan properti search
                        DropdownSearch<Provinsi>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          dropdownSearchDecoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          itemAsString: (Provinsi? provinsi) => provinsi!
                              .name, //itemasstring agar item dropdown disini berisikan nama provinsi dari API
                          items:
                              provinsiList, //menempatkan data provinsi yang diambil dari API
                          compareFn: (item, selectedItem) =>
                              item!.id ==
                              selectedItem!
                                  .id, //comparefn membandingkan item berdasarkan id nya
                          onChanged: (Provinsi? provinsi) async {
                            if (provinsi != null) {
                              setState(() {
                                getKab = null;
                                getProv = provinsi.id;
                              }); //tiap kali salah satu provinsi dipilih maka dropdown kabupaten di set ke null dan id provinsi diambil

                              kabupatenList = await apiService.fetchKabupaten(
                                  provinsi
                                      .id); //id provinsi yang diambil dikirimkan ke fungsi fetch data kabupaten
                              setState(() {}); //update tampilan
                            }
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _searchControllerProv,
                            autofocus: true,
                            enabled:
                                true, /*menggunakan textfieldprops untuk agar bisa mengatur behaviour textfield, 
                                disini diberikan controller agar bisa dikelola valuenya*/
                          ),
                          isFilteredOnline:
                              true, //di set ke true agar filtering dapat dilakukan secara online/langsung
                          onFind: (String? filter) async {
                            return provinsiList
                                .where((provinsi) => provinsi.name
                                    .toLowerCase()
                                    .contains(filter!.toLowerCase()))
                                .toList(); //memfilter nama provinsi, tolowercase agar case insensitive
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Provinsi harus dipilih';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Pilih Kabupaten'),
                        ),
                        const SizedBox(height: 4.0),
                        DropdownSearch<Kabupaten>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          dropdownSearchDecoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          itemAsString: (Kabupaten? kabupaten) =>
                              kabupaten!.name,
                          items: kabupatenList,
                          compareFn: (item, selectedItem) =>
                              item!.id == selectedItem?.id,
                          onChanged: (Kabupaten? kabupaten) async {
                            if (kabupaten != null) {
                              setState(() {
                                getKec = null;
                                getKab = kabupaten.id;
                              });
                              kecamatanList =
                                  await apiService.fetchKecamatan(kabupaten.id);
                              setState(() {});
                            }
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _searchControllerKab,
                            autofocus: true,
                            enabled: true,
                          ),
                          isFilteredOnline: true,
                          onFind: (String? filter) async {
                            return kabupatenList
                                .where((provinsi) => provinsi.name
                                    .toLowerCase()
                                    .contains(filter!.toLowerCase()))
                                .toList();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kabupaten/Kota harus dipilih';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Pilih Kecamatan'),
                        ),
                        const SizedBox(height: 4.0),
                        DropdownSearch<Kecamatan>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          dropdownSearchDecoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          itemAsString: (Kecamatan? kecamatan) =>
                              kecamatan!.name,
                          items: kecamatanList,
                          compareFn: (item, selectedItem) =>
                              item!.id == selectedItem?.id,
                          onChanged: (Kecamatan? kecamatan) async {
                            if (kecamatan != null) {
                              setState(() {
                                getKel = null;
                                getKec = kecamatan.id;
                              });
                              kelurahanList =
                                  await apiService.fetchKelurahan(kecamatan.id);
                              setState(() {});
                            }
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _searchControllerKec,
                            autofocus: true,
                            enabled: true,
                          ),
                          isFilteredOnline: true,
                          onFind: (String? filter) async {
                            return kecamatanList
                                .where((provinsi) => provinsi.name
                                    .toLowerCase()
                                    .contains(filter!.toLowerCase()))
                                .toList();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kecamatan harus dipilih';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Pilih Kelurahan'),
                        ),
                        const SizedBox(height: 4.0),
                        DropdownSearch<Kelurahan>(
                          //dropdown ini sama dengan yang lain namun tidak ada passing data sehingga onchanged dihapus.
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          dropdownSearchDecoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.secondary,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          itemAsString: (Kelurahan? kelurahan) =>
                              kelurahan!.name,
                          items: kelurahanList,
                          compareFn: (item, selectedItem) =>
                              item!.id == selectedItem?.id,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            controller: _searchControllerKel,
                            autofocus: true,
                            enabled: true,
                          ),
                          isFilteredOnline: true,
                          onFind: (String? filter) async {
                            return kelurahanList
                                .where((provinsi) => provinsi.name
                                    .toLowerCase()
                                    .contains(filter!.toLowerCase()))
                                .toList();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kelurahan harus dipilih';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonCustom(
                              label: 'Next',
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoute.wizard2,
                                    arguments: {
                                      'firstName': _firstNameController.text,
                                      'lastName': _lastNameController.text,
                                      'biodata': _biodataController.text,
                                      'selectedProvinsi':
                                          _searchControllerProv.text,
                                      'selectedKabupaten':
                                          _searchControllerKab.text,
                                      'selectedKecamatan':
                                          _searchControllerKec.text,
                                      'selectedKelurahan':
                                          _searchControllerKel.text,
                                    }, //passing argument ke rute wizard2
                                  );
                                }
                                //validasi ditrigger
                              },
                            ), //tombol untuk pindah halaman
                          ],
                        )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
