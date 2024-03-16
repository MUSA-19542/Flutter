import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/login_page.dart';
import 'package:my_first_app/chat_page.dart';
import 'package:my_first_app/services/auth_service.dart';
import 'package:my_first_app/widgets/counter_stateful_demo.dart';
import 'package:provider/provider.dart';

void main() async {
 await AuthService.init();
  runApp(ChangeNotifierProvider(create: (BuildContext context) => AuthService(),
  child: ChatApp()));
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChatApp !!",
      theme: ThemeData(
        canvasColor: Color(0xFF8D0900),
          primarySwatch: Colors.red,
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF8D0900),
              foregroundColor: Colors.black)),
      //home:CounterStateful(buttonColor:Colors.blue),
      // home: LoginPage(),
       home: FutureBuilder<bool>
         (
         future: context.read<AuthService>().isLoggedIn(),
         builder:(context,AsyncSnapshot<bool> snapshot)
         {
           if(snapshot.connectionState == ConnectionState.done)
             {
               if(snapshot.hasData && snapshot.data!)
                 {
                   return ChatPage();
                 }else return LoginPage();
             }
           return CircularProgressIndicator();
         }
       ),

      routes: {
        '/chat': (context) => ChatPage(),
      },
      // home:ChatPage(),
    );
  }
}
