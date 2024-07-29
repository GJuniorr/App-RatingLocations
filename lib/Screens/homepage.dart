import 'package:apprestaurant/Screens/Menu/addLocations.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class Homepage extends StatefulWidget {
  final MySQLConnection conn;
  final int? idUser;
  const Homepage({
    required this.conn,
    required this.idUser,
    super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

List<Map<String, String>> dados = [];

Future loadDB() async {
    var result = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' ORDER BY ID_Local ASC");

    List<Map<String, String>> list = [];

    for (final row in result.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future loadDBRestaurant() async {
    var resultRestaurant = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' AND Type = 'Restaurant' ORDER BY ID_Local ASC");

    List<Map<String, String>> list = [];

    for (final row in resultRestaurant.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future loadDBbar() async {
    var resultBar = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' AND Type = 'Bar' ORDER BY ID_Local ASC");

    List<Map<String, String>> list = [];

    for (final row in resultBar.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future loadDBbeach() async {
    var resultBeach = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' AND Type = 'Beach' ORDER BY ID_Local ASC");

    List<Map<String, String>> list = [];

    for (final row in resultBeach.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future loadDBhotel() async {
    var resultHotel = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' AND Type = 'Hotel' ORDER BY ID_Local ASC");

    List<Map<String, String>> list = [];

    for (final row in resultHotel.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future loadDBstar() async {
    var resultStar = await widget.conn.execute("SELECT * FROM locations WHERE ID_User = '$widget.idUser' ORDER BY Rating DESC");

    List<Map<String, String>> list = [];

    for (final row in resultStar.rows) {
      final data = {
        'ID_Local': row.colAt(0)!,
        'ID_User': row.colAt(1)!,
        'Name': row.colAt(2)!,
        'Type': row.colAt(3)!,
        'Description': row.colAt(4)!,
        'Rating': row.colAt(5)!,
      };
      list.add(data);
    }

    setState(() {
      dados = list;
    });
  }

  Future<void> loadDBFilters() async {
  if (restaurant) {
    await loadDBRestaurant();
  } else if (bar) {
    await loadDBbar();
  } else if (beach) {
    await loadDBbeach();
  } else if (hotel) {
    await loadDBhotel();
  } else if (star) {
    await loadDBstar();
  } else {
    await loadDB();
  }
}


  bool restaurant = false;
  bool bar = false;
  bool beach = false;
  bool hotel = false;
  bool star = false;

  @override
  void initState() {
    loadDBFilters();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('starLocations',
        style: TextStyle(
          color: Colors.yellow
        ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Menu'),
                    actions: [
                      Column(
                        children: [
                          Text('Para ver apenas restaurante clique no primeiro ícone'),
                          Text('Para ver apenas bar clique no segundo ícone'),
                          Text('Para ver apenas praia clique no terceiro ícone'),
                          Text('Para ver apenas hotel clique no quarto ícone'),
                          Text('Para adicionar algum local clique no último ícone'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            }, child: Text('Fechar'))
                        ],
                      )
                    ],
                  );
                },);
            }, icon: Icon(Icons.help,
            size: 25,
            color: Colors.white,))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 420,
            height: 50,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      restaurant = !restaurant;
                      bar = false;
                      beach = false;
                      hotel = false;
                      star = false;
                     loadDBFilters();
                    });
                  }, icon: Icon(Icons.restaurant,
                  size: 30,
                  color: restaurant ? Colors.blue : Colors.white),
                  ),
                  IconButton(
                  onPressed: () {
                    setState(() {
                      bar = !bar;
                      restaurant = false;
                      beach = false;
                      hotel = false;
                      star = false;
                      loadDBFilters();
                    });
                  }, icon: Icon(Icons.local_bar,
                  size: 30,
                  color: bar ? Colors.blue : Colors.white),
                  ),
                  IconButton(
                  onPressed: () {
                    setState(() {
                      beach = !beach;
                      restaurant = false;
                      hotel = false;
                      star = false;
                      loadDBFilters();
                    });
                  }, icon: Icon(Icons.beach_access,
                  size: 30,
                  color: beach ? Colors.blue : Colors.white),
                  ),
                  IconButton(
                  onPressed: () {
                    setState(() {
                      hotel = !hotel;
                      restaurant = false;
                      beach = false;
                      star = false;
                      loadDBFilters();
                    });
                  }, icon: Icon(Icons.hotel,
                  size: 30,
                  color: hotel ? Colors.blue : Colors.white),
                  ),
                  IconButton(
                  onPressed: () {
                    setState(() {
                      star = !star;
                      restaurant = false;
                      beach = false;
                      hotel = false;
                     loadDBFilters();
                    });
                  }, icon: Icon(Icons.star,
                  size: 30,
                  color: star ? Colors.blue : Colors.white),
                  ),
                  IconButton(
                  onPressed: () {
                     Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addlocations(
                        conn: widget.conn,
                        idUser: widget.idUser),));
                  }, icon: Icon(Icons.add_box,
                  size: 30,
                  color: Colors.white,),
                  ),
              ],
            ),
          ),
          Container(
            height: 553,
            width: 420,
            color: Colors.blue,
            child: ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
                int ratingL = int.parse(dados[index] ['Rating']!);
                return ListTile(
                  title: Row(
                    children: [
                      Text('${dados[index] ['Name'] ?? ''}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Wrap(
                          spacing: 5,
                          children: List.generate(
                            ratingL,
                            (index) => Icon(Icons.star,
                              color: Colors.yellow,),
                       ),
                        ),
                    ],
                  ),
                  subtitle: Text('${dados[index] ['Type'] ?? ''}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                  ),
                  ),
                );
              },
              ),
          )
        ],
      ),
    );
  }
}