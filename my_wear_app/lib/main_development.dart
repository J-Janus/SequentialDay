import 'package:my_wear_app/app/app.dart';
import 'package:my_wear_app/bootstrap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future main() async {
  bootstrap(() => const App());
  await dotenv.load(fileName: ".env");
}
