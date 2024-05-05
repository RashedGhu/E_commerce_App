import 'package:amazon_clone_2024/user_modules/cart/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/cart_model.dart';
import '../../../shared/custom_page_route.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../../state_managment/products_bloc/products_states.dart';
import '../../home/components/adress_section.dart';
import '../../home/components/home_screen_appbar.dart';
import '../components/cart_item.dart';
import '../components/cart_subtotal_section.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final user = AuthCubit.getAuthCubit(context).getCurrentUser;
        double totalSum = 0;

        for (CartModel item in user.cart) {
          totalSum = totalSum + item.quantity * item.product.price;
        }
        return Scaffold(
          appBar: homeScreenAppBar(
            context: context,
            activateSearchApi: true,
          ),
          body: totalSum == 0
              ? Column(
                  children: [
                    addressSection(context: context),
                    SizedBox(height: 150),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 30),
                    Icon(
                      Icons.remove_shopping_cart_rounded,
                      size: 100,
                    )
                  ],
                )
              : Column(
                  children: [
                    addressSection(context: context),
                    SizedBox(height: 10),
                    CartSubtotalSection(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customElevatedButton(
                        primaryColor: Colors.teal[300],
                        titleColor: Colors.white,
                        title: 'Proceed To Buy (${user.cart.length} items)',
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: PaymentScreen(
                                totalAmount: totalSum.toString(),
                              ),
                              direction: AxisDirection.right,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black12.withOpacity(0.08),
                    ),
                    SizedBox(height: 5),
                    AuthCubit.getAuthCubit(context)
                            .getCurrentUser
                            .cart
                            .isNotEmpty
                        ? NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (notification) {
                              notification.disallowIndicator();
                              return false;
                            },
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final CartModel cartItem =
                                      AuthCubit.getAuthCubit(context)
                                          .getCurrentUser
                                          .copyCart![index];
                                  return CartItem(
                                    cartItem: cartItem,
                                  );
                                },
                                itemCount: user.cart.length,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
        );
      },
    );
  }
}
