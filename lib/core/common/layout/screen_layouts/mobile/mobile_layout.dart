import 'package:ahiaa_web/core/common/layout/headers/header.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../sidebars/sidebar.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});
  final Widget? body;
  // GlobalKey to access the scaffold state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const  KSideBar(),
      appBar: KHeader(),
      body:
          body ??
          const TRoundedContainer(
            height: 500,
            backgroundColor: PColors.warning,
            width: double.infinity,
            child: Column(),
          ),
    );
  }
}
