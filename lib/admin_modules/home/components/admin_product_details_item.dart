import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../models/rating_model.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../user_modules/home/components/home_screen_appbar.dart';
import '../../../user_modules/home/components/product_rating_Stars.dart';

class adminProductDetailsItem extends StatefulWidget {
  final ProductModel product;
  adminProductDetailsItem({
    required this.product,
  });

  @override
  State<adminProductDetailsItem> createState() =>
      _adminProductDetailsItemState();
}

class _adminProductDetailsItemState extends State<adminProductDetailsItem> {
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
                              Theme.of(context).textTheme.displayMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
