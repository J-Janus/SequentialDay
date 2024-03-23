import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as GoogleAPI;
import 'package:http/io_client.dart' show IOClient, IOStreamedResponse;
import 'package:http/http.dart' show BaseRequest, Response;
import 'package:my_wear_app/auth/loginPageMediator.dart';





class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 107, 64, 64),
        appBar: AppBar(
          title: Text('LoginBar'),
        ),
        body: SafeArea(
            child: Center(
                child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(Icons.person, size: 50),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await AuthService().signInWithGoogle();
                context.read<SignInCubit>().set_signIn(true);
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                context.read<SignInCubit>().set_signIn(false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const loginPageMediator()),
                );
                
              },
              child: const Text('Logout'),
              
            ),
          ],
        ))));
  }
}


class AuthService {

  Future<User?> signInWithGoogle() async {
    try {
      // await GoogleSignIn().signOut(); 
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          GoogleAPI.CalendarApi.calendarScope,
        ],
      ).signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<void> signOut() async {
  await GoogleSignIn().signOut(); 
  }

Future<List<GoogleAPI.Event>> getGoogleEventsData(GoogleSignInAccount googleUser) async {
  final GoogleAPIClient httpClient =
      GoogleAPIClient(await googleUser.authHeaders);
  final GoogleAPI.CalendarApi calendarAPI = GoogleAPI.CalendarApi(httpClient);
  final GoogleAPI.Events calEvents = await calendarAPI.events.list(
    "primary",
  );
  final List<GoogleAPI.Event> appointments = <GoogleAPI.Event>[];
  // if (calEvents != null && calEvents.items != null) {
  //   for (int i = 0; i < calEvents.items.length; i++) {
  //     final GoogleAPI.Event event = calEvents.items[i];
  //     if (event.start == null) {
  //       continue;
  //     }
  //     appointments.add(event);
  //   }
  // }
  return appointments;
}
}

class GoogleAPIClient extends IOClient {
  final Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url,
          headers: (headers != null ? (headers..addAll(_headers)) : headers));
}


