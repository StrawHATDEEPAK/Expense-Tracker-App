import 'package:flutter/material.dart';

class GreyRoundedContainer extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const GreyRoundedContainer(
      {super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ]),
        child: Icon(icon, color: Colors.black, size: 40),
      ),
    );
  }
}
