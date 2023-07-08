import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';

class BidDetailsWidget extends StatelessWidget {
  const BidDetailsWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textColor,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final iconColor = isDark ? TTS_PrimaryColor : TTS_AccentColor;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyText2?.apply(color: TTS_LightBlack)),
      subtitle: Text(subtitle!, style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      // trailing: endicon
      //     ? Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(100),
      //           color: iconColor.withOpacity(0.1),
      //         ),
      //         child: const Icon(
      //           LineAwesomeIcons.angle_right,
      //           size: 18.0,
      //           color: Colors.grey,
      //         ),
      //       )
      //     : null,
    );
  }
}
