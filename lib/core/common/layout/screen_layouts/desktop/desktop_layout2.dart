import 'package:ahiaa_web/core/common/layout/headers/header.dart';
import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/layout/sidebars/sidebar.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class DesktopLayout2 extends StatelessWidget {
  const DesktopLayout2({super.key, this.body});

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 23),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            const KSideBar(),
        
            // SizedBox(height: kToolbarHeight,),
            // HEADER
        
            // BODY
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KHeader2(),
                  Expanded(
                    child: body ??   
                        const TRoundedContainer(
                          height: 500,
                          backgroundColor: PColors.warning,
                          width: double.infinity,
                          child: Column(),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
