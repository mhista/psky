// Builder for the toast content; receives an overlay handle so we can close it.
import 'package:shadcn_flutter/shadcn_flutter.dart';

class KToasters {
  static Widget buildToast(BuildContext context, ToastOverlay overlay,
      {required String title,
      String subtitle = '',
      Function()? onpressed,
      String? functionText,
      ToastLocation location = ToastLocation.topRight}) {
    return SurfaceCard(
      child: Basic(
        title: Text(title),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: onpressed,
            child: Text(functionText ?? '')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  static showToaster(
      {required BuildContext context,
      required String title,
      String subtitle = '',
      Function()? onpressed,
      String? functionText,
      ToastLocation location = ToastLocation.topRight}) {
    return showToast(
        context: context,
        builder: (context, overlay) => buildToast(context, overlay,
            title: title,
            subtitle: subtitle,
            onpressed: onpressed,
            functionText: functionText,
            location: location));
  }
}
