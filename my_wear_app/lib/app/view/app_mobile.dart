import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wear_app/auth/loginPageMediator.dart';

class loginPageWraper extends StatefulWidget {
  const loginPageWraper({Key? key}) : super(key: key);

  @override
  _loginPageWraperState createState() => _loginPageWraperState();
}

class _loginPageWraperState extends State<loginPageWraper> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<SignInCubit>(
      create: (context) => SignInCubit()),
      BlocProvider<RegisterCredentialsCubit>(
      create: (context) => RegisterCredentialsCubit())
    ],
      child: loginPageMediator()
    );
  }
}
