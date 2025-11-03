import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PSocialButton extends StatelessWidget {
  const PSocialButton({
    super.key,
    this.width = 490,
    this.height = 48,
  });
  final double width, height;
  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());
    return SizedBox(
      height: 48,
      width: 480,
      child: OutlinedButton(
        onPressed: () {},
        // style: OutlinedButton.styleFrom(
        //   maximumSize: const Size(490, 56),
        //   minimumSize: const Size(490, 56),
        // ),
        child: const Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(PImages.google),
                height: 20,
                width: 20,
              ),
              Text(
                'Google',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
