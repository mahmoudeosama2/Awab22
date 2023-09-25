import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final onchange;
  const CustomTextField({super.key, this.onchange});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 50,
        child: TextFormField(
          onChanged: onchange,
          style: TextStyle(color: Theme.of(context).hintColor),
          onSaved: (newValue) {},
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            focusColor: const Color(0xff095263),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff095263), width: 2),
                borderRadius: BorderRadius.circular(5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff095263)),
                borderRadius: BorderRadius.circular(5)),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            hintText: "ابحث عن السوره",
          ),
        ),
      ),
    );
  }
}
