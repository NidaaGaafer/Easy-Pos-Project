import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:my_easy_pos/helpers/sql_helpert.dart';
import 'package:my_easy_pos/pages/categories.dart';
import 'package:my_easy_pos/pages/categories.dart';
import 'package:my_easy_pos/pages/clients.dart';
import 'package:my_easy_pos/pages/products.dart';
import 'package:my_easy_pos/widgets/iconspage.dart';
import 'package:my_easy_pos/widgets/widget_1.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  bool isTableIntilized = false;

  @override
  void initState() {
    initlization();
    super.initState();
  }

  void initlization() async {
    var sqlHelper = GetIt.I.get<SqlHelpert>();
    isTableIntilized = await sqlHelper.createTables();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Easy Pos',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    isLoading
                        ? Transform.scale(
                            scale: .5,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : CircleAvatar(
                            backgroundColor: isTableIntilized
                                ? Color.fromARGB(255, 3, 160, 8)
                                : Colors.red,
                            radius: 5,
                          )
                  ],
                ),
                SizedBox(height: 20),
                Hcard(str1: 'Exchange rate', str2: '1 EUR = 11,712.25 UZS'),
                SizedBox(height: 10),
                Hcard(str1: 'Exchange rate', str2: '1 EUR = 11,712.25 UZS'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  HomeIcons(
                    icon: Icons.newspaper,
                    label: 'Categories',
                    color: Color.fromARGB(255, 214, 158, 2),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CategoriesPage()));
                    },
                  ),
                  HomeIcons(
                    icon: Icons.inventory_2,
                    label: 'Products',
                    color: Colors.pink,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => ProductsPage()));
                      //
                    },
                  ),
                  HomeIcons(
                    icon: Icons.newspaper,
                    label: 'All sales',
                    color: Color.fromARGB(255, 214, 158, 2),
                    onPressed: () {},
                  ),
                  HomeIcons(
                    icon: Icons.group,
                    label: 'Clients',
                    color: Color.fromARGB(255, 4, 131, 163),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => ClientsPage()));
                    },
                  ),
                  HomeIcons(
                    icon: Icons.shopping_basket,
                    label: 'New sale',
                    color: Color.fromARGB(255, 2, 155, 7),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
