import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/widgets/action_buttons_column_mobile.dart';
import 'package:owa_flutter/widgets/headline.dart';

class InfoSectionMobile extends StatelessWidget {
  const InfoSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.w(40),
          vertical: SizeConfig.h(200),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.h(40)),
              child: Headline(
                child: Text(
                  'Practice the art of being well',
                  style: TextStyle(
                    fontFamily: 'Basier Square Mono',
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    height: 1.51,
                    letterSpacing: 19 * 0.12,
                    color: const Color(0xFF2C2C2C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //  Container(
            //    margin: EdgeInsets.only(bottom: SizeConfig.h(80)),
            //    child: Headline(
            //      child: Text(
            //        'OWA is Mexico City\'s first wellness club of its kind—bringing together the essential pillars of human wellbeing in one place. By integrating contrast therapies, nutrition, supplementation, social connection, and hospitality, OWA creates an integrated ecosystem designed for vitality.',
            //        style: TextStyle(
            //          fontFamily: 'Arbeit',
            //          fontWeight: FontWeight.w300,
            //          fontSize: 14,
            //          height: 24 / 14,
            //          letterSpacing: 0,
            //          color: const Color(0xFF2C2C2C),
            //        ),
            //        textAlign: TextAlign.center,
            //      ),
            //    ),
            //  ),
            const ActionButtonsColumnMobile(),
          ],
        ),
      ),
    );
  }
}
