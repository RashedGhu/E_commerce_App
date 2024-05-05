import 'package:flutter/material.dart';
import '../../../models/cart_model.dart';
import '../../../shared/custom_page_route.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../home/screens/product_details_screen.dart';

class CartItem extends StatelessWidget {
  final CartModel cartItem;
  CartItem({
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    void increaseCartQuantity() {
      ProductsCubit.getProductCubit(context).addOrIncreaseCart(
        context: context,
        productID: cartItem.product.productID,
        isshowToast: false,
      );
    }

    void decreaseQuantity() {
      ProductsCubit.getProductCubit(context).removeOrDecreaseFromCart(
        context: context,
        productID: cartItem.product.productID,
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(
            child: ProductDetailsScreen(product: cartItem.product),
            direction: AxisDirection.right,
          ),
        );
      },
      child: Container(
        child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // first component
                children: [
                  Image.network(
                    cartItem.product.images[0],
                    fit: BoxFit.fitHeight,
                    height: 135,
                    width: 135,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            color: Colors.black12,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: decreaseQuantity,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                  height: 32,
                                  width: 35,
                                ),
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                    width: 0.0,
                                  ),
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  height: 32,
                                  width: 66,
                                ),
                              ),
                              InkWell(
                                onTap: increaseCartQuantity,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                  height: 32,
                                  width: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    color: Colors.white,
                    child: Text(
                      cartItem.product.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: Text(
                      '\AED${cartItem.product.price}',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Elligible for free shiping',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'In stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
