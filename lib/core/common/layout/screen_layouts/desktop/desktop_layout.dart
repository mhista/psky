import 'package:ahiaa_web/core/common/layout/headers/header.dart';
import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});

  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SideBar

          // main content
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                const KHeader(),

                // BODY
                Expanded(
                  child:
                      body ??
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
    );
  }
}
