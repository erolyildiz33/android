import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'vale.dart';
import 'Services.dart';

class Page1 extends StatefulWidget {
  Page1() : super();

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  late List<Vale> _Vales;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final String title = "Flutter Data Table";
  late Vale _selectedVale;
  late IO.Socket socket;
  @override
  void initState() {
    _Vales = [];
    IO.Socket socket = IO.io('http://185.95.164.242:3300/', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('vale', (data) {
      _getVales();
    });
    socket.on('disconnect', (_) => print('disconnect'));
    socket.connect();
    _scaffoldKey = GlobalKey();

    super.initState();
    _getVales();
  }

  _getVales() {
    Services.liste().then((Vales) {
      setState(() {
        _Vales = Vales;
      });
    });
  }

  _updateVale(String Vale) {
    Services.updateVale(Vale).then((result) {
      if ('success' == result) {}
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text("SIRA NO"),
                numeric: false,
                tooltip: "This is the Vale id"),
            DataColumn(
                label: Text(
                  "PLAKA",
                ),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("SAAT"),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("İŞLEM"),
                numeric: false,
                tooltip: "This is the last name"),
          ],
          rows: _Vales.map(
            (Vale) => DataRow(
              cells: [
                DataCell(
                  Text((_Vales.indexOf(Vale) + 1).toString()),
                ),
                DataCell(
                  Text(
                    Vale.plaka,
                  ),
                ),
                DataCell(
                  Text(
                    Vale.zaman,
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _updateVale(Vale.id);
                      _getVales();
                    },
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title.toString()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getVales();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dataBody(),
            )
          ],
        ),
      ),
    );
  }
}
