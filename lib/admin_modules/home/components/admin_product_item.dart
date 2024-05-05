import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../shared/custom_page_route.dart';
import '../../../state_managment/admin_bloc/admin_cubit.dart';
import 'admin_product_details_item.dart';

Widget adminProductItem({
  required ProductModel product,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context)
          .push(
            CustomPageRoute(
              child: adminProductDetailsItem(
                product: product,
              ),
              direction: AxisDirection.right,
            ),
          )
          .then((future) {});
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        SizedBox(
          height: 140,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Container(
                width: 188,
                padding: EdgeInsets.all(10),
                child: Image.network(
                  product.images[0],
                  fit: BoxFit.fitHeight,
                  width: 100,
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10),
            Expanded(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(color: Colors.black),
              ),
            ),
            IconButton(
              onPressed: () {
                AdminTransactionsCubit.getProductCubit(context).deleteProduct(
                  context: context,
                  productID: product.productID,
                );
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ],
    ),
  );
}
