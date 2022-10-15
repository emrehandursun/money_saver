import 'package:flutter/material.dart';
import 'package:money_saver/widgets/password_validator/conditions_helper.dart';
import 'package:money_saver/widgets/password_validator/password_validator_string.dart';
import 'package:money_saver/widgets/password_validator/validation_text_widget.dart';
import 'package:money_saver/widgets/password_validator/validator.dart';

class PasswordValidator extends StatefulWidget {
  final int minLength, normalCharCount, uppercaseCharCount, numericCharCount, specialCharCount;
  final Color successColor, failureColor;
  final double height;
  final Function onSuccess;
  final Function? onFail;
  final TextEditingController controller;
  final PasswordValidatorStrings? strings;

  const PasswordValidator({
    super.key,
    required this.height,
    required this.minLength,
    required this.onSuccess,
    required this.controller,
    this.uppercaseCharCount = 0,
    this.numericCharCount = 0,
    this.specialCharCount = 0,
    this.normalCharCount = 0,
    this.strings,
    this.onFail,
    required this.successColor,
    required this.failureColor,
  });

  @override
  State<StatefulWidget> createState() => _PasswordValidatorState();

  PasswordValidatorStrings get translatedStrings => strings ?? PasswordValidatorStrings();
}

class _PasswordValidatorState extends State<PasswordValidator> {
  /// Estimate that this the first run or not
  late bool isFirstRun;

  /// Variables that hold current condition states
  dynamic hasMinLength, hasMinNormalChar, hasMinUppercaseChar, hasMinNumericChar, hasMinSpecialChar;

  //Initial instances of ConditionHelper and Validator class
  late final ConditionsHelper conditionsHelper;
  Validator validator = Validator();

  /// Get called each time that user entered a character in EditText
  void validate() {
    /// For each condition we called validators and get their new state
    hasMinLength = conditionsHelper.checkCondition(widget.minLength, validator.hasMinLength, widget.controller, widget.translatedStrings.atLeast, hasMinLength);

    hasMinNormalChar = conditionsHelper.checkCondition(widget.normalCharCount, validator.hasMinNormalChar, widget.controller, widget.translatedStrings.normalLetters, hasMinNormalChar);

    hasMinUppercaseChar = conditionsHelper.checkCondition(widget.uppercaseCharCount, validator.hasMinUppercase, widget.controller, widget.translatedStrings.uppercaseLetters, hasMinUppercaseChar);

    hasMinNumericChar = conditionsHelper.checkCondition(widget.numericCharCount, validator.hasMinNumericChar, widget.controller, widget.translatedStrings.numericCharacters, hasMinNumericChar);

    hasMinSpecialChar = conditionsHelper.checkCondition(widget.specialCharCount, validator.hasMinSpecialChar, widget.controller, widget.translatedStrings.specialCharacters, hasMinSpecialChar);

    /// Checks if all condition are true then call the onSuccess and if not, calls onFail method
    int conditionsCount = conditionsHelper.getter()!.length;
    int trueCondition = 0;
    for (bool value in conditionsHelper.getter()!.values) {
      if (value == true) trueCondition += 1;
    }
    if (conditionsCount == trueCondition) {
      widget.onSuccess();
    } else if (widget.onFail != null) {
      widget.onFail!();
    }

    //To prevent from calling the setState() after dispose()
    if (!mounted) return;

    //Rebuild the UI
    setState(() {});
    trueCondition = 0;
  }

  @override
  void initState() {
    super.initState();
    isFirstRun = true;

    conditionsHelper = ConditionsHelper(widget.translatedStrings);

    /// Sets user entered value for each condition
    conditionsHelper.setSelectedCondition(widget.minLength, widget.normalCharCount, widget.uppercaseCharCount, widget.numericCharCount, widget.specialCharCount);

    /// Adds a listener callback on TextField to run after input get changed
    widget.controller.addListener(() {
      isFirstRun = false;
      validate();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          //Iterate through the condition map entries and generate new ValidationTextWidget for each item in Green or Red Color
          children: conditionsHelper.getter()!.entries.map((entry) {
            int? value;
            if (entry.key == widget.translatedStrings.atLeast) {
              value = widget.minLength;
            }
            if (entry.key == widget.translatedStrings.normalLetters) {
              value = widget.normalCharCount;
            }
            if (entry.key == widget.translatedStrings.uppercaseLetters) {
              value = widget.uppercaseCharCount;
            }
            if (entry.key == widget.translatedStrings.numericCharacters) {
              value = widget.numericCharCount;
            }
            if (entry.key == widget.translatedStrings.specialCharacters) {
              value = widget.specialCharCount;
            }
            return ValidationTextWidget(
              color: entry.value ? widget.successColor : widget.failureColor,
              text: entry.key,
              value: value,
            );
          }).toList()),
    );
  }
}
