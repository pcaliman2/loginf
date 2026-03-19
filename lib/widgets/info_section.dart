import 'package:flutter/material.dart';
import 'package:owa_flutter/useful/size_config.dart';
import 'package:owa_flutter/widgets/headline.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(42)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Spacer
          SizedBox(height: SizeConfig.h(1026.44 - 885)),

          /// Hero heading
          Headline(
            child: Text(
              'Practice the art of being well.',
              style: TextStyle(
                fontFamily: 'Times Now',
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.t(32),
                height: 1.51,
                letterSpacing: 0,
                color: Color(0xFF2C2C2C),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// Spacer
          SizedBox(height: SizeConfig.h(1186.44 - (1026.44 + 48))),
        ],
      ),
    ),
  );
}
