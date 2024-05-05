import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../models/product_model.dart';
import '../../../shared/custom_page_route.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/admin_bloc/admin_cubit.dart';
import '../../../state_managment/admin_bloc/admin_states.dart';
import '../components/admin_product_item.dart';
import 'add_new_product_screen.dart';

class AdminProductsScreen extends StatefulWidget {
  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  List<ProductModel>? _fetchedProducts;
  void fetchAllProducts() async {
    _fetchedProducts = await AdminTransactionsCubit.getProductCubit(context)
        .fetchAllAdminProducts(context);
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminTransactionsCubit, AdminTransactionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is DeleteProductSuccessState) {
          _fetchedProducts!.removeWhere(
            (element) => element.productID == state.productID,
          );
        }
        return Scaffold(
          body: _fetchedProducts == null
              ? customProgressIndecator()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                    CustomPageRoute(
                                      child: AddNewProductsScreen(),
                                      direction: AxisDirection.right,
                                    ),
                                  )
                                  .then((future) {});
                            },
                            title: "Add New Item"),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 50,
                          crossAxisSpacing: 4,
                          children: _fetchedProducts!.map((item) {
                            return adminProductItem(
                              product: item,
                              context: context,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
         
        );
      },
    );
  }
}
