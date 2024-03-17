import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' as GoogleAPI;
import 'package:http/io_client.dart' show IOClient, IOStreamedResponse;
import 'package:http/http.dart' show BaseRequest, Response;


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Strona główna"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Zaloguj się"),
          onPressed: () async {
            var user = await AuthService().signInWithGoogle();
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(user),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final User user;

  WelcomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Witaj"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Hello ${user.email}"),
      ),
    );
  }
}

class AuthService {
  Future<User?> signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut(); 
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
      var appointments = await getGoogleEventsData(googleUser);
      GoogleAPIClient(await googleUser.authHeaders);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
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