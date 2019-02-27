import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_breathfresh/login.dart';
import 'package:mobx_breathfresh/firestore.dart';
import './fullnamemodel.dart';

final Login login = Login();
final Mobxfirestore firestore = Mobxfirestore();

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

class CounterExample extends StatefulWidget {
  const CounterExample();

  @override
  _CounterExampleState createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  final TextEditingController _firstNamecont = TextEditingController();
  final TextEditingController _lastNamecont = TextEditingController();
  String _firstName;
  String _lastName;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
          actions: <Widget>[
            Observer(
              builder: (_) {
                return IconButton(
                  icon: const Icon(Icons.account_box),
                  color: login.loginStatus.value ? Colors.green : Colors.red,
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
        body: Column(
          children: <Widget>[
            TextField(
              controller: _firstNamecont,
              /* onChanged: (val) {
                  _firstNamecont.text = val;
                  print('firstName: ${_firstNamecont.text}');
                */
            ),
            TextField(
              controller: _lastNamecont,
              /* onChanged: (val) {
                  _lastNamecont.text = val;
                  print('lastName: ${_lastNamecont.text}');
                } */
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text('Push to Firestore'),
              onPressed: () {
                var fullname =
                    Fullname(_firstNamecont.text, _lastNamecont.text);
                firestore.pushToFirestore(fullname);

                print('${_firstNamecont.text}---${_lastNamecont.text}');
              },
            ),
            SizedBox(
              height: 30,
            ),
            FirestoreListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            firestore.getFromFirestore();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

class FirestoreListView extends StatelessWidget {
  final Widget child;

  FirestoreListView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Flexible(
          child: ListView.builder(
            itemCount: firestore.fullNames.value.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(firestore.fullNames.value[index].documentID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    firestore
                        .delFromFirestore(firestore.fullNames.value[index]);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${firestore.fullNames.value[index].lastName}'),
                    subtitle:
                        Text('${firestore.fullNames.value[index].firstName}'),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
