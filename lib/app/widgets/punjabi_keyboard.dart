import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  final double buttonSize;

  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;
  final Function setStateFunction;

  const NumPad({
    Key? key,
    required this.buttonSize,
    required this.delete,
    required this.onSubmit,
    required this.controller,
    required this.setStateFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 1,
      //  margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 'ੳ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਅ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ੲ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਸ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਹ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਕ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਖ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਗ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਘ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਙ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 'ਚ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਛ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਜ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਝ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਞ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਟ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਠ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਡ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਢ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਣ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 'ਤ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਥ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਦ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਧ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਨ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਪ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਫ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਬ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਭ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਮ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: 'ਯ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਰ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਲ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਵ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ੜ',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                NumberButton(
                  number: 'ਖ਼',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                IconButton(
                  onPressed: () => delete(),
                  icon: Icon(
                    Icons.backspace,
                    //color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberButton(
                  number: " ",
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },

                  //color: buttonColor,
                  controller: controller,
                  buttonWidth: size.width * 0.8,
                ),
                IconButton(
                  onPressed: () => onSubmit(),
                  icon: Icon(
                    Icons.done_rounded,
                    //color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

class NumberButton extends StatelessWidget {
  final String number;
  final double size;
  double? buttonWidth;
  final Function setStateFunction;

  final TextEditingController controller;

  NumberButton(
      {Key? key,
      required this.number,
      required this.size,
      required this.controller,
      required this.setStateFunction,
      this.buttonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: number == " " ? buttonWidth : size,
      height: size,
      child: TextButton(
        onPressed: () {
          controller.text += number.toString();
          setStateFunction();
        },
        child: Center(
          child: number != " "
              ? Text(
                  number.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                )
              : Text(
                  "Space",
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ),
        ),
      ),
    );
  }
}
