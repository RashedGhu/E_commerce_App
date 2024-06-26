
import 'package:flutter/widgets.dart';

class MyIcons {
  MyIcons._();

  static const _kFontFam = 'Icons';
  static const String? _kFontPkg = null;
  static const _iconData = 'IconsData';

  static const _user = 'User';
 static const _home = 'Home';

  static const _QR = 'QR';

  static const IconData qr_scan = IconData(0xe805, fontFamily: _QR, fontPackage: _kFontPkg);

  static const IconData home2 = IconData(0xe804, fontFamily: _home, fontPackage: _kFontPkg);
  static const IconData user1 =
      IconData(0xe803, fontFamily: _user, fontPackage: _kFontPkg);

  static const IconData amazon =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData home =
      IconData(0xe801, fontFamily: _iconData, fontPackage: _kFontPkg);
  static const IconData user =
      IconData(0xe802, fontFamily: _iconData, fontPackage: _kFontPkg);
}
