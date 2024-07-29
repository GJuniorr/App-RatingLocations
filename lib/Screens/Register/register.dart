import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Register extends StatefulWidget {
  final MySQLConnection conn;

  const Register({
    required this.conn,
    super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String user = '';
  String email = '';
  String emailConfirme = '';
  String password = '';
  bool vizuPassword = false;
  String passwordConfirme = '';
  bool vizuPasswordConfirme = false;

  List<Map<String, String>> dados = [];
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  Future saveUser() async {
    try {
       await _auth.createUserWithEmailAndPassword(email: email, password: password);

    final Map<String, dynamic> parameters = {'User': user, 'Password': password, 'Email': email};

    // Executa a consulta SQL com o mapa de parâmetros
    await widget.conn.execute('INSERT INTO users (User, Password, Email) VALUES (:User, :Password, :Email)', parameters);
    await widget.conn.execute('COMMIT');
    print('User register sucess');
    Navigator.pushNamed(context, 'homepage');
  } catch (e) {
    print('Error for save user: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Container(
              color: Colors.grey,
              width: 410,
              height: 520,
              child:  Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    ),
                  ),
                  SizedBox(
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
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'User',
                              labelStyle: TextStyle(
                                color: Colors.black
                              ) 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            
                            onChanged: (valueE) {
                              email = valueE;
                            },
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.black
                              ) 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            
                            onChanged: (valueEC) {
                              emailConfirme = valueEC;
                            },
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Confirme Email',
                              labelStyle: TextStyle(
                                color: Colors.black
                              ) 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
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
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
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
                          }, icon: Icon(Icons.remove_red_eye,
                          color: Colors.white,))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            obscureText: vizuPasswordConfirme,
                            onChanged: (valuePC) {
                              passwordConfirme = valuePC;
                            },
                            style: TextStyle(
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Confirme Password',
                              labelStyle: TextStyle(
                                color: Colors.black
                              ) 
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              vizuPasswordConfirme = !vizuPasswordConfirme;
                            });
                          }, icon: Icon(Icons.remove_red_eye,
                          color: Colors.white,))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: 150,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(StadiumBorder())
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                              }, child: Text('Back',
                              style: TextStyle(
                                color: Colors.black
                              ),),
                              ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                            width: 150,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(StadiumBorder())
                              ),
                              onPressed: () {
                                if (email != emailConfirme) {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Email does not match Confirm Email'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }, child: Text('Back'))
                                        ],
                                      );
                                    },
                                    );
                                } if(password != passwordConfirme){
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Password does not match Confirm Password'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }, child: Text('Back'))
                                        ],
                                      );
                                    },
                                    );
                                } if (email != emailConfirme && password != passwordConfirme) {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Email and Password does not match Confirm'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }, child: Text('Back'))
                                        ],
                                      );
                                    },
                                    );
                                } else {
                                  saveUser();
                                  //Navigator.pushNamed(context, 'homepage');
                                }
                              }, child: Text('Create Account',
                              style: TextStyle(
                                color: Colors.black
                              ),),
                              ),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}