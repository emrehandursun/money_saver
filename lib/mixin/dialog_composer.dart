import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:line_icons/line_icons.dart';

mixin DialogComposer {
  Future<dynamic> showAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Hata',
    DialogType dialogType = DialogType.error,
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    final themeData = Theme.of(context);
    //final dialogWidth = width ?? (Screen.isLandscape ? Screen.width / 2 : null);
    final dialog = AwesomeDialog(
      context: context,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      animType: animType,
      autoHide: autoHide,
      headerAnimationLoop: headerAnimationLoop,
      dialogType: dialogType,
      title: title,
      desc: message,
      btnCancel: cancelButton ??
          (cancelButtonText != null
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) {
                      onCancel();
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(cancelColor ?? themeData.colorScheme.tertiary),
                    foregroundColor: MaterialStateProperty.all(themeData.colorScheme.onTertiary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showIcons) Icon(cancelIcon),
                        if (showIcons) const SizedBox(width: 6),
                        FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Text(
                            cancelButtonText,
                            style: themeData.textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: themeData.colorScheme.onTertiary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : null),
      btnOk: submitButton ??
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onSubmit != null) {
                onSubmit();
              }
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(submitColor ?? themeData.colorScheme.primary),
              foregroundColor: MaterialStateProperty.all(themeData.colorScheme.onPrimary),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showIcons) Icon(submitIcon),
                  if (showIcons) const SizedBox(width: 6),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      submitButtonText,
                      style: themeData.textTheme.caption?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeData.colorScheme.onPrimary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      onDismissCallback: onDissmiss == null
          ? null
          : (dissmissType) {
              onDissmiss();
            },
      alignment: aligment,
      padding: padding,
    );
    return await dialog.show();
  }

  Future<dynamic> showInfoAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Bilgi',
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    return await showAwesomeDialog(
      context: context,
      message: message,
      dialogType: DialogType.info,
      title: title,
      onSubmit: onSubmit ?? () {},
      onCancel: onCancel ?? () {},
      onDissmiss: onDissmiss ?? () {},
      submitButton: submitButton,
      submitButtonText: submitButtonText,
      submitIcon: submitIcon,
      submitColor: submitColor,
      cancelButton: cancelButton,
      cancelButtonText: cancelButtonText,
      cancelIcon: cancelIcon,
      cancelColor: cancelColor,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      autoHide: autoHide,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      width: width,
      aligment: aligment,
      padding: padding,
      showIcons: showIcons,
    );
  }

  Future<dynamic> showErrorAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Hata',
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    return await showAwesomeDialog(
      context: context,
      message: message,
      dialogType: DialogType.error,
      title: title,
      onSubmit: onSubmit ?? () {},
      onCancel: onCancel ?? () {},
      onDissmiss: onDissmiss ?? () {},
      submitButton: submitButton,
      submitButtonText: submitButtonText,
      submitIcon: submitIcon,
      submitColor: submitColor,
      cancelButton: cancelButton,
      cancelButtonText: cancelButtonText,
      cancelIcon: cancelIcon,
      cancelColor: cancelColor,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      autoHide: autoHide,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      width: width,
      aligment: aligment,
      padding: padding,
      showIcons: showIcons,
    );
  }

  Future<dynamic> showWarningAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Uyarı',
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    return await showAwesomeDialog(
      context: context,
      message: message,
      title: title,
      dialogType: DialogType.warning,
      onSubmit: onSubmit ?? () {},
      onCancel: onCancel ?? () {},
      onDissmiss: onDissmiss ?? () {},
      submitButton: submitButton,
      submitButtonText: submitButtonText,
      submitIcon: submitIcon,
      submitColor: submitColor,
      cancelButton: cancelButton,
      cancelButtonText: cancelButtonText,
      cancelIcon: cancelIcon,
      cancelColor: cancelColor,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      autoHide: autoHide,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      width: width,
      aligment: aligment,
      padding: padding,
      showIcons: showIcons,
    );
  }

  Future<dynamic> showSuccessAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Bilgi',
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    return await showAwesomeDialog(
      context: context,
      message: message,
      title: title,
      dialogType: DialogType.success,
      onSubmit: onSubmit ?? () {},
      onCancel: onCancel,
      onDissmiss: onDissmiss,
      submitButton: submitButton,
      submitButtonText: submitButtonText,
      submitIcon: submitIcon,
      submitColor: submitColor,
      cancelButton: cancelButton,
      cancelButtonText: cancelButtonText,
      cancelIcon: cancelIcon,
      cancelColor: cancelColor,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      autoHide: autoHide,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      width: width,
      aligment: aligment,
      padding: padding,
      showIcons: showIcons,
    );
  }

  Future<dynamic> showBasicAwesomeDialog({
    required BuildContext context,
    required String message,
    String title = 'Bilgi',
    Function? onSubmit,
    Function? onCancel,
    Function? onDissmiss,
    Widget? submitButton,
    String submitButtonText = 'Tamam',
    IconData submitIcon = LineIcons.checkCircle,
    Color? submitColor,
    Widget? cancelButton,
    String? cancelButtonText,
    IconData cancelIcon = LineIcons.timesCircle,
    Color? cancelColor,
    AnimType animType = AnimType.leftSlide,
    bool headerAnimationLoop = false,
    Duration? autoHide,
    Widget? body,
    Widget? customHeader,
    bool dismissOnBackKeyPress = false,
    bool dismissOnTouchOutside = false,
    double? width,
    AlignmentGeometry aligment = Alignment.center,
    EdgeInsetsGeometry? padding,
    bool showIcons = false,
  }) async {
    return await showAwesomeDialog(
      context: context,
      message: message,
      title: title,
      dialogType: DialogType.noHeader,
      onSubmit: onSubmit ?? () {},
      onCancel: onCancel ?? () {},
      onDissmiss: onDissmiss ?? () {},
      submitButton: submitButton,
      submitButtonText: submitButtonText,
      submitIcon: submitIcon,
      submitColor: submitColor,
      cancelButton: cancelButton,
      cancelButtonText: cancelButtonText,
      cancelIcon: cancelIcon,
      cancelColor: cancelColor,
      animType: animType,
      headerAnimationLoop: headerAnimationLoop,
      autoHide: autoHide,
      body: body,
      customHeader: customHeader,
      dismissOnBackKeyPress: dismissOnBackKeyPress,
      dismissOnTouchOutside: dismissOnTouchOutside,
      width: width,
      aligment: aligment,
      padding: padding,
      showIcons: showIcons,
    );
  }

  void showSnackBar(BuildContext context, String message, [Duration? duration]) {
    final themeData = Theme.of(context);
    final scaffoldManager = ScaffoldMessenger.of(context);
    scaffoldManager.hideCurrentSnackBar();
    scaffoldManager.showSnackBar(
      SnackBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
        content: Flexible(
          child: Text(
            message,
            style: themeData.textTheme.bodyText1,
          ),
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message, [Duration? duration, bool hideIcon = false]) {
    final themeData = Theme.of(context);
    final scaffoldManager = ScaffoldMessenger.of(context);
    scaffoldManager.hideCurrentSnackBar();
    scaffoldManager.showSnackBar(
      SnackBar(
        backgroundColor: themeData.colorScheme.error,
        content: Row(
          children: [
            if (!hideIcon)
              Icon(
                LineIcons.exclamationCircle,
                color: themeData.colorScheme.onError,
                size: 28,
              ),
            if (!hideIcon) const SizedBox(width: 4),
            Flexible(
              child: Text(
                message,
                style: themeData.textTheme.bodyText1?.copyWith(color: themeData.colorScheme.onError),
              ),
            ),
          ],
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
      ),
    );
  }

  void showWarningSnackBar(BuildContext context, String message, [Duration? duration, bool hideIcon = false]) {
    final themeData = Theme.of(context);
    final scaffoldManager = ScaffoldMessenger.of(context);
    scaffoldManager.hideCurrentSnackBar();
    scaffoldManager.showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        content: Row(
          children: [
            if (!hideIcon)
              const Icon(
                LineIcons.exclamationCircle,
                color: Colors.white,
                size: 28,
              ),
            if (!hideIcon) const SizedBox(width: 4),
            Flexible(
              child: Text(
                message,
                style: themeData.textTheme.bodyText1?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message, [Duration? duration]) {
    final themeData = Theme.of(context);
    final scaffoldManager = ScaffoldMessenger.of(context);
    scaffoldManager.hideCurrentSnackBar();
    scaffoldManager.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(
              LineIcons.checkCircleAlt,
              color: Colors.green,
              size: 28,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                message,
                style: themeData.textTheme.bodyText1?.copyWith(color: Colors.green),
              ),
            ),
          ],
        ),
        duration: duration ?? const Duration(milliseconds: 2000),
      ),
    );
  }
}
