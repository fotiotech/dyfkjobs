import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:flutter_app_1/pages/admin/AdminPanel.dart';
import 'package:flutter_app_1/pages/users/account.dart';
import 'package:flutter_app_1/pages/users/auth/authprovider.dart';
import 'package:flutter_app_1/pages/users/auth/authwidget.dart';
import 'package:flutter_app_1/pages/users/signin.dart';
import 'package:flutter_app_1/pages/users/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    bool ready = await GRecaptchaV3.ready(
        "6LeOJeQpAAAAACs76qV_eKQLj7WOdf-bhmKryQcW",
        showBadge: true); //--2
    print("Is Recaptcha ready? $ready");
  }

  runApp(const MyApp());
}

// void generateToken() async {
//   String? token = await GRecaptchaV3.execute('fotio'); //--3
//   print(token);
//   // send token to server and verify
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Sans'),
          initialRoute: '/',
          routes: {
            '/signup': (context) => SignUpPage(),
            '/login': (context) => SignInPage(),
            '/account': (context) => const Account(),
            '/admin': (context) => const AdminPanel()
          },
          home: const AuthWidget(),
        ));
  }
}
