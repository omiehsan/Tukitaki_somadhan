import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../models/onboarding_model.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(TTS_DefaultSize),
      color: model.bgcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(image: AssetImage(model.image), height: screenSize.height * 0.4),
          Column(
            children: [
              Text(model.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 32, fontWeight: FontWeight.w800, color: TTS_AccentColor)),
              Text(model.subtitle,
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 18, fontWeight: FontWeight.w300)),
            ],
          ),
          Text(model.pagecounter, style: Theme.of(context).textTheme.headline6),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }
}
