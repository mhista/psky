import 'package:ahiaa_web/core/common/layout/headers/header.dart';
import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../sidebars/sidebar.dart';

class MobileLayout2 extends StatelessWidget {
  MobileLayout2({super.key, this.body});
  final Widget? body;
  // GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const KSideBar(),
      appBar: KHeader2(scaffoldKey: scaffoldKey),
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
