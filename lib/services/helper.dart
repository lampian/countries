import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

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
    //   placeholderBuilder: (_) => Image.asset('assets/images/blankflag.png'),
    // );
  } catch (e) {
    print('error $e');
    return Image.asset('assets/images/blankflag.png');
  }
  //return aSvg;
}
