import 'package:flutter/material.dart';
import 'package:gurugranth_app/app/widgets/punjabi_keyboard.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CounterKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;
  final Function setStateValue;
  final TextEditingController textController;

  CounterKeyboard(
      {Key? key,
      required this.notifier,
      required this.setStateValue,
      required this.textController})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(250);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: NumPad(
        buttonSize: 39,
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
