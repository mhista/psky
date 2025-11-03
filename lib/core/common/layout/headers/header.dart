import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/injection_container.dart';
import 'package:ahiaa_web/core/routes/app_router2.dart';
import 'package:ahiaa_web/core/routes/routes.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../utils/device/device_utility.dart';

class KHeader extends StatelessWidget implements PreferredSizeWidget {
  const KHeader({super.key, this.scaffoldKey});

  // Globalkey to access the scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  Widget build(BuildContext context) {
    final route = getIt<AppRouter>().router;
    final responsive = ResponsiveBreakpoints.of(context);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:responsive.isMobile? 12: 23),
      child: AppBar(
        // backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth:responsive.isMobile?null: 100,
        leading: !responsive.isMobile
            ? Image.asset(PImages.logoB,  fit: BoxFit.contain, width: 104, height: 28):
             IconButton(
                onPressed: () {},
                icon: const PRoundedImage(
                  width: 40,
                  height: 32,
                  imageType: ImagesType.asset,
                  image: PImages.logoS2,
                ),
              )
            ,
        title: !responsive.isMobile? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            NavLink(title: 'Features', onPressed: () {
              
            },),
              NavLink(title: 'Why Choose Us', onPressed: () {
              
            },),  NavLink(title: 'Review', onPressed: () {
              
            },),  NavLink(title: 'FAQ', onPressed: () {
              
            },),
            
          ],
        ): const SizedBox.shrink(),
        actions: [
          !responsive.isMobile?
          ElevatedButton(onPressed: (){
            route.goNamed(KRoutes.auth);
          }, style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            )
          ), child: const Text('Get Started', ),)
         :
          IconButton(onPressed: (){}, icon: const Icon(
          Icons.menu
        ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight() );
}

class NavLink extends StatelessWidget {
  const NavLink({
    super.key, required this.title, required this.onPressed, 
  });
  final String title;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(title, style: Theme.of(context).textTheme.titleLarge,));
  }
}
