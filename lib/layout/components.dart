import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_badge/icon_badge.dart';
import '../state_managment/auth_bloc/auth_cubit.dart';
import '../state_managment/products_bloc/products_cubit.dart';
import '../state_managment/products_bloc/products_states.dart';
import '../util/theme.dart';

BottomNavigationBarItem myBottomNavigationBarItem({
  required BuildContext context,
  required IconData icon,
  required int selectedIndex,
  required int itemBarIndex,
  bool cartBadge = false,
}) {
  final cartLength = AuthCubit.getAuthCubit(context).getCurrentUser.cart.length;
  return BottomNavigationBarItem(
    label: '',
    icon: SizedBox(
      height: 55.0,
      child: Stack(
        children: <Widget>[
          selectedIndex == itemBarIndex
              ? Container(
                  alignment: Alignment.topCenter,
                  height: 4.8,
                  width: 44.0,
                  decoration: BoxDecoration(
                    color: selectedNavBarColor,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                )
              : Container(width: 44.0),
          Container(
            height: 44.0,
            padding: EdgeInsets.only(top: 6.0, left: 11.0),
            child: cartBadge
                ? BlocConsumer<ProductsCubit, ProductsStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return IconBadge(
                        icon: Icon(
                          Icons.notifications_none,
                          color: selectedIndex == itemBarIndex
                              ? selectedNavBarColor
                              : Colors.black87,
                        ),
                        itemCount: cartLength,
                        badgeColor: Colors.red,
                        itemColor: Colors.white,
                        hideZero: true,
                        onTap: null,
                      );
                    },
                  )
                : Icon(
                    icon,
                    color: selectedIndex == itemBarIndex
                        ? selectedNavBarColor
                        : Colors.black87,
                  ),
          )
        ],
      ),
    ),
  );
}

AppBar adminScreenAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
    backgroundColor: Colors.grey.shade200,
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    ),
  );
}
