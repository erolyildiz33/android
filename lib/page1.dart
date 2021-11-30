import 'package:flutter/material.dart';
import 'vale.dart';
import 'Services.dart';

class Page1 extends StatefulWidget {
  Page1() : super();

  final String title = "Flutter Data Table";

  @override
  Page1State createState() => Page1State();
}

class Page1State extends State<Page1> {
  late List<Vale> _Vales;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  late Vale _selectedVale;

  @override
  void initState() {
    super.initState();
    _Vales = [];

    _scaffoldKey = GlobalKey();

    _getVales();
  }

  _createTable() {
    Services.liste().then((result) {
      if ('success' == result) {
        _getVales();
      }
    });
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
                label: Text("ID"),
                numeric: false,
                tooltip: "This is the Vale id"),
            DataColumn(
                label: Text(
                  "FIRST",
                ),
                numeric: false,
                tooltip: "This is the last name"),
            DataColumn(
                label: Text("LAST"),
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
                  Text(Vale.id),
                ),
                DataCell(
                  Text(
                    Vale.plaka,
                  ),
                ),
                DataCell(
                  Text(
                    Vale.time,
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
        title: Text("Liste"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
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
