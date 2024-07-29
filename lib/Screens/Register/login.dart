import 'package:apprestaurant/Screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Login extends StatefulWidget {
  final MySQLConnection conn;

  const Login({
    required this.conn,
    super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String user = '';
  String password = '';
  bool vizuPassword = false;
  int? idUser;

  Future login() async {
      var resultado = await widget.conn.execute("SELECT * FROM users WHERE user = '$user' AND password = '$password' ");

      var count = resultado.numOfRows;

    // ignore: prefer_is_empty
    if (count > 0) {
      print("Login sucess");
      var result = await widget.conn.execute("SELECT * FROM users WHERE User =  '$user' ");

      for (var element in result.rows) {
        Map data = element.assoc();
        idUser = data['ID_User'];
      }

      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Homepage(
        conn: widget.conn,
        idUser: idUser),));
        
    }else{
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user,
          password: password,
        );
        var result = await widget.conn.execute("SELECT * FROM users WHERE User =  '$user' ");

      for (var element in result.rows) {
        Map data = element.assoc();
        idUser = data['ID_User'];
      }

      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Homepage(
        conn: widget.conn,
        idUser: idUser),));

      } catch (e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login error'),
          content: const Text('User/Email or Password wrong.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0),
          child: Container(
            color: Colors.grey,
            width: 410,
            height: 400,
            child:  Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text('Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          
                          onChanged: (valueU) {
                            user = valueU;
                          },
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal()
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'User or Email',
                            labelStyle: TextStyle(
                              color: Colors.black
                            ) 
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          obscureText: vizuPassword,
                          onChanged: (valueP) {
                            password = valueP;
                          },
                          style: const TextStyle(
                            color: Colors.black
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal()
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.black
                            ) 
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            vizuPassword = !vizuPassword;
                          });
                        }, icon: const Icon(Icons.remove_red_eye,
                        color: Colors.white,))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(LinearBorder())
                      ),
                      onPressed: () {
                        login();
                      }, child: const Text('Login',
                      style: TextStyle(
                        color: Colors.black
                      ),),
                      ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      
                    }, child: const Text('Forgot Password ?',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    ),
                    SizedBox(
                    width: 300,
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                        shape: WidgetStatePropertyAll(LinearBorder())
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      }, child: const Text('Register',
                      style: TextStyle(
                        color: Colors.black
                      ),
                      ),
                      ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}