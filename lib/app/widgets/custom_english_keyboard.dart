import 'package:flutter/material.dart';
import 'package:gurugranth_app/app/widgets/english_keywords.dart';
import 'package:gurugranth_app/app/widgets/punjabi_keyboard.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EnglishKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;
  final Function setStateValue;

  EnglishKeyboard(
      {Key? key, required this.notifier, required this.setStateValue})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(250);
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: EngPad(
        buttonSize: 35,
        controller: textController,
        delete: () {
          textController.text =
              textController.text.substring(0, textController.text.length - 1);
          updateValue(textController.text);
          setStateValue(textController.text);
          // setState(() {});
        },
        onSubmit: () {
          // Navigator.pop(context);
          FocusScope.of(context).requestFocus(new FocusNode());
          updateValue(textController.text);
          setStateValue(textController.text);
        },
        setStateFunction: () {
          updateValue(textController.text);
          setStateValue(textController.text);
          // setState(() {});
        },
      ),
    );
  }
}
