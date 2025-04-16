

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          title:Text("Expense Graph",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w400,color:Colors.red,)
          )),
      body: Container(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20, // Maximum value on the Y-axis
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: 8,
                      color: Colors.blue,
                      width: 20,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: 10,
                      color: Colors.red,
                      width: 20,
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(
                      toY: 14,
                      color: Colors.green,
                      width: 20,
                    ),
                  ],
                ),
              ],

              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
            ),


          )
      ),

    );
  }
}