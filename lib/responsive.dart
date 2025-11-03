import 'package:flutter/material.dart';

import 'core/common/widgets/custom_shapes/containers/rounded_container.dart';

class ResponsiveDesign extends StatelessWidget {
  const ResponsiveDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: LayoutBuilder(builder: (_, constraint) {
          if (constraint.maxWidth >= 1000) {
            return const DesktopScaffold();
          } else {
            return const Text('Other windows');
          }
        }),
      ),
    ));
  }
}

class DesktopScaffold extends StatelessWidget {
  const DesktopScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.withOpacity(0.2),
                child: const Center(
                  child: Text('Box 1'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Expanded(
              flex: 2,
              child: TRoundedContainer(
                height: 450,
                // backgroundColor: Colors.blue.withOpacity(0.2),
                child: Center(
                  child: Text('Box 1'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: TRoundedContainer(
                height: 450,
                backgroundColor: Colors.blue.withOpacity(0.2),
                child: const Center(
                  child: Text('Box 1'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
      ],
    );
  }
}
