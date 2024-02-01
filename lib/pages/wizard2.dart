import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:seru_wizard/config/app_color.dart';

class WizardTwo extends StatelessWidget {
  const WizardTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); //back ke halaman sebelumnya
            },
          ),
          elevation: 1,
          backgroundColor: AppColor.primary,
          title: Text(
            'Upload Foto',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView();
          },
        ));
  }
}
