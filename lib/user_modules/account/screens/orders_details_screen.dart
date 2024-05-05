
import 'package:flutter/material.dart';
import '../../../models/order_model.dart';
import '../../cart/components/order_tracking_section.dart';
import '../../home/components/home_screen_appbar.dart';
import '../components/order_over_view_section.dart';
import '../components/order_purchase_details.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;
  OrderDetailsScreen({
    required this.order,
  });
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                orderOverViewSection(
                  date: widget.order.orderedAt,
                  orderID: widget.order.id,
                  totalPrice: widget.order.totalPrice,
                  context: context,
                ),
                const SizedBox(height: 20),
                orderPurchaseDetailsSection(
                  context: context,
                  order: widget.order,
                ),
                SizedBox(height: 20),
                OrderTrackingSection(order: widget.order),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
