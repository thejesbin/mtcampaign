import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final bool obscure;
  const InputWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      width: mwidth * 0.9,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 248, 248),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            obscureText: obscure,
            keyboardType: inputType,
            controller: controller,
            style: TextStyle(
              fontFamily: "Itim",
            ),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ))
        ],
      ),
    );
  }
}
