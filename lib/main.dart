import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fod/admin/add_food.dart';
import 'package:fod/admin/admin_login.dart';
import 'package:fod/admin/itemcheck.dart';
import 'package:fod/pages/Order.dart';
import 'package:fod/pages/app_constant.dart';
import 'package:fod/pages/bottomnav.dart';
import 'package:fod/pages/details.dart';
import 'package:fod/pages/home.dart';
import 'package:fod/pages/home_admin.dart';
import 'package:fod/pages/login.dart';
import 'package:fod/pages/onboard.dart';
import 'package:fod/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Stripe.publishableKey = publishableKey;

try {
  if (kIsWeb) {

    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyChSVvX43N8idGMXKIcKHF80pO7dD9z350",
          authDomain: "foodapp-7fdfa.firebaseapp.com",
          projectId: "foodapp-7fdfa",
          storageBucket: "foodapp-7fdfa.appspot.com",
          messagingSenderId: "852952435628",
          appId: "1:852952435628:web:e63c93273b909c95578809",
          measurementId: "G-Y6XTQ3SD43"
      ),
    );
  } else {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyChSVvX43N8idGMXKIcKHF80pO7dD9z350",
          authDomain: "foodapp-7fdfa.firebaseapp.com",
          projectId: "foodapp-7fdfa",
          storageBucket: "foodapp-7fdfa.appspot.com",
          messagingSenderId: "852952435628",
          appId: "1:852952435628:web:e63c93273b909c95578809",
          measurementId: "G-Y6XTQ3SD43",
        ),
      );
    } else if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyChSVvX43N8idGMXKIcKHF80pO7dD9z350",
          authDomain: "foodapp-7fdfa.firebaseapp.com",
          projectId: "foodapp-7fdfa",
          storageBucket: "foodapp-7fdfa.appspot.com",
          messagingSenderId: "852952435628",
          appId: "1:852952435628:web:e63c93273b909c95578809",
          measurementId: "G-Y6XTQ3SD43",
        ),
      );

    }
  }
}catch (e) {
  print('Error initializing Firebase: $e');

}


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),

      home: SignUp(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
