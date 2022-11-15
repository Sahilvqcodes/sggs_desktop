import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EngPad extends StatelessWidget {
  final double buttonSize;

  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;
  final Function setStateFunction;

  const EngPad({
    Key? key,
    this.buttonSize = 35,
    required this.delete,
    required this.onSubmit,
    required this.controller,
    required this.setStateFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //  margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnglishButton(
                  number: 'q',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'w',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'e',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'r',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 't',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'y',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'u',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'i',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'o',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'p',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnglishButton(
                  number: 'a',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 's',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 'd',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'f',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'g',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'h',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 'j',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 'k',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'l',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
              ],
            ),
          ),
          // const SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnglishButton(
                  number: 'z',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  //color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 'x',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
                  controller: controller,
                ),
                EnglishButton(
                  number: 'c',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'v',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'b',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'n',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  controller: controller,
                ),
                EnglishButton(
                  number: 'm',
                  size: buttonSize,
                  setStateFunction: () {
                    setStateFunction();
                  },
                  // color: buttonColor,
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
                EnglishButton(
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
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class EnglishButton extends StatelessWidget {
  final String number;
  final double size;
  double? buttonWidth;
  final Function setStateFunction;

  final TextEditingController controller;

  EnglishButton(
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
