import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_breathfresh/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: CounterExample(),
    );
  }
}

final Login login = Login();

class CounterExample extends StatelessWidget {
  const CounterExample();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
          actions: <Widget>[
            Observer(
              builder: (_) {
                return IconButton(
                  icon: const Icon(Icons.account_box),
                  color: login.updatedLoginStatus ? Colors.green : Colors.red,
                  onPressed: () {
                    login.updatedLoginStatus
                        ? login.logoutAccount()
                        : login.googleLogin();
                  },
                );
              },
            ),
          ],
        ),
        body: Center(child: Text('fdsfsf')),
        floatingActionButton: FloatingActionButton(
          // onPressed: counter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
