import 'package:apprestaurant/Screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Addlocations extends StatefulWidget {
  final MySQLConnection conn;
  final int? idUser;
  const Addlocations({
    required this.conn,
    required this.idUser,
    super.key});

  @override
  State<Addlocations> createState() => _AddlocationsState();
}

class _AddlocationsState extends State<Addlocations> {

  List<bool> isSelected = List.generate(5, (index) => false);
  late double ratting = 0.0;
  late double _teste = 0.0;

  String name = '';
  String? dropDownType;
  List typesD = [
    'Restaurant',
    'Bar',
    'Beach',
    'Hotel'
  ]; 
  String description = '';

  Future salveLocation() async {
    try {
    final Map<String, dynamic> parameters = {'ID_User': widget.idUser, 'Name': name, 'Type': dropDownType, 'Description': description, 'Rating': ratting};

    // Executa a consulta SQL com o mapa de parâmetros
    await widget.conn.execute('INSERT INTO locations (ID_User, Name, Type, Description, Rating) VALUES (:ID_User, :Name, :Type, :Description, :Rating)', parameters);
    await widget.conn.execute('COMMIT');
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Homepage(
          conn: widget.conn, 
          idUser: widget.idUser),));
    print('Save Location succes');
  } catch (e) {
    print('Error save Location: $e');
  }
}


  /*void saveRatingA0(double ratingA0) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('ratingA0', ratingA0);
  print('Valor salvo $ratingA0');
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Container(
            width: 400,
            height: 350,
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      onChanged: (valueN) {
                        name = valueN;
                      },
                      style: const TextStyle(
                        color: Colors.black
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Location Name',
                        labelStyle: TextStyle(
                          color: Colors.black
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
        
                Padding(
                  padding: const EdgeInsets.only(right: 235.0),
                  child: DropdownButton<String>(
                    hint: const Text('Type',
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                    value: dropDownType,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropDownType = newValue!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Restaurant',
                        child: Text('Restaurant',
                        style: TextStyle(
                          color: Colors.white
                        ),)),
                  
                         DropdownMenuItem<String>(
                        value: 'Bar',
                        child: Text('Bar',
                        style: TextStyle(
                          color: Colors.white
                        ),)),
                  
                         DropdownMenuItem<String>(
                        value: 'Beach',
                        child: Text('Beach',
                        style: TextStyle(
                          color: Colors.white
                        ),)),
                  
                         DropdownMenuItem<String>(
                        value: 'Hotel',
                        child: Text('Hotel',
                        style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                        ),
                    ],
                   ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 350,
                    child: TextField(
                      onChanged: (valueD) {
                        description = valueD;
                      },
                      style: const TextStyle(
                        color: Colors.black
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Description (Optional)',
                        labelStyle: TextStyle(
                          color: Colors.black
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      children: [
                        Text('Rating:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                        ),
                        Wrap(
                          spacing: 0,
                          children: List.generate(
                            5, 
                            (index) => IconButton(
                              onPressed: () {
                                setState(() {
                                   ratting = index + 1;
                                    _teste = ratting;
                                   for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = i <= index;
                              }
                                });
                              }, icon: Icon(
                            isSelected[index]
                            ? Icons.star
                            : Icons.star_border,
                        color: isSelected[index] ? Colors.yellow : Colors.white,),
                        ),
                       ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                          SizedBox(
                            width: 350,
                            child: TextButton(
                              style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white),
                              shape: WidgetStatePropertyAll(LinearBorder())
                            ),
                            onPressed: () {
                              salveLocation();
                            }, child: Text('Create Location',
                            style: TextStyle(
                              color: Colors.black,
                            ),)),
                          ),
                    ],
            ),
          ),
        ),
      ),
    );
  }
}