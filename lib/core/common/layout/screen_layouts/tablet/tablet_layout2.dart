import 'package:ahiaa_web/core/common/layout/headers/header.dart';
import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/layout/sidebars/sidebar.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class TabletLayout2 extends StatelessWidget {
  const TabletLayout2({super.key, this.body});

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const KSideBar(),

          // SizedBox(height: kToolbarHeight,),
          // HEADER

          // BODY
          Column(
            children: [
              // const KHeader2(),
              body ??   
                  const TRoundedContainer(
                    height: 500,
                    backgroundColor: PColors.warning,
                    width: double.infinity,
                    child: Column(),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
