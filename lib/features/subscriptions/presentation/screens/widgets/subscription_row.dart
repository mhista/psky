
import 'package:ahiaa_web/features/subscriptions/presentation/screens/widgets/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SubscriptionRow extends StatelessWidget {
  const SubscriptionRow({
    super.key,
    required this.billingPeriod,
  });

  final String billingPeriod;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // mainAxisAlignment: MainAxisAlignment.center,
      alignment: WrapAlignment.center,
      runSpacing: 20,
      spacing: 20,
      children: [
        SubscriptionWidget(
            plan: 'Free Plan',
            discountText: '',
            duration: billingPeriod == 'yearly' ? 'year' : 'month',
            isSubscribed: true,
            price: '0',
            items: const [
              (true, 'Access to 3 subjects'),
              (true, 'Daily streak tracker'),
              (true, 'AI tips after each test'),
              (false, 'Limited exam attempts'),
              (false, 'No performance reports'),
            ]),
             SubscriptionWidget(
            plan: 'Premium Plan',
            discountText: '',
            duration: billingPeriod == 'yearly' ? 'year' : 'month',
            isSubscribed: false,
            price: '2500',
            items: const [
              (true, 'Unlimited subjects & mock exams'),
              (true, 'Detailed AI feedback & insights'),
              (true, 'Personalized study plan'),
              (true, 'Performance dashboard'),
              (false, 'No offline access'),
            ]),
             SubscriptionWidget(
            plan: 'Free Plan',
            discountText: '',
            duration: billingPeriod == 'yearly' ? 'year' : 'month',
            isSubscribed: false,
            price: '4000',
            items: const [
              (true, 'Everything in premium, plus:'),
              (true, 'offline mode exam'),
              (true, 'Advanced AI mentor feedback'),
              (true, 'Downloadable performance reports'),
              (true, 'Priority support for technical or content-related issues'),
              (true, 'Early access to new subjects and features'),
        
            ])
      ],
    );
  }
}