import 'package:flutter/material.dart';

import '../../../state_managment/auth_bloc/auth_cubit.dart';

Widget detailsInfoButtons({required BuildContext context}) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
          ),
          Row(
            children: [
              roundedButton(
                onTap: () {},
                title: 'Your Orders',
              ),
              roundedButton(onTap: () {}, title: 'Turn Seller'),
            ],
          ),
        ],
      ),
      SizedBox(height: 10),
      Row(
        children: [
          roundedButton(
            onTap: () {
              AuthCubit.getAuthCubit(context).logOut(
                context: context,
              );
            },
            title: 'Log Out',
          ),
          roundedButton(onTap: () {}, title: 'Your Wish List'),
        ],
      )
    ],
  );
}

Expanded roundedButton({
  required String title,
  required void Function() onTap,
}) {
  return Expanded(
    child: Container(
      height: 40.0,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 0.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black12.withOpacity(0.03),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
    ),
  );
}
