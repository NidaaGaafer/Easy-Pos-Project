import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:my_easy_pos/helpers/sql_helpert.dart';
import 'package:my_easy_pos/models/clients_data.dart';
import 'package:my_easy_pos/pages/clientops.dart';
import 'package:my_easy_pos/widgets/search.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  List<ClientData>? clients;
  @override
  void initState() {
    getClientData();
    super.initState();
  }

  void getClientData() async {
    try {
      var sqlHelpert = GetIt.I.get<SqlHelpert>();
      var data = await sqlHelpert.db!.query('clients');

      if (data.isNotEmpty) {
        clients = [];
        for (var item in data) {
          clients!.add(ClientData.fromJson(item));
        }
      } else {
        clients = [];
      }
    } catch (e) {
      clients = [];
      print('error when get data $e');
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Client Page"),
          actions: [
            IconButton(
                onPressed: () async {
                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => ClientOpsPage()));
                  if (result ?? false) {
                    getClientData();
                  }
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              SearchTextField(tableName: 'clients'),
              SizedBox(height: 10),
              Expanded(
                child: PaginatedDataTable2(
                  columns: [
                    DataColumn(label: Text('id')),
                    DataColumn(label: Text('name')),
                    DataColumn(label: Text('email')),
                    DataColumn(label: Text('phone')),
                    DataColumn(label: Text('actions')),
                  ],
                  headingRowColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor),
                  headingTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
                  border: TableBorder.all(),
                  renderEmptyRowsInTheEnd: false,
                  isHorizontalScrollBarVisible: true,
                  columnSpacing: 10,
                  minWidth: 600,
                  source: MyDataTableSource(clients, getClientData),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyDataTableSource extends DataTableSource {
  List<ClientData>? addclients;
  void Function() getClientData;
  MyDataTableSource(this.addclients, this.getClientData);
  @override
  DataRow? getRow(int index) {
    return DataRow2(cells: [
      DataCell(Text('${addclients?[index].id}')),
      DataCell(Text('${addclients?[index].name}')),
      DataCell(Text('${addclients?[index].email}')),
      DataCell(Text('${addclients?[index].phone}')),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              deletRow(addclients?[index].id ?? 0);
            },
            icon: Icon(Icons.delete),
            color: Colors.red,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          )
        ],
      ))
    ]);
  }

  Future<void> deletRow(int id) async {
    try {
      var sqlHelpert = GetIt.I.get<SqlHelpert>();
      var result = await sqlHelpert.db!
          .delete('clients', where: 'id =?', whereArgs: [id]);
      if (result >= 0) {
        getClientData();
      }
    } catch (e) {
      print('error when delet this row $e');
    }
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => addclients?.length ?? 0;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
