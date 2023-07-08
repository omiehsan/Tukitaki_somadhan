import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';

class FormPageHeader extends StatelessWidget {
  const FormPageHeader({
    Key? key,
    required this.logo,
    required this.logoHeight,
    required this.pageTitle,
    required this.pageSubtitle,
  }) : super(key: key);

  final double logoHeight;
  final String logo, pageTitle, pageSubtitle;

  @override
  Widget build(BuildContext context) {
    final TTS_MQuery = MediaQuery.of(context);
    final deviceSize = TTS_MQuery.size;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Image(image: AssetImage(logo), height: logoHeight),
        // Image(image: AssetImage(TTS_Login_Imge_1), width: deviceSize.height * 0.20),
        SizedBox(height: TTS_DefaultSize - 10),
        Text(pageTitle, style: Theme.of(context).textTheme.headline1),
        SizedBox(height: TTS_DefaultSize - 20),
        Text(pageSubtitle, style: Theme.of(context).textTheme.subtitle1),
        SizedBox(height: TTS_DefaultSize - 10),
      ],
    );
  }
}
