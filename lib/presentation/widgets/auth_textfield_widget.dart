import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String title;
  final bool isPassword;
  final TextEditingController controller;

  const AuthTextFieldWidget(
      {super.key,
      required this.title,
      required this.controller,
      this.isPassword = false});

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          obscureText: widget.isPassword ? isObsecure : false,
          controller: widget.controller,
          validator: (value) {
            if (widget.controller.text.isEmpty) {
              return "${widget.title} cannot be empty";
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    icon: Icon(
                      isObsecure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ))
                : null,
          ),
        ),
      ],
    );
  }
}
