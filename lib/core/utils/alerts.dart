import 'package:easy_localization/easy_localization.dart';
import 'package:efatorh/core/Router/Router.dart';
import 'package:efatorh/core/services/navigation_service.dart';
import 'package:efatorh/core/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../shared/widgets/alert_dialog.dart';
import '../../shared/widgets/applogo.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/customtext.dart';
import '../../shared/widgets/snackbar.dart';

enum SnackState { success, failed }

class Alerts {
  static Future dialog(BuildContext context,
      {required Widget child,
      RouteSettings? routeSettings,
      EdgeInsets? insetPadding,
      AlignmentGeometry? alignment,
      Color? backgroundColor}) {
    return showDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) => Dialog(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: backgroundColor,
              insetPadding: insetPadding ?? const EdgeInsets.all(50),
              alignment: alignment,
              child: child,
            ));
  }

  static Future infoDialog(BuildContext context,
      {required Widget child,
      RouteSettings? routeSettings,
      EdgeInsets? insetPadding,
      AlignmentGeometry? alignment,
      Color? backgroundColor,
      Widget? footer,
      String? info}) {
    return showDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) => Dialog(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: backgroundColor,
              insetPadding: insetPadding ?? const EdgeInsets.all(50),
              alignment: alignment,
              child: child,
            ));
  }

  static Future yesOrNoDialog(BuildContext context,
      {required String title,
      required String action1title,
      required String action2title,
      required Function action1,
      required Function action2,
      Widget? icon,
      RouteSettings? routeSettings,
      EdgeInsets? insetPadding,
      AlignmentGeometry? alignment,
      Color? backgroundColor}) {
    return showDialog(
        context: context,
        routeSettings: routeSettings,
        builder: (context) => alertDialog(backgroundColor, alignment, icon,
            title, action1, action1title, action2, action2title));
  }

  static Future bottomSheet(BuildContext context,
      {required Widget child,
      RouteSettings? routeSettings,
      EdgeInsets? insetPadding,
      double? height,
      AlignmentGeometry? alignment,
      Color? backgroundColor}) {
    return showModalBottomSheet(
        useSafeArea: true,
        useRootNavigator: true,
        enableDrag: true,
        barrierColor: Colors.grey.withOpacity(0.2),
        isScrollControlled: true,
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        context: context,
        builder: (context) => child);
  }

  static Future<bool> confirmDialog(
    BuildContext context, {
    required String text,
  }) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: Text(text),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("لا")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("نعم"))
              ],
            )));
  }

  static defaultError() {
    return SmartDialog.show(
      builder: (context) => SizedBox(
        width: 400,
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: const SnackDesign(
              state: SnackState.failed,
              text: "حدث خطأ ما",
            )),
      ),
    );
  }

  static shouldUpgradeDialog() {
    infoDialog(NavigationService.context, child: const ShouldUpgradeDialog());
  }

  static Future snack({required String text, required SnackState state}) async {
    return await SmartDialog.show(
      builder: (context) => SizedBox(
        width: 650,
        child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: SnackDesign(
              text: text,
              state: state,
            )),
      ),
    );
  }
}

class ShouldUpgradeDialog extends StatelessWidget {
  const ShouldUpgradeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLogo(
              whiteFont: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: CustomText(
                "shouldUpgrade".tr(),
                weight: FontWeight.bold,
                align: TextAlign.center,
                fontSize: 20,
                textStyleEnum: TextStyleEnum.normal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (Utils.user?.userType == 0)
              SizedBox(
                height: 45,
                child: DefaultButton(
                  text: "upgrade".tr(),
                  onTap: () {
                    Navigator.pop(NavigationService.context);
                    NavigationService.pushNamed(Routes.packages);
                  },
                ),
              ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
