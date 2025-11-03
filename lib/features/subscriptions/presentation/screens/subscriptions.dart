import 'package:ahiaa_web/core/common/layout/templates/site_template.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/features/subscriptions/presentation/screens/widgets/animated_switcher.dart';
import 'package:ahiaa_web/features/subscriptions/presentation/screens/widgets/subscription_row.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    super.key,
    this.isLoading = false,
    this.hasError = false,
    this.expand = false,
    this.isFirstTime = true,
    this.hasData = false,
  });
  final bool isLoading, hasError, hasData, expand, isFirstTime;
  
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SiteTemplate2(
        useLayout: true,
        desktop: SubscriptionDesktop());
  }
}

class SubscriptionDesktop extends StatefulWidget {
  const SubscriptionDesktop({
    super.key,
  });
  
  @override
  State<SubscriptionDesktop> createState() => _SubscriptionDesktopState();
}

class _SubscriptionDesktopState extends State<SubscriptionDesktop> {
  String billingPeriod = 'yearly';
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ResponsiveText('Choose your plan').withSize(28).bold,
          SizedBox(
              width: 264,
              child: const ResponsiveText(
                      'Unlock smarter studying with the plan the fits your goals')
                  .withAlign(TextAlign.center)
                  .withSize(10)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 316),
                child: AnimatedToggleSwitch(
                  height: 60,
                  borderRadius: 1000,
                  padding: const EdgeInsets.all(10),
                  options: const [
                    ToggleOption(label: 'Yearly Billing', value: 'yearly'),
                    ToggleOption(label: 'Monthly Billing', value: 'monthly'),
                  ],
                  // FIXED: Removed quotes to pass the variable, not a string literal
                  selectedValue: billingPeriod,  // ← No quotes!
                  onChanged: (value) {
                    setState(() => billingPeriod = value);
                    print('Billing changed to: $value');
                  },
                )),
          ),
          SubscriptionRow(billingPeriod: billingPeriod)
        ],
      ),
    );
  }
}