import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../layout/admin_layout.dart';
import '../../layout/user_Layout.dart';
import '../../models/Auth_model.dart';
import '../../models/user_model.dart';
import '../../shared/shared_components.dart';
import '../../user_modules/auth/screens/auth_screen.dart';
import '../../util/http_req.dart';
import '../../util/local_storage.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit getAuthCubit(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);

  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print("Trying to signup");
      UserModel _signedUpUser = new UserModel(
        name: name,
        email: email,
        password: password,
        address: '',
        userID: '',
        type: '',
        token: '',
        cart: [],
      );

      final http.Response _response = await HttpReq.postData(
        endpoint: '/api/signup',
        reqBody: _signedUpUser.sendJson(),
      );
      final AuthModel _authModel;
      _authModel = AuthModel.getJson(resData: json.decode(_response.body));
      _signedUpUser = _authModel.userData!;
      requestsStatusHandler(
        response: _response,
        context: context,
        onSuccess: () {
          emit(SignUpSuccessState());
          showSnackBar(
            context,
            _authModel.msg,
          );
        },
      );
    } catch (error) {
      print('client side sign up error is $error');
      emit(SignUpErrorState());
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginInitialState());
    try {
      final _response =
          await HttpReq.postData(endpoint: '/api/login', reqBody: {
        'email': '$email',
        'password': '$password',
      });

      final _authModel =
          AuthModel.getJson(resData: json.decode(_response.body));
      final UserModel? _loggedInUser = _authModel.userData;

      requestsStatusHandler(
        response: _response,
        context: context,
        onSuccess: () async {
          setCurrentUser = _loggedInUser!;
          final bool isSaved = await CashHelper.saveDataInCash(
            key: 'auth_token',
            value: _loggedInUser.token,
          );
          if (isSaved) {
            showSnackBar(context, _authModel.msg);
            Navigator.pushNamedAndRemoveUntil(
              context,
              getCurrentUser.type == 'admin'
                  ? AdminScreenLayout.routeName
                  : UserHomeScreenLayout.routeName,
              (route) => false,
            );
            emit(LoginSuccessState());
          }
        },
      );
    } catch (e) {
      print('client side login error is' + e.toString());
      emit(LoginErrorState());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      String? token = CashHelper.getCashData(key: 'auth_token');
      if (token!.isEmpty) {
        await CashHelper.saveDataInCash(key: 'auth_token', value: '');
      } else {
        final response = await HttpReq.postData(
          endpoint: '/token_validation',
          reqBody: {},
          token: token,
        );
        final isTokenVefiriedResp = jsonDecode(response.body);
        if (isTokenVefiriedResp == true) {
          final userDataResponse = await HttpReq.fetchData(
            endpoint: "/user_data",
            token: token,
          );
          setCurrentUser = UserModel.getJson(
            json.decode(
              userDataResponse.body,
            ),
          );

          emit(FetchUserDataSuccessState());
        }
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  UserModel _currentUser = UserModel(
    name: '',
    email: '',
    password: '',
    address: '',
    userID: '',
    type: '',
    token: ',',
    cart: [],
  );
  set setCurrentUser(UserModel user) {
    user.address = 'Abu Dhabi , Mussafah Industrial Area , Near Alansari for exchange';
    _currentUser = user;
  }

  UserModel get getCurrentUser => _currentUser;

  bool isCheckedEmail = false;
  void togglePasswordVisibility({required bool? value}) {
    isCheckedEmail = value!;
    emit(TogglePasswordVisibilityState());
  }

  bool isChecked = false;
  void togglePasswordVisibilitySecond({required bool? value}) {
    isChecked = value!;
    emit(TogglePasswordVisibilitySecondState());
  }

  Future<void> logOut({required BuildContext context}) async {
    try {
      await CashHelper.saveDataInCash(key: "auth_token", value: '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutErrorSate());
      showSnackBar(context, e.toString());
    }
  }
}
