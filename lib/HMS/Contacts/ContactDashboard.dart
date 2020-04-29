import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horse_management/Network_Operations.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ContactDashboard extends StatefulWidget {
  var token, contactData;

  ContactDashboard(this.token, this.contactData);

  @override
  _ContactDashboardState createState() =>
      _ContactDashboardState(token, contactData);
}

class _ContactDashboardState extends State<ContactDashboard> {
  var vetchartvisible = false,
      trainerChartVisible = false,
      breederChartVisible = false,
      ferrier = false,
      token,
      dashboardData,
      contactData;

  _ContactDashboardState(this.token, this.contactData);

  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue
  ];
  Map<String, double> vetVisits,
      training,
      breedingControl,
      breedingSales,
      conformation,
      flushes,
      semenCollection,
      vaccination,
      farrier;
  @override
  void initState() {
    vetVisits = Map();
    training = Map();
    breedingControl = Map();
    breedingSales = Map();
    conformation = Map();
    semenCollection = Map();
    flushes = Map();
    farrier = Map();
    vaccination = Map();
    ProgressDialog pd = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true);
    pd.show();
    network_operations.GetContactDashBoard(token, contactData['contactId'])
        .then((response) {
      pd.dismiss();
      if (response != null) {
        setState(() {
          dashboardData = jsonDecode(response);
          //Vet Visits
          vetVisits.putIfAbsent(
              "Started",
              () => dashboardData['vetVisitsStarted'] != null
                  ? double.parse(dashboardData['vetVisitsStarted'].toString())
                  : 0);
          vetVisits.putIfAbsent(
              "Not Started",
              () => dashboardData['vetVisitsNotStarted'] != null
                  ? double.parse(
                      dashboardData['vetVisitsNotStarted'].toString())
                  : 0);
          vetVisits.putIfAbsent(
              "Completed",
              () => dashboardData['vetVisitsCompleted'] != null
                  ? double.parse(dashboardData['vetVisitsCompleted'].toString())
                  : 0);
          vetVisits.putIfAbsent(
              "Late Completed",
              () => dashboardData['vetVisitsLateCompleted'] != null
                  ? double.parse(
                      dashboardData['vetVisitsLateCompleted'].toString())
                  : 0);
          //Training
          training.putIfAbsent(
              "Started",
              () => dashboardData['trainingStarted'] != null
                  ? double.parse(dashboardData['trainingStarted'].toString())
                  : 0);
          training.putIfAbsent(
              "Not Started",
              () => dashboardData['trainingNotStarted'] != null
                  ? double.parse(dashboardData['trainingNotStarted'].toString())
                  : 0);
          training.putIfAbsent(
              "Completed",
              () => dashboardData['trainingCompleted'] != null
                  ? double.parse(dashboardData['trainingCompleted'].toString())
                  : 0);
          training.putIfAbsent(
              "Late Completed",
              () => dashboardData['trainingLateCompleted'] != null
                  ? double.parse(
                      dashboardData['trainingLateCompleted'].toString())
                  : 0);
          //Breeding Control
          breedingControl.putIfAbsent(
              "Started",
              () => dashboardData['breedingControlStarted'] != null
                  ? double.parse(
                      dashboardData['breedingControlStarted'].toString())
                  : 0);
          breedingControl.putIfAbsent(
              "Not Started",
              () => dashboardData['breedingControlNotStarted'] != null
                  ? double.parse(
                      dashboardData['breedingControlNotStarted'].toString())
                  : 0);
          breedingControl.putIfAbsent(
              "Completed",
              () => dashboardData['breedingControlCompleted'] != null
                  ? double.parse(
                      dashboardData['breedingControlCompleted'].toString())
                  : 0);
          breedingControl.putIfAbsent(
              "Late Completed",
              () => dashboardData['breedingControlLateCompleted'] != null
                  ? double.parse(
                      dashboardData['breedingControlLateCompleted'].toString())
                  : 0);
          //Breeding Sales
          breedingSales.putIfAbsent(
              "Started",
              () => dashboardData['breedingSalesStarted'] != null
                  ? double.parse(
                      dashboardData['breedingSalesStarted'].toString())
                  : 0);
          breedingSales.putIfAbsent(
              "Not Started",
              () => dashboardData['breedingSalesNotStarted'] != null
                  ? double.parse(
                      dashboardData['breedingSalesNotStarted'].toString())
                  : 0);
          breedingSales.putIfAbsent(
              "Completed",
              () => dashboardData['breedingSalesCompleted'] != null
                  ? double.parse(
                      dashboardData['breedingSalesCompleted'].toString())
                  : 0);
          breedingSales.putIfAbsent(
              "Late Completed",
              () => dashboardData['breedingSalesLateCompleted'] != null
                  ? double.parse(
                      dashboardData['breedingSalesLateCompleted'].toString())
                  : 0);
          //Conformation
          conformation.putIfAbsent(
              "Started",
              () => dashboardData['conformationStarted'] != null
                  ? double.parse(
                      dashboardData['conformationStarted'].toString())
                  : 0);
          conformation.putIfAbsent(
              "Not Started",
              () => dashboardData['conformationNotStarted'] != null
                  ? double.parse(
                      dashboardData['conformationNotStarted'].toString())
                  : 0);
          conformation.putIfAbsent(
              "Completed",
              () => dashboardData['conformationCompleted'] != null
                  ? double.parse(
                      dashboardData['conformationCompleted'].toString())
                  : 0);
          conformation.putIfAbsent(
              "Late Completed",
              () => dashboardData['conformationLateCompleted'] != null
                  ? double.parse(
                      dashboardData['conformationLateCompleted'].toString())
                  : 0);
          //Flushes
          flushes.putIfAbsent(
              "Started",
              () => dashboardData['flushesStarted'] != null
                  ? double.parse(dashboardData['flushesStarted'].toString())
                  : 0);
          flushes.putIfAbsent(
              "Not Started",
              () => dashboardData['flushesNotStarted'] != null
                  ? double.parse(dashboardData['flushesNotStarted'].toString())
                  : 0);
          flushes.putIfAbsent(
              "Completed",
              () => dashboardData['flushesCompleted'] != null
                  ? double.parse(dashboardData['flushesCompleted'].toString())
                  : 0);
          flushes.putIfAbsent(
              "Late Completed",
              () => dashboardData['flushesLateCompleted'] != null
                  ? double.parse(
                      dashboardData['flushesLateCompleted'].toString())
                  : 0);
          //Semen Collection
          semenCollection.putIfAbsent(
              "Started",
              () => dashboardData['semenCollectionStarted'] != null
                  ? double.parse(
                      dashboardData['semenCollectionStarted'].toString())
                  : 0);
          semenCollection.putIfAbsent(
              "Not Started",
              () => dashboardData['semenCollectionNotStarted'] != null
                  ? double.parse(
                      dashboardData['semenCollectionNotStarted'].toString())
                  : 0);
          semenCollection.putIfAbsent(
              "Completed",
              () => dashboardData['semenCollectionCompleted'] != null
                  ? double.parse(
                      dashboardData['semenCollectionCompleted'].toString())
                  : 0);
          semenCollection.putIfAbsent(
              "Late Completed",
              () => dashboardData['semenCollectionLateCompleted'] != null
                  ? double.parse(
                      dashboardData['semenCollectionLateCompleted'].toString())
                  : 0);
          //Vaccination
          vaccination.putIfAbsent(
              "Started",
              () => dashboardData['vaccinationsStarted'] != null
                  ? double.parse(
                      dashboardData['vaccinationsStarted'].toString())
                  : 0);
          vaccination.putIfAbsent(
              "Not Started",
              () => dashboardData['vaccinationsNotStarted'] != null
                  ? double.parse(
                      dashboardData['vaccinationsNotStarted'].toString())
                  : 0);
          vaccination.putIfAbsent(
              "Completed",
              () => dashboardData['vaccinationsCompleted'] != null
                  ? double.parse(
                      dashboardData['vaccinationsCompleted'].toString())
                  : 0);
          vaccination.putIfAbsent(
              "Late Completed",
              () => dashboardData['vaccinationsLateCompleted'] != null
                  ? double.parse(
                      dashboardData['vaccinationsLateCompleted'].toString())
                  : 0);
          //Farrier
          farrier.putIfAbsent(
              "Started",
              () => dashboardData['farrierStarted'] != null
                  ? double.parse(dashboardData['farrierStarted'].toString())
                  : 0);
          farrier.putIfAbsent(
              "Not Started",
              () => dashboardData['farrierNotStarted'] != null
                  ? double.parse(dashboardData['farrierNotStarted'].toString())
                  : 0);
          farrier.putIfAbsent(
              "Completed",
              () => dashboardData['farrierCompleted'] != null
                  ? double.parse(dashboardData['farrierCompleted'].toString())
                  : 0);
          farrier.putIfAbsent(
              "Late Completed",
              () => dashboardData['farrierLateCompleted'] != null
                  ? double.parse(
                      dashboardData['farrierLateCompleted'].toString())
                  : 0);
          print(contactData['allRoles'].toString());
          if (contactData['allRoles'].contains('Vet')) {
            setState(() {
              vetchartvisible = true;
            });
          }
          if (contactData['allRoles'].contains('Trainer')) {
            setState(() {
              trainerChartVisible = true;
            });
          }
          if (contactData['allRoles'].contains('Breeder')) {
            setState(() {
              breederChartVisible = true;
            });
          }
          if (contactData['allRoles'].contains('Farrier')) {
            setState(() {
              ferrier = true;
            });
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Dashboard"),
      ),
      body: ListView(
        children: <Widget>[
          Visibility(
            visible: vetchartvisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Vet Visits',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: vetVisits,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: vetchartvisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Conformation',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: conformation,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: vetchartvisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Vaccination',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: vaccination,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: trainerChartVisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Trainings',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: training,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: breederChartVisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Breeding Control',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: breedingControl,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: breederChartVisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Breeding Sales',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: breedingSales,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: breederChartVisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Semen Collection',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: semenCollection,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: breederChartVisible,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Flushes',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: flushes,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: ferrier,
            child: Card(
              elevation: 30,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Farrier',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  PieChart(
                    dataMap: farrier,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    showChartValuesOutside: false,
                    chartValueBackgroundColor: Colors.grey[200],
                    colorList: colorList,
                    showLegends: true,
                    legendPosition: LegendPosition.right,
                    decimalPlaces: 1,
                    showChartValueLabel: true,
                    initialAngle: 0,
                    chartValueStyle: defaultChartValueStyle.copyWith(
                      color: Colors.blueGrey[900].withOpacity(0.9),
                    ),
                    chartType: ChartType.disc,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
