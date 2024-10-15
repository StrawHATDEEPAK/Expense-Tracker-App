import 'package:flutter/material.dart';

class AuthButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  bool isLoading;
  final String title;
  AuthButtonWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
