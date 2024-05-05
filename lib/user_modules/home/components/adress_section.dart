import 'package:flutter/material.dart';

import '../../../state_managment/auth_bloc/auth_cubit.dart';

Widget addressSection({required BuildContext context}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: 50.0,
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Icon(
            Icons.location_pin,
            size: 20.0,
          ),
          Text(
            AuthCubit.getAuthCubit(context).getCurrentUser.address.isEmpty
                ? 'Deliver to United Arab Emartes'
                : '${AuthCubit.getAuthCubit(context).getCurrentUser.address}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 18.0,
          ),
        ],
      ),
    ),
  );
}
