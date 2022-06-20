import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool invertColor;
  final Color? color;
  final String? prompt;
  final Widget? promptWidget;

  const Loader({
    Key? key,
    this.invertColor = false,
    this.color,
    this.prompt,
    this.promptWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return promptWidget != null || (prompt != null && prompt!.isNotEmpty)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getLoader(themeData),
                  const SizedBox(height: 24),
                  promptWidget ??
                      Text(
                        prompt!,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.headline6?.copyWith(
                          color: color ?? (invertColor ? themeData.colorScheme.background : themeData.colorScheme.onBackground),
                        ),
                      ),
                ],
              ),
            ),
          )
        : _getLoader(themeData);
  }

  Widget _getLoader(ThemeData themeData) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? (invertColor ? themeData.colorScheme.background : themeData.colorScheme.onBackground),
      ),
    );
  }
}
