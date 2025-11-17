import 'package:ahiaa_web/core/common/layout/headers/header2.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../sidebars/sidebar.dart';

class MobileLayout2 extends StatefulWidget {
  const MobileLayout2({super.key, this.body});
  final Widget? body;

  @override
  State<MobileLayout2> createState() => _MobileLayout2State();
}

class _MobileLayout2State extends State<MobileLayout2> {
  // GlobalKey to access the scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const KSideBar(),
      appBar: KHeader2(scaffoldKey: _scaffoldKey),
      body: widget.body ??
          const TRoundedContainer(
            height: 500,
            backgroundColor: PColors.warning,
            width: double.infinity,
            child: Column(),
          ),
    );
  }
}