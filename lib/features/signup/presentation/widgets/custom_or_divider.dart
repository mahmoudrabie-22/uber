import 'dart:ui';

import 'package:flutter/material.dart';

class CustomOrDivider extends StatelessWidget {
  const CustomOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(height: 12, thickness: 1, color: Color(0xffD1D5DB)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('or'),
        ),
        Expanded(
          child: Divider(height: 12, thickness: 1, color: Color(0xffD1D5DB)),
        ),
      ],
    );
  }
}
