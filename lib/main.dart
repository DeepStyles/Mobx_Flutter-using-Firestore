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
      title: 'Mobx with Firestore Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MobxFirestore(),
    );
  }
}

class MobxFirestore extends StatefulWidget {
  const MobxFirestore();

  @override
  _MobxFirestoreState createState() => _MobxFirestoreState();
}

class _MobxFirestoreState extends State<MobxFirestore> {
  final TextEditingController _firstNamecont = TextEditingController();
  final TextEditingController _lastNamecont = TextEditingController();
  FocusNode _firstFocusNode = new FocusNode();
  FocusNode _lastFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    firestore.getFromFirestore();
    return Scaffold(
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
            focusNode: _firstFocusNode,
          ),
          TextField(
            controller: _lastNamecont,
            focusNode: _lastFocusNode,
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text('Push to Firestore'),
            onPressed: () {
              var fullname = Fullname(_firstNamecont.text, _lastNamecont.text);
              firestore.pushToFirestore(fullname);
              _firstNamecont.clear();
              _lastNamecont.clear();
              _firstFocusNode
                  .unfocus(); //Just to get rid of annoying onScreen keyboard
              _lastFocusNode
                  .unfocus(); //Just to get rid of annoying onScreen keyboard
              //  print('${_firstNamecont.text}---${_lastNamecont.text}');
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
        child: const Icon(Icons.publish),
      ),
    );
  }
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
                background: Container(
                  color: Colors.redAccent.shade200,
                ),
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
