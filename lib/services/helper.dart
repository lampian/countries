import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

const blankFlagName = 'assets/images/blankflag.png';

//TODO Svg still has an problem with some files - use the png
// link supplied until the issue is resolved.
Widget svgPicture(String url, double height, String code) {
  //SvgPicture aSvg;
  final endPoint = 'https://flagcdn.com/w640/';
  try {
    var pngUrl = endPoint + code.toLowerCase() + '.png';
    return Image.network(pngUrl);
    // aSvg = SvgPicture.network(
    //   pngUrl,
    //   height: height,
    //   placeholderBuilder: (_) => Image.asset(blankFlagName),
    // );
  } catch (e) {
    print('error $e');
    return Image.asset(blankFlagName);
  }
  //return aSvg;
}
