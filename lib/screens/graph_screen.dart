import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:convert';


import 'package:http/http.dart' as http;


class GenderData {
  final String gender;
  final int count;

  GenderData({required this.gender, required this.count});
}

class GenderChart extends StatelessWidget {
  final List<GenderData> data;

  GenderChart({required this.data});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey,Colors.lightBlueAccent]
        )
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: "Graph Chart",textStyle: TextStyle(
          color: Colors.white
        )),
        plotAreaBackgroundColor: Colors.white,



        primaryXAxis: CategoryAxis(title: AxisTitle(text: "Gender")),
        primaryYAxis: NumericAxis(title: AxisTitle(text: "Total Count")),
        series: <ColumnSeries<GenderData, String>>[
          ColumnSeries<GenderData, String>(
            dataSource: data,
            xValueMapper: (GenderData genderCount, _) => genderCount.gender,
            yValueMapper: (GenderData genderCount, _) => genderCount.count,
            name: "Gender Counts",
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),

    );
  }
}


Future<List<GenderData>> fetchData() async {
  final response = await http.get(Uri.parse('https://my.api.mockaroo.com/users.json?key=cae17ac0'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    int maleCount = 0;
    int femaleCount = 0;
    json.forEach((data) {
      if (data['gender'] == 'Male') {
        maleCount += 1;
      } else if (data['gender'] == 'Female') {
        femaleCount += 1;
      }

    });
    print(" male" +maleCount.toString());
    return [

      GenderData(gender: 'Male', count: maleCount),
      GenderData(gender: 'Female', count: femaleCount),
    ];
  } else {
    throw Exception('Failed to fetch data');
  }
}


class GraphScreen extends StatelessWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<GenderData>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GenderChart(data: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }}
