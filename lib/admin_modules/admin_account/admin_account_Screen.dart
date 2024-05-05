import 'package:flutter/material.dart';
import '../../state_managment/auth_bloc/auth_cubit.dart';

class AdminAccountScreen extends StatelessWidget {
  const AdminAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authCubit = AuthCubit.getAuthCubit(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Name : ${_authCubit.getCurrentUser.name}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Email : ${_authCubit.getCurrentUser.email}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Type : ${_authCubit.getCurrentUser.type}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'ID : ${_authCubit.getCurrentUser.userID}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
             SizedBox(height: 15),
            Text(
              'Address : ${_authCubit.getCurrentUser.address}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.logout,
        ),
        onPressed: () {
          AuthCubit.getAuthCubit(context).logOut(
            context: context,
          );
        },
      ),
    );
  }
}
