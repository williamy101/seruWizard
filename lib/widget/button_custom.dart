import 'package:flutter/material.dart';
import 'package:seru_wizard/config/app_color.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {Key? key,
      required this.label,
      required this.onTap,
      this.isExpand}) //button custom ini properti yang required yaitu label diisi dengan string dan fungsi ontap
      : super(key: key);
  final String label;
  final Function onTap;
  final bool? isExpand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Align(
            child: Material(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                //inkwell agar widget didalam bisa di tap
                borderRadius: BorderRadius.circular(15),
                onTap: () => onTap(),
                child: Container(
                  width: isExpand == null
                      ? null
                      : isExpand!
                          ? double.infinity
                          : null, // jika isExpand di set ke true maka widthnya akan mengikuti ukuran layar
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 12,
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
