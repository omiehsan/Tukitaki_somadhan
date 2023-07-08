import 'package:flutter/material.dart';

class Forget_Pass_BTN_Widget extends StatelessWidget {
  const Forget_Pass_BTN_Widget({
    Key? key,
    required this.btnIcon,
    required this.btnTitle,
    required this.btnSubtitle,
    required this.onTap,

  }) : super(key: key);

  final IconData btnIcon;
  final String btnTitle, btnSubtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(btnIcon, size: 60.0),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(btnTitle, style: Theme.of(context).textTheme.headline5),
                Text(btnSubtitle, style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
