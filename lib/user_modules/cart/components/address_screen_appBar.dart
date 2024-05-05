import 'package:flutter/material.dart';
PreferredSize addressScreenAppbar({required BuildContext context , required String totalAmount}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Total ${totalAmount} AED',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
          )),
    ),
  );
}
