import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  customTextField(
      {super.key,
      required this.lable,
      required this.icon,
      required this.isPass,
      this.onSaved,
      this.validate,
      });
  final String lable;
  final Icon icon;

  Function(String?)? onSaved;
  bool isPass;
  // TextEditingController cont;
  String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
          // controller: cont,
          validator: validate,
          onSaved: onSaved,
          obscureText: isPass ? true : false,
          decoration: InputDecoration(
              hintText: lable,
              suffixIcon: icon,
              border: const OutlineInputBorder(borderSide: BorderSide.none))),
    );
  }
}
// class customTextField2 extends StatelessWidget {
//   customTextField2(
//       {super.key,
//       required this.lable,
//       required this.icon,
//       this.onChange,
//       this.validate});
//   final String lable;
//   final Icon icon;
//   Function(String)? onChange;

//   String? Function(String?)? validate;
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//         validator: validate,
//         // onChanged: onChange,
//         decoration: InputDecoration(
//             hintText: lable,
//             suffixIcon: icon,
//             border: const OutlineInputBorder(borderSide: BorderSide.none)));
//   }
// }
