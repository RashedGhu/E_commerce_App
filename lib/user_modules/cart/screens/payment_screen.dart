import 'dart:io';

import 'package:amazon_clone_2024/user_modules/cart/payment/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../state_managment/products_bloc/products_cubit.dart';
import '../../../state_managment/products_bloc/products_states.dart';
import '../../../util/theme.dart';
import '../components/address_screen_appBar.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;
  PaymentScreen({
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final flatBuildingController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();

  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      PaymentItem(
        label: 'Item A',
        amount: '0.02',
        status: PaymentItemStatus.final_price,
      ),
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    onPaymentResult: (result) => debugPrint('payment result is $result'),
    loadingIndicator: Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
        label: 'Item A',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
    ],
    width: double.infinity,
    height: 50,
    onPaymentResult: (result) => debugPrint('payment result is $result'),
    loadingIndicator: Center(
      child: CircularProgressIndicator(),
    ),
  );

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAddress = AuthCubit.getAuthCubit(context).getCurrentUser.address;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: addressScreenAppbar(
          context: context, totalAmount: widget.totalAmount),
      body: BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    userAddress.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10  ,vertical: 10),
                                child: Text(
                                
                                  'Latest used address',
                                  
                                  style: TextStyle(
                                    color: Colors.black , 
                                    fontWeight: FontWeight.w500 ,
                                    fontSize: 20 , 
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200),
                                child: Text(
                                  userAddress,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'OR',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Flat, House no, Building',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: flatBuildingController,
                            hintText: 'Flat, House no, Building',
                          ),
                          SizedBox(height: 20),
                          Text('Area, Street',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: areaController,
                            hintText: 'Area, Street',
                          ),
                          SizedBox(height: 20),
                          Text('Pincode',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: pinCodeController,
                            hintText: 'Pincode',
                          ),
                          SizedBox(height: 20),
                          Text('City/Town',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: cityController,
                            hintText: 'City/Town',
                          ),
                          SizedBox(height: 50),
                          if (Platform.isAndroid)
                            googlePayButton
                          else if (Platform.isIOS)
                            applePayButton,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
