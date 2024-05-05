import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../models/product_model.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../../state_managment/products_bloc/products_states.dart';
import '../../../util/theme.dart';
import '../components/ad_slider.dart';
import '../components/adress_section.dart';
import '../components/Todays_Deal_Section.dart';
import '../components/home_screen_appbar.dart';
import '../components/horizontal_categories_section.dart';
import '../components/product_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductModel? _todaysDeal;
  List<ProductModel>? _allProducts;
  void getTodaysDeal() async {
    _todaysDeal = await ProductsCubit.getProductCubit(context)
        .getTodaysDeal(context: context);
  }

  void fetchAllProducts() async {
    _allProducts = await ProductsCubit.getProductCubit(context)
        .fecthAllProducts(context: context);
  }

  @override
  void initState() {
    getTodaysDeal();
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsStates>(
      // buildWhen: (previous, current) {
      //   if (current is FetchAllProductsSuccessState) {
      //     return true;
      //   }
      //   return false;
      // },
      listenWhen: (previous, current) {
        if (current is FetchAllProductsSuccessState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: homeScreenAppBar(
            context: context,
            activateSearchApi: true,
          ),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return false;
            },
            child: _allProducts == null
                ? customProgressIndecator()
                : LiquidPullToRefresh(
                    color: Colors.grey.shade100,
                    backgroundColor: Colors.black54,
                    animSpeedFactor: 10.0,
                    onRefresh: () async {
                      fetchAllProducts();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        addressSection(context: context),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Categories',
                            style: homeScreenHeadlineTextStyle,
                          ),
                        ),
                        horizontalCategoriesSection(context: context),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: TodaysDeal(
                            todaysDealProduct: _todaysDeal,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Take A Look ',
                            style: homeScreenHeadlineTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: adSliderSection(context: context),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Explore New Ideas ',
                            style: homeScreenHeadlineTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 50,
                            crossAxisSpacing: 4,
                            children: _allProducts!.map((item) {
                              return ProductItem(
                                product: item,
                                isExploreScreen: true,
                              );
                            }).toList(),
                          ),
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
