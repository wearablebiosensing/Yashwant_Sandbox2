// ignore_for_file: override_on_non_overriding_member, unused_field, non_constant_identifier_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:intl/intl.dart';
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

//final eachPatientData = [CareWell: 0, application_closed: 4, Dashboard: 1, Education: 0, Education_https:sites.google.com/view/carewell/home: 0, Education_https:sites.google.com/view/carewell/caregiving: 0, Managing Care: 0];
/*final eachPatientData_array = <String, int>{
  'CareWell': 0,
  'application_closed': 4,
  'Dashboard': 1,
  'Education': 0,
  'Education_https:sites.google.com/view/carewell/home': 0,
  'Education_https:sites.google.com/view/carewell/caregiving: 0, Managing Care':
      0
};
*/
const _spreadsheetId = '1Hhnj4S0yARiFfqvSyGQkkETsWVjxknQldxOW2qts1V4';

class FlBarChartExample extends StatefulWidget {
  const FlBarChartExample({Key? key}) : super(key: key);

  @override
  _FlBarChartExampleState createState() => _FlBarChartExampleState();
}

class _FlBarChartExampleState extends State<FlBarChartExample> {
  var data5;

  ///final data5 = <double, double>{};
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) {
          data5 = _loadCSV2();
        }
      },
    );
  }

  @override
  final _data1 = <double, double>{1: 9, 2: 12, 3: 10, 4: 20, 5: 14, 6: 18};
  final data3 = <double, double>{
    1: 0,
    2: 0,
    3: 4,
    4: 1,
    5: 0,
    6: 0,
    7: 0,
    8: 0
  };
  final eachPatientData_array = <double, double>{};

  @override
  Future<Map<double, double>> _loadCSV2() async {
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
    print(uniquePID);
    List<String> uniqueLocation = [];
    for (int i = 0; i < location_data.length; i++) {
      String location1 = location_data[i];
      if (uniqueLocation.contains(location1)) {
        int index = uniqueLocation.indexOf(location1, 0);
      } else {
        uniqueLocation.add(location1);
      }
    }
    print(uniqueLocation);

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

        var totalTimeSpent = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int k = 1; k < location_data.length; k++) {
          final String orgLocation = location_data[k];
          final String orgPatientID = PID_data[k];
          final Duration orgTimeSpent = timeSpentList[k];

          if (orgPatientID == patientID && orgLocation == locationID) {
            totalTimeSpent = totalTimeSpent + orgTimeSpent;
          }
        } // end of for loop for csvData

        var totalTimeSpentString = totalTimeSpent.toString();

        finalPatientData[index][0] = patientID;
        finalPatientData[index][1] = locationID;
        finalPatientData[index][2] = totalTimeSpentString;

        index = index + 1;
      } // end of for loop for uniqueLocation

    } // end of for loop for uniquePID

    // define IDs for locations.
    var locationCodes = <String, double>{
      'main_activity': 1.00,
      'CareWell': 2.00,
      'application_closed': 3.00,
      'Dashboard': 4.00,
      'Education': 5.00,
      'Education_https://sites.google.com/view/carewell/home': 6.00,
      'Education_https://sites.google.com/view/carewell/caregiving': 7.00,
      'Managing Care': 8.00,
      'Managing Care_https://sites.google.com/view/managingcare-cw/home': 9.00,
      'Video Hub': 10.00,
      'Reminders': 11.00,
      'Community': 12.00,
    };

    //final _data1 = <double, double>{1: 9, 2: 12, 3: 10, 4: 20, 5: 14, 6: 18};
    List eachPatientData = [];

    for (int i = 0; i < finalPatientData.length; i++) {
      if (finalPatientData[i][0] == 'FT-01') {
        String location = finalPatientData[i][1];
        String timeSpentStr = finalPatientData[i][2];

        // Extract the hrs, mins, sec and micro sec from the time string.
        final time = timeSpentStr.split(':');
        int hours = int.parse(time[0]);
        int minutes = int.parse(time[1]);
        String secondsStr = time[2];

        // Extract the secoinds & micro seconds from Seconds string.
        final secondsTotal = secondsStr.split('.');
        int seconds_Sec = int.parse(secondsTotal[0]);
        int seconds_MicroSec = int.parse(secondsTotal[1]);

        // convert the timeSpent into milli seconds for bar grpah display purpose.
        Duration timeSpentDuration = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds_Sec,
            microseconds: seconds_MicroSec);

        // Convert the Duration into milli seconds.
        double timeSpent = (timeSpentDuration.inMinutes).toDouble();

        // build the list for bar graph display purpose.
        eachPatientData.add('$location: $timeSpent');
        print(
            '----------------------------eachPatientData: $eachPatientData------------------------------------------');

        // get the location code from location description.
        double locationCode = -1.00;
        locationCodes.forEach((key, value) {
          if (key == location) {
            locationCode = value;
            Breakpoint;
          } else {}
        });

        // convert the list into an array to display bar graph purpose
        var record = <double, double>{locationCode: timeSpent};
        eachPatientData_array.addEntries(record.entries);
        print('eachPatientData_array: $eachPatientData_array');
      }
    } // end of FOR loop

    return eachPatientData_array;
  }

  Future<Map<double, double>> callAsyncFetch() =>
      Future<Map<double, double>>.delayed(
        const Duration(seconds: 5),
        () => data5,
      );

  bool _showBorder = false;
  bool _showGrid = false;

  @override
  Widget build(BuildContext context) {
    print("Widget build");
    print(data5);
    final barGroups = <BarChartGroupData>[
      for (var entry in data3.entries)
        BarChartGroupData(
          x: entry.key.toInt(),
          barRods: [
            BarChartRodData(toY: entry.value, color: Colors.blue),
          ],
        ),
    ];

    final barChartData = BarChartData(
      maxY: 25,
      barGroups: barGroups,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
        ),
      ),
      borderData: FlBorderData(show: _showBorder),
      gridData: FlGridData(show: _showGrid),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Screens'),
          sideTitles: SideTitles(
            showTitles: true,
            /*getTitlesWidget: (double val, _) =>
                Text(DateFormat.MMM().format(DateTime(2020, val.toInt()))),*/
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text('Time Spent'),
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double val, _) {
              if (val.toInt() % 1 != 0) return Text('');
              return Text('${val.toInt()}');
            },
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Graph"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<Map>(
          future: callAsyncFetch(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: BarChart(barChartData),
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting data...'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      color: Color.fromARGB(255, 203, 188, 188),
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('ShowBorder'),
            onChanged: (bool val) => setState(() => this._showBorder = val),
            value: this._showBorder,
          ),
          SwitchListTile(
            title: const Text('ShowGrid'),
            onChanged: (bool val) => setState(() => this._showGrid = val),
            value: this._showGrid,
          ),
          ElevatedButton(
            onPressed: () {
              _loadCSV2();
            },
            child: Text("load data"),
          ),
        ],
      ),
    );
  }
}
