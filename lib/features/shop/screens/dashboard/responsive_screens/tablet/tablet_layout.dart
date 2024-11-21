import 'package:ahiaa_web/common/layout/headers/header.dart';
import 'package:ahiaa_web/common/layout/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});
  final Widget? body;
  // GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const TSidebar(),
      appBar: THeader(
        scaffoldKey: scaffoldKey,
      ),
      body: body ??
          const TRoundedContainer(
            height: 500,
            backgroundColor: PColors.warning,
            width: double.infinity,
            child: Column(),
          ),
    );
  }
}
