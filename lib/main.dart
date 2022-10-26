// テキストのJSONを読み込んでDataTableに表示
import 'package:flutter/material.dart';
import 'dart:convert';

class Data {
  String? name;
  String? age;
  String? sex;

  Data({this.name, this.age, this.sex});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['sex'] = sex;
    return data;
  }
}

void main() {
  runApp(const DataTableTest());
}

class DataTableTest extends StatefulWidget {
  const DataTableTest({super.key});

  @override
  State<DataTableTest> createState() => _DataTableTestState();
}

const title = ['名前', '年齢', '性別'];
const list = '''
  [
  {"name": "山田", "age": "56", "sex": "男"},
  {"name": "佐藤", "age": "39", "sex": "女"},
  {"name": "伊藤", "age": "29", "sex": "男"}
  ]
''';

List<dynamic> array = <dynamic>[];
List<Data> datas = <Data>[];

class _DataTableTestState extends State<DataTableTest> {
  @override
  void initState() {
    super.initState();
    array = json.decode(list);
    datas = array.map((data) => Data.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('DataTable')),
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text('名前'),
                  ),
                  DataColumn(
                    label: Text('年齢'),
                  ),
                  DataColumn(
                    label: Text('性別'),
                  ),
                ],
                rows: datas
                    .map(
                      (e) => DataRow(cells: [
                        DataCell(
                          Text(e.name ?? ''),
                        ),
                        DataCell(
                          Text(e.age ?? ''),
                        ),
                        DataCell(
                          Text(e.sex ?? ''),
                        ),
                      ]),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
