import 'package:ahiaa_web/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../utils/helpers/network_manager.dart';

class GeneralBindiings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>NetworkManager(),fenix: true);
    Get.lazyPut(()=>UserController(),fenix: true);

    // Get.put(VariationController());
    // // Get.put(CartController());

    // Get.put(FavouritesController());
    // Get.put(CheckoutController());
    // Get.put(AddressController());
  }
}
