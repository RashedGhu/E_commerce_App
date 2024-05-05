import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../models/product_model.dart';
import '../../../models/rating_model.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../../state_managment/products_bloc/products_states.dart';
import '../../../util/theme.dart';
import '../components/home_screen_appbar.dart';
import '../components/product_rating_Stars.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  ProductDetailsScreen({
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double _avgRating = 0;
  dynamic _myRating = 0;
  int imageSliderCurrentIndex = 0;
  final imagesController = CarouselController();
  @override
  void initState() {
    super.initState();

    double totalRating = 0;
    for (RatingModel item in widget.product.ratings) {
      totalRating += item.ratings;

      if (item.userID ==
          AuthCubit.getAuthCubit(context).getCurrentUser.userID) {
        _myRating = item.ratings;
      }
    }

    if (totalRating != 0) {
      _avgRating = totalRating / widget.product.ratings.length;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   widget.product.name,
                //   style: Theme.of(context).textTheme.headline2!.copyWith(
                //         fontWeight: FontWeight.w500,
                //         fontStyle: FontStyle.italic,
                //       ),
                // ),
                // SizedBox(height: 10),

                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CarouselSlider(
                        carouselController: imagesController,
                        options: CarouselOptions(
                          height: 400,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              imageSliderCurrentIndex = index;
                            });
                          },
                        ),
                        items: widget.product.images.map((item) {
                          return ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.grey.shade100, BlendMode.multiply),
                            child: Builder(
                              builder: (context) {
                                return CachedNetworkImage(
                                  imageUrl: item,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      height: 25,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black38,
                      ),
                      child: Center(
                        child: Text(
                          "${imageSliderCurrentIndex + 1}/ ${widget.product.images.length}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'AED',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                '${widget.product.price}.0',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          ProductRatingStar(rating: _avgRating),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Text(
                          widget.product.description,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'ASIN',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                      Divider(
                        height: 15,
                        color: Colors.black54,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 1, top: 5),
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.product.productID,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      customElevatedButton(
                        primaryColor: Colors.teal[300],
                        onPressed: () {
                          ProductsCubit.getProductCubit(context)
                              .addOrIncreaseCart(
                            context: context,
                            productID: widget.product.productID,
                          );
                        },
                        title: 'Add To Cart',
                        titleColor: Colors.white,
                      ),
                      SizedBox(height: 10),
                      customElevatedButton(
                        primaryColor: Colors.teal[300],
                        onPressed: () {
                          ProductsCubit.getProductCubit(context)
                              .addOrIncreaseCart(
                            context: context,
                            productID: widget.product.productID,
                          );
                        },
                        title: 'Buy',
                        titleColor: Colors.white,
                      ),
                      Divider(
                        height: 15,
                        color: Colors.black54,
                      ),
                      SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          'Rate This Product ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      BlocConsumer<ProductsCubit, ProductsStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return RatingBar.builder(
                            initialRating: _myRating.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemPadding: EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            allowHalfRating: true,
                            itemBuilder: (context, index) {
                              return Icon(
                                Icons.star_purple500_outlined,
                                size: 5,
                                color: secondaryColor,
                              );
                            },
                            onRatingUpdate: (rating) {
                              ProductsCubit.getProductCubit(context)
                                  .ratingProduct(
                                context: context,
                                product: widget.product,
                                rating: rating,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
