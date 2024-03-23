import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wear_app/auth/login_page.dart';

class SignInCubit extends Cubit<bool> {
  SignInCubit() : super(false);
  bool is_signIn = false;
  void is_sign_in() {
    bool result = this.is_signIn;
    emit(result);
  }

  void set_signIn(bool value) {
    this.is_signIn = value;
    emit(value);
  }
}

class loginPageMediator extends StatefulWidget {
  const loginPageMediator({Key? key}) : super(key: key);

  @override
  _loginPageMediatorState createState() => _loginPageMediatorState();
}

class _loginPageMediatorState extends State<loginPageMediator> {
  @override
  Widget build(BuildContext context) {
    // Inicjalizacja SignInCubit
    return BlocProvider<SignInCubit>(
      create: (context) => SignInCubit(),
      child: BlocBuilder<SignInCubit, bool>(
        builder: (context, state) {
          // Warunkowe renderowanie w zależności od stanu isSignedIn
          if (state) {
            return UserPage(); // Załóżmy, że UserPage to inny widget, który chcesz wyświetlić
          } else {
            return LoginPage(); // LoginPage to widget logowania, który był już wcześniej zdefiniowany
          }
        },
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tutaj zaimplementuj wygląd strony użytkownika
    return Scaffold(
        body: Center(
      child: Column(children: [
        Text('UserPage'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text('LoginPage'),
        ),
      ]),
    ));
  }
}
