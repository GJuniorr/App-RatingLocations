import 'dart:async';

import 'package:apprestaurant/Screens/Menu/addLocations.dart';
import 'package:apprestaurant/Screens/Register/register.dart';
import 'package:apprestaurant/Screens/homepage.dart';
import 'package:apprestaurant/Screens/Register/login.dart';
import 'package:apprestaurant/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late MySQLConnection conn;
  Timer? connectionCheckTimer;
  
  

  void startConnectionChecker() {
    connectionCheckTimer = Timer.periodic(Duration(minutes: 30), (timer) async {
     conn.onClose(
      getConnection
     );
    });
  }

  @override
  void initState() {
    getConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MySQLConnection>(
      future: getConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          final conn = snapshot.data!;
          return MyAppWithConnection(conn: conn);
        }
      },
    );
  }
}

Future<MySQLConnection> getConnection() async {
  final conn = await MySQLConnection.createConnection(
    host: '',
    port: ,
    userName: '',
    password: '',
    databaseName: 'apprestaurant',
  );
  try {
    await conn.connect();
    print('Connection success');
  } catch (e) {
    print('Error connecting to the database: $e');
    throw e;
  }
  return conn;
}

class MyAppWithConnection extends StatelessWidget {
  final MySQLConnection conn;

  const MyAppWithConnection({required this.conn, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: 'homepage',
      routes: {
        'login': (context) => Login(
          conn: conn
          ),
        'register': (context) => Register(
          conn: conn
          ),
          'homepage': (context) => Homepage(
            conn: conn,
            idUser: 0,
          ),
          'addLocations': (context) => Addlocations(
            conn: conn,
            idUser: 0,
          )
      },
    );
  }
}
