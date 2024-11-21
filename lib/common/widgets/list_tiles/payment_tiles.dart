// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../utils/constants/sizes.dart';

// class PaymentTile extends StatelessWidget {
//   const PaymentTile({super.key, required this.paymentModel});

//   // final PaymentModel paymentModel;
//   @override
//   Widget build(BuildContext context) {
//     final controller = CheckoutController.instance;
//     return ListTile(
//       contentPadding: const EdgeInsets.all(0),
//       onTap: () {
//         controller.selectedPaymentModel.value = paymentModel;
//         Get.back();
//       },
//       leading: PRoundedContainer(
//         width: 60,
//         height: 60,
//         backgroundColor: PHelperFunctions.isDarkMode(context)
//             ? PColors.light
//             : PColors.white,
//         padding: const EdgeInsets.all(PSizes.sm),
//         child: Image(
//           image: AssetImage(paymentModel.image),
//           fit: BoxFit.contain,
//         ),
//       ),
//       title: Text(paymentModel.name),
//       trailing: const Icon(Iconsax.arrow_right_14),
//     );
//   }
// }
