import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_badge/icon_badge.dart';
import '../state_managment/auth_bloc/auth_cubit.dart';
import '../state_managment/products_bloc/products_cubit.dart';
import '../state_managment/products_bloc/products_states.dart';
import '../user_modules/account/screens/account_screen.dart';
import '../user_modules/cart/screens/cart_screen.dart';
import '../user_modules/home/screens/home_Screen.dart';

class UserHomeScreenLayout extends StatefulWidget {
  static const routeName = './Home_Screen_Layout';

  @override
  State<UserHomeScreenLayout> createState() => _UserHomeScreenLayoutState();
}

class _UserHomeScreenLayoutState extends State<UserHomeScreenLayout> {
  List<Widget> _tabs = [
    HomeScreen(),
    AccountScreen(),
    CartScreen(),
  ];
  int _selectedIndex = 0;
  final bucket = PageStorageBucket();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cartLength =
              AuthCubit.getAuthCubit(context).getCurrentUser.cart.length;
          return SizedBox(
            height: 70,
            child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              selectedFontSize: 12,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.teal[300],
              backgroundColor: Colors.grey.shade200,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Explore',
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.travel_explore_sharp, 
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Account',
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(Icons.person),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Cart',
                  icon: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: IconBadge(
                      icon: Icon(
                        Icons.shopping_cart,
                      ),
                      itemCount: cartLength,
                      badgeColor: Colors.red,
                      itemColor: Colors.white,
                      hideZero: true,
                      onTap: null,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      body: PageStorage(
        bucket: bucket,
        child: _tabs[_selectedIndex],
      ),
    );
  }
}
