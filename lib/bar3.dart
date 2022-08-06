import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "filedisplay2",
  "private_key_id": "42a9717173fd747c016d3ed513e6cfdea55f3ebb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDKk1pD8vIQrENX\noW8SIqvV/95+gJ2bVdevJeM5nGiCJKYMX6P2y9gGNdKFr8kI4FCBTGo3u5deWTmW\nESHcZWaedXsWQosBwc6oFjs36/fjaKLoTXxFSEwwK3ywUJOgmWGV3XF/MWb3BgEn\nRbNbz4SORg08i5fXS2IS5AeIcL7ROL1cygnbLZ4za4WzMszgMKmudRHGj2CgUUTC\nLHXcecbp1IY9Fyqbv4NUtQZ5T7CZSky4Pu0c0RfNCQkhiPZK6JhVMkAffrGayhiZ\nk3q1sagFX4v/LaeX9E1X0pfrsDHVZ86R7URBGjM1yRC5FX9fodr+2MgpZgDufGB6\n8M98zWLLAgMBAAECggEAR+vxDFbhIpJGhoJGUQYGREBH2loHmvLrVL/64KVrZWll\nmtcJ+8F7vRi22cgDdCdP7dgXjhoIL/M1wtXqU7mcqX3Eaa7Oc50/peXeuIgKxq6L\nyDZafK6ifieyaVbyUv6h6vdoKGR9zg5PsoXInDwdL/YnFOvqyQF2nIZhNkvxM45z\n0XciaTjv54cRFvyd9hdoRAEe/BYRI9uOeMM+2L1AnxGmFQx/hxc4b0AMof52IB1O\n4U5vhYU5URQ2XZQn5YcAv+jlmSaTS0L9t3O0QUOIKG8Pzr029Ga/5mWay3wCt351\nSik9ByjxMk0PaTLkN8gvuXv3mCfTTgXJWsqUjx5DwQKBgQDn8ACACXcQbKbFh2S6\nesiLm2DyrvZdD7nYQIbPrXjJNot33zpMqaqk/ZPefMpZocLuZwEufCwjc/ZdRRHv\nxyZzYrsSVcYDS4zzxkP/FtSvSF4ROcka3vbjGpuQkqyilt1UrBzn2Twhqfpiahc0\njF14v2I/i71YBwRKrTqMTZlPowKBgQDfl4gN7hslVo6c5blVTc2IOwYBdfw9l2e8\njiBwOpO+8KcicvVq6SlWgGeSYKayeidO12jzynHUMjI7WslwHhweF/yvdbTY49T2\nw+RHxHL7guDpCaOvE2jWZoXV6eeLr13uNN7CxCHtKLfo0MtbvUIZynJXR83D58Pg\nGzZhLgcyuQKBgGGTG3LCCKAVRZfmHN9C1mm9JW0TZDvEaOfsRYrLLPxhgQ0eEVW9\nLzgYIgRAtZQ9tFc9aEbZIGyN1YBplWEthCSYzaCqCxLJzvOjXmnLfhB7vm86wzsV\nwAHM6NNKkWwZUeXUPpjfUCfNbbPHdBm8T3qD8V5QeIi28vxDolTyNGRHAoGAPeX2\nTVzweOq4emkCYMI0NxWX+QmPtgFXP5TdGBSvWDnJGzlWBa3cusy7X4OQQnKctS/f\nJzaRQpxO2a2tfHNpd09OrchZM34HM/VRGikhZ814tCrt/IbUDB6/yFODvWDkERDj\n5mljtwMBvtsmoRQI25j3BIClTym3STBfYpHafkkCgYB6aYvu/HwoHIrUYU4/t774\nUT1wkS+BRS3V6eFegiu6fP9gzpBDfncmkkpfmD7KBOL4/Nz+mqqQAH0mAPz1v+vz\nbbVEwpLgGO55RJ763ZfAIh+7jFcsNhUxMCKjAOuOn+UV8jHeifg1zmBm6kEjFUZ9\nbg0HP5j/aQmipA822DCA1Q==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@filedisplay2.iam.gserviceaccount.com",
  "client_id": "110177246100740062552",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40filedisplay2.iam.gserviceaccount.com"
}
''';
const _spreadsheetId = '1Hhnj4S0yARiFfqvSyGQkkETsWVjxknQldxOW2qts1V4';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final eachPatientData_array = <String, double>{};
  final data1 = <String, double>{
    'Oceania': 1600,
    'Africa': 2490,
    'S America': 2900,
    'Europe': 23050,
    'N America': 24880,
    'Asia': 34390
  };
  late List<PatientData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  String? _btn2SelectedVal;
  bool isLoading = true;
  bool initialDataEntered = false;
  String? _btn3SelectedVal;

  static const ScreenItems = <String>[
    'Main activity',
    'Carewell',
    'App closed',
    'Dashboard',
    'Education',
    'Managing care',
    'Video hub',
    'Reminders',
    'Community',
    'Troubleshooting'
  ];

  final List<DropdownMenuItem<String>> _dropDownScreenItems = ScreenItems.map(
    (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    ),
  ).toList();

  static const menuItems = <String>[
    'FT-01',
    'FT-02',
    'FT-04',
    'FT-07',
    'FT-11',
    'FT-12',
    'FT-14',
    'FT-16',
    'FT-20',
    'FT-24',
    'FT-25',
    'FT-26',
    'FT-28',
    'FT-29'
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  Future<void> _loadCSV2() async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = await ss.worksheetByTitle('Copy of all_usage_data');
    print("Gsheets initalized");

    List<String> location_data = await sheet!.values.column(5);
    List ST_data = await sheet.values.column(8);
    List ED_data = await sheet.values.column(9);
    List PID_data = await sheet.values.column(10);

    // build Unique Patient ID list.
    List<String> uniquePID = [];
    for (int i = 0; i < PID_data.length; i++) {
      String patientID = PID_data[i];
      if (uniquePID.contains(patientID)) {
        int index = uniquePID.indexOf(patientID, 0);
      } else {
        uniquePID.add(patientID);
      }
    }
    print('uniquePID: $uniquePID');

    // build a list of unique locations
    List<String> uniqueLocationList = [];
    for (int i = 0; i < location_data.length; i++) {
      String orgLocation = location_data[i];
      // print('         ******* orgLocation: $orgLocation');

      String uniqueLocation = '';
      if (orgLocation.contains('_')) {
        // print('         org location contains _');
        List<String> OrgLocSplitList = orgLocation.split('_');
        final String OrgLocationFirstValue = OrgLocSplitList[0];
        // print('         ******* OrgLocationFirstValue: $OrgLocationFirstValue');
        final String OrgLocationSecondValue = OrgLocSplitList[1];
        // print('         ******* OrgLocationSecondValue: $OrgLocationSecondValue');

        if (OrgLocationSecondValue == 'activity' ||
            OrgLocationSecondValue == 'closed') {
          uniqueLocation = orgLocation;
          // print('         org location contains https');
        } else {
          uniqueLocation = OrgLocationFirstValue;
          // print('         org location does NOT contain https');
        }
        /*
        if (OrgLocationSecondValue.contains('https')) {
          uniqueLocation = OrgLocationFirstValue;
          // print('         org location contains https');
        } else {
          uniqueLocation = orgLocation;
          // print('         org location does NOT contain https');
        }
        */
      } else {
        // print('         org location does NOT contain _');
        uniqueLocation = orgLocation;
      }

      // determine the uniqeue location.
      if (uniqueLocationList.contains(uniqueLocation)) {
        // print('Duplicate location found');
      } else {
        // print('unique location found');
        uniqueLocationList.add(uniqueLocation);
      }
    }
    print('uniqueLocationList: $uniqueLocationList');

    // for all patients, calculate the time spent on each location.
    List<Duration> timeSpentList = [];
    for (int i = 0; i < ST_data.length; i++) {
      int startTimestamp = int.parse(ST_data[i]);
      final DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(startTimestamp);
      int endTimestamp = int.parse(ED_data[i]);
      final DateTime endDate =
          DateTime.fromMillisecondsSinceEpoch(endTimestamp);
      final Duration duration = endDate.difference(startDate);
      timeSpentList.add(duration);
    }

    // for each unique patient, and for each unique location, calculate the sum of time spent.
    // List<List<dynamic>> finalPatientData = [];
    // create 2D List which contains empty rows & column to hold the final patienty data.
    int uniquePIDCount = uniquePID.length;
    int uniqueLocationCount = uniqueLocationList.length;
    int finalRowsCount = uniquePIDCount * uniqueLocationCount;

    List finalPatientData = List.generate(
        finalRowsCount, (_) => List.generate(3, (_) => ''),
        growable: true);

    int index = 0;
    for (int i = 0; i < uniquePID.length; i++) {
      String patientID = uniquePID[i];

      List<dynamic> record = [];
      for (int j = 0; j < uniqueLocationList.length; j++) {
        String uniqueLocation = uniqueLocationList[j];

        bool isPatientLocationFound = false;
        var totalTimeSpent = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int k = 0; k < location_data.length; k++) {
          final String orgLocation = location_data[k];
          final String orgPatientID = PID_data[k];
          final Duration orgTimeSpent = timeSpentList[k];

          if (orgPatientID == patientID &&
              orgLocation.contains(uniqueLocation)) {
            totalTimeSpent = totalTimeSpent + orgTimeSpent;
            isPatientLocationFound = true;
          }
        } // end of for loop for csvData

        if (isPatientLocationFound == true) {
          var totalTimeSpentString = totalTimeSpent.toString();

          finalPatientData[index][0] = patientID;
          finalPatientData[index][1] = uniqueLocation;
          finalPatientData[index][2] = totalTimeSpentString;

          index = index + 1;
        }
      } // end of for loop for uniqueLocation

    } // end of for loop for uniquePID

    // define IDs for locations.

    // var locationCodes = [];
    /*
    var locationCodes = <String, double>{};
    double locationCode = 0.00;
    for (int j = 0; j < uniqueLocation.length; j++) {
      String locationDesc = uniqueLocation[j];
      locationCode = locationCode + 1.00;
      // locationCodes.add('$locationDesc: $locationCode');
      var record = <String, double>{locationDesc: locationCode};
      locationCodes.addEntries(record.entries);
    }
    print('################ locationCodes: $locationCodes ################');
    */

    //final _data1 = <double, double>{1: 9, 2: 12, 3: 10, 4: 20, 5: 14, 6: 18};
    List eachPatientData = [];

    //print(' &&&&&&&&&&&& _btn2SelectedVal: $_btn2SelectedVal &&&&&&&&&&&&');
    print(
        ' &&&&&&&&&&&& finalPatientData.length: ${finalPatientData.length} &&&&&&&&&&&&');

    for (int i = 0; i < finalPatientData.length; i++) {
      if (finalPatientData[i][0] == _btn2SelectedVal) {
        String location = finalPatientData[i][1];
        String timeSpentStr = finalPatientData[i][2];

        // Extract the hrs, mins, sec and micro sec from the time string.
        final time = timeSpentStr.split(':');
        int hours = int.parse(time[0]);
        int minutes = int.parse(time[1]);
        String secondsStr = time[2];

        // Extract the seconds & micro seconds from Seconds string.
        final secondsTotal = secondsStr.split('.');
        int seconds_Sec = int.parse(secondsTotal[0]);
        int seconds_MicroSec = int.parse(secondsTotal[1]);

        // convert the timeSpent into milli seconds for bar grpah display purpose.
        Duration timeSpentDuration = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds_Sec,
            microseconds: seconds_MicroSec);

        // Convert the Duration into minutes.
        double timeSpent = (timeSpentDuration.inMinutes).toDouble();

        // limit the timeSpent value

        if (timeSpent > 200) {
          print('++++++++++++ timeSpent: $timeSpent ++++++++++++');
          timeSpent = 200;
        }

        // build the list for bar graph display purpose.
        eachPatientData.add('$location: $timeSpent');

        // get the location code from location description.
        /*
        double locationCode = -1.00;
        locationCodes.forEach((key, value) {
          if (key == location) {
            locationCode = value;
            Breakpoint;
          }
        });
        */

        // convert the list into an array to display bar graph purpose
        var record = <String, double>{location: timeSpent};
        eachPatientData_array.addEntries(record.entries);
      }
    } // end of FOR loop
    print(
        '----------------------------eachPatientData: $eachPatientData------------------------------------------');

    print('eachPatientData_array: $eachPatientData_array');
    print(' seleted patient is $_btn2SelectedVal');
    setState(() {
      isLoading = false;
    });
  }

/*
  @override
  Future<void> _loadCSV3() async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = await ss.worksheetByTitle('Copy of all_usage_data');
    print("Gsheets initalized");

    List<String> location_data = await sheet!.values.column(5);
    List ST_data = await sheet.values.column(8);
    List ED_data = await sheet.values.column(9);
    List PID_data = await sheet.values.column(10);

    // build Unique Patient ID list.
    List<String> uniquePID = [];
    for (int i = 0; i < PID_data.length; i++) {
      String patientID = PID_data[i];
      if (uniquePID.contains(patientID)) {
        int index = uniquePID.indexOf(patientID, 0);
      } else {
        uniquePID.add(patientID);
      }
    }
    // print(uniquePID);

    // build Unique Locastion ID list.
    List<String> uniqueLocation = [];
    for (int i = 0; i < location_data.length; i++) {
      String location1 = location_data[i];
      if (uniqueLocation.contains(location1)) {
        int index = uniqueLocation.indexOf(location1, 0);
      } else {
        uniqueLocation.add(location1);
      }
    }
    // print(uniqueLocation);

    // for all patients, calculate the time spent on each location.
    List<Duration> timeSpentList = [];
    for (int i = 0; i < ST_data.length; i++) {
      int startTimestamp = int.parse(ST_data[i]);
      final DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(startTimestamp);
      int endTimestamp = int.parse(ED_data[i]);
      final DateTime endDate =
          DateTime.fromMillisecondsSinceEpoch(endTimestamp);
      final Duration duration = endDate.difference(startDate);
      timeSpentList.add(duration);
    }

    // build a list for each patient and location and time spent
    int uniquePIDCount = uniquePID.length;
    int uniqueLocationCount = uniqueLocation.length;
    int finalRowsCount = uniquePIDCount * uniqueLocationCount;
    List finalPatientData = List.generate(
        finalRowsCount, (_) => List.generate(3, (_) => ''),
        growable: true);

    int index = 0;
    for (int i = 0; i < uniquePID.length; i++) {
      String patientID = uniquePID[i];

      List<dynamic> record = [];
      for (int j = 0; j < uniqueLocation.length; j++) {
        String locationID = uniqueLocation[j];

        bool isPatientLocationFound = false;
        var totalTimeSpent = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int k = 1; k < location_data.length; k++) {
          final String orgLocation = location_data[k];
          final String orgPatientID = PID_data[k];
          final Duration orgTimeSpent = timeSpentList[k];

          if (orgPatientID == patientID && orgLocation == locationID) {
            totalTimeSpent = totalTimeSpent + orgTimeSpent;
            isPatientLocationFound = true;
          }
        } // end of for loop for csvData

        if (isPatientLocationFound == true) {
          var totalTimeSpentString = totalTimeSpent.toString();

          finalPatientData[index][0] = patientID;
          finalPatientData[index][1] = locationID;
          finalPatientData[index][2] = totalTimeSpentString;

          index = index + 1;
        }
      } // end of for loop for uniqueLocation

    } // end of for loop for uniquePID

    // define IDs for locations.
    var locationCodes = <String, double>{};
    double locationCode = 0.00;
    for (int j = 0; j < uniqueLocation.length; j++) {
      String locationDesc = uniqueLocation[j];
      locationCode = locationCode + 1.00;
      // locationCodes.add('$locationDesc: $locationCode');
      var record = <String, double>{locationDesc: locationCode};
      locationCodes.addEntries(record.entries);
    }
    // print('################ locationCodes: $locationCodes ################');

    List eachPatientData = [];

    // print(' &&&&&&&&&&&& _btn2SelectedVal: $_btn2SelectedVal &&&&&&&&&&&&');
    // print(' &&&&&&&&&&&& finalPatientData.length: $finalPatientData.length &&&&&&&&&&&&');

    for (int i = 0; i < finalPatientData.length; i++) {
      if (finalPatientData[i][0] == _btn2SelectedVal) {
        String location = finalPatientData[i][1];
        String timeSpentStr = finalPatientData[i][2];

        // Extract the hrs, mins, sec and micro sec from the time string.
        final time = timeSpentStr.split(':');
        int hours = int.parse(time[0]);
        int minutes = int.parse(time[1]);
        String secondsStr = time[2];

        // Extract the seconds & micro seconds from Seconds string.
        final secondsTotal = secondsStr.split('.');
        int seconds_Sec = int.parse(secondsTotal[0]);
        int seconds_MicroSec = int.parse(secondsTotal[1]);

        // convert the timeSpent into milli seconds for bar grpah display purpose.
        Duration timeSpentDuration = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds_Sec,
            microseconds: seconds_MicroSec);

        // Convert the Duration into minutes.
        double timeSpent = (timeSpentDuration.inMinutes).toDouble();

        // limit the timeSpent value
        if (timeSpent > 50) {
          // print('++++++++++++ timeSpent: $timeSpent ++++++++++++');
          timeSpent = 50;
        }

        // build the list for bar graph display purpose.
        eachPatientData.add('$location: $timeSpent');

        // get the location code from location description.
        double locationCode = -1.00;
        locationCodes.forEach((key, value) {
          if (key == location) {
            locationCode = value;
            Breakpoint;
          }
        });

        // convert the list into an array to display bar graph purpose
        var record = <double, double>{locationCode: timeSpent};
        eachPatientData_array.addEntries(record.entries);
      }
    } // end of FOR loop
    // print('----------------------------eachPatientData: $eachPatientData------------------------------------------');
    // print('eachPatientData_array: $eachPatientData_array');
    // print(' seleted patient is $_btn2SelectedVal');

    // build a new array patient + location + time spent on that location
    // The array DateAndTimespent_array format should be: <Date (string) : Timespent (double)>
    String userSelectedPatientID = '';
    String userSelectedLocationID = '';

    int index1 = 0;
    for (int i = 0; i < uniquePID.length; i++) {
      String patientID = uniquePID[i];

      List<dynamic> record = [];
      for (int j = 0; j < uniqueLocation.length; j++) {
        String locationID = uniqueLocation[j];

        bool isPatientLocationFound = false;
        var totalTimeSpent = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int k = 1; k < location_data.length; k++) {
          final String orgLocation = location_data[k];
          final String orgPatientID = PID_data[k];
          final String orgTimeSpent = timeSpentList[k];

          String timeSpentStr = finalPatientData[i][2];

          // Extract the hrs, mins, sec and micro sec from the time string.
          final time = timeSpentStr.split(':');
          int hours = int.parse(time[0]);
          int minutes = int.parse(time[1]);
          String secondsStr = time[2];

          // Extract the seconds & micro seconds from Seconds string.
          final secondsTotal = secondsStr.split('.');
          int seconds_Sec = int.parse(secondsTotal[0]);
          int seconds_MicroSec = int.parse(secondsTotal[1]);

          // convert the timeSpent into milli seconds for bar grpah display purpose.
          Duration timeSpentDuration = Duration(
              hours: hours,
              minutes: minutes,
              seconds: seconds_Sec,
              microseconds: seconds_MicroSec);

          // Convert the Duration into minutes.
          double timeSpent = (timeSpentDuration.inMinutes).toDouble();

          if (orgPatientID == userSelectedPatientID &&
              orgLocation == userSelectedLocationID) {
            totalTimeSpent = totalTimeSpent + orgTimeSpent;
            isPatientLocationFound = true;
          }
        } // end of for loop for csvData

        if (isPatientLocationFound == true) {
          var totalTimeSpentString = totalTimeSpent.toString();

          finalPatientData[index1][0] = patientID;
          finalPatientData[index1][1] = locationID;
          finalPatientData[index1][2] = totalTimeSpentString;

          // convert the list into an array to display bar graph purpose
          var record = <double, double>{locationCode: timeSpent};
          DateAndTimespent_array.addEntries(record.entries);

          index = index + 1;
        }
      } // end of for loop for uniqueLocation

    } // end of for loop for uniquePID

    setState(() {
      isLoading = false;
    });
  } // enf of _loadCSV3()
*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Summary"),
      ),
      body: _createBody(context),
      bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _createBody(BuildContext context) {
    if (isLoading == false) {
      List<PatientData> getChartData() {
        print('finally eachPatientData_array: $eachPatientData_array');
        final List<PatientData> chartData = [
          for (var entry in eachPatientData_array.entries)
            PatientData(entry.key, entry.value),
        ];
        return chartData;
      }

      setState(() {
        _chartData = getChartData();
        _tooltipBehavior = TooltipBehavior(enable: true);
      });

      return Padding(
        padding: const EdgeInsets.all(8),
        child: SfCartesianChart(
          legend: Legend(isVisible: true),
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            BarSeries<PatientData, String>(
                name: 'Patient Data',
                dataSource: _chartData,
                xValueMapper: (PatientData gdp, _) => gdp.Screens,
                yValueMapper: (PatientData gdp, _) => gdp.time,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                enableTooltip: true)
          ],
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              numberFormat: NumberFormat.compact(),
              title: AxisTitle(text: 'Time spent on each screen(in Minutes)')),
        ),
      );
    } else {
      return const SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      color: Color.fromARGB(255, 203, 188, 188),
      child: ListView(
        children: [
          ListTile(
            title: const Text('Choose the desired patient:'),
            trailing: DropdownButton(
              value: _btn2SelectedVal,
              hint: const Text('Choose'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _btn2SelectedVal = newValue);
                }
              },
              items: _dropDownMenuItems,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _loadCSV2();
            },
            child: Text("load CSv data"),
          ),
          if (isLoading == false) ...[
            ListTile(
              title: const Text('Choose the desired screen:'),
              trailing: DropdownButton(
                value: _btn3SelectedVal,
                hint: const Text('Choose'),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _btn3SelectedVal = newValue);
                  }
                },
                items: _dropDownScreenItems,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _loadCSV2();
              },
              child: Text("load screen data"),
            ),
          ] else ...[
            DropdownButton(
              disabledHint: Text(""),
              style: TextStyle(color: Colors.red, fontSize: 30),
              onChanged: null,
              value: null,
              items: _dropDownScreenItems,
            )
          ]
        ],
      ),
    );
  }
}

class PatientData {
  PatientData(this.Screens, this.time);
  final String Screens;
  final double time;
}
