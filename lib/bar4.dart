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

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  var eachPatientData_array = <String, double>{};
  var eachPatientData_array1 = <String, double>{};

  late List<PatientData> _chartData;
  late List<PatientData1> _chartData1;
  late TooltipBehavior _tooltipBehavior;
  String? _btn2SelectedVal;
  bool isLoading = true;
  bool initialDataEntered = false;
  String? _btn3SelectedVal;

  static const ScreenItems = <String>[
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
  Future<void> _loadCSV() async {
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

        // do not add the following list of locations to the unite locations list.
        /*
        1. application_closed
        2. main_activity
        3. CareWell
        4. Media Player
        */
        if (uniqueLocation.contains('application_closed') ||
            uniqueLocation.contains('main_activity') ||
            uniqueLocation.contains('CareWell') ||
            uniqueLocation.contains('Media Player')) {
          print('location is one of the 4 values');
        } else {
          uniqueLocationList.add(uniqueLocation);
        }
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

        // build the list for bar graph display purpose.
        eachPatientData.add('$location:$timeSpent');

        // convert the list into an array to display bar graph purpose
        /*
        var record = <String, double>{location: timeSpent};
        eachPatientData_array.addEntries(record.entries);
        */
      }
    } // end of FOR loop
    print(
        '----------------------------eachPatientData - before sorting: $eachPatientData------------------------------------------');

    // sort eachPatientData list as per timespent in ascending order for display purpose.
    List<double> finalTimeSpentList = [];
    for (int k = 0; k < eachPatientData.length; k++) {
      String record = eachPatientData[k];
      print('record: $record');

      List<String> locationTimespentList = record.split(':');
      final String location = locationTimespentList[0];
      print('         ******* location: $location');
      final String timeSpent = locationTimespentList[1];
      print('         ******* timeSpent: $timeSpent');
      double timeSpentDouble = double.parse(timeSpent);
      print('         ******* timeSpentDouble: $timeSpentDouble');
      finalTimeSpentList.add(timeSpentDouble);
    } // end of FOR loop

    List finalEachPatientData = [];
    for (int i = 0; i < finalTimeSpentList.length; i++) {
      double finalTimeSpent = finalTimeSpentList[i];
      for (int k = 0; k < eachPatientData.length; k++) {
        String record = eachPatientData[k];
        List<String> locationTimespentList = record.split(':');
        final String location = locationTimespentList[0];
        // print('         ******* location: $location');
        final String timeSpent = locationTimespentList[1];
        // print('         ******* timeSpent: $timeSpent');
        double timeSpentDouble = double.parse(timeSpent);
        // print('         ******* timeSpentDouble: $timeSpentDouble');

        if (timeSpentDouble == finalTimeSpent) {
          var record = <String, double>{location: timeSpentDouble};
          eachPatientData_array.addEntries(record.entries);
        }
      }
    }

    print(
        '----------------------------eachPatientData - after sorting: $eachPatientData_array------------------------------------------');

    //print('eachPatientData_array: $eachPatientData_array');
    print(' seleted patient is $_btn2SelectedVal');
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadCSV2() async {
    setState(() {
      isLoading = true;
    });

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

        // do not add the following list of locations to the unite locations list.
        /*
        1. application_closed
        2. main_activity
        3. CareWell
        4. Media Player
        */
        if (uniqueLocation.contains('application_closed') ||
            uniqueLocation.contains('main_activity') ||
            uniqueLocation.contains('CareWell') ||
            uniqueLocation.contains('Media Player')) {
          print('location is one of the 4 values');
        } else {
          uniqueLocationList.add(uniqueLocation);
        }
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

    List eachPatientData = [];
    List<double> finalTimeSpentList = [];
    List finalEachPatientData = [];

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

        // build the list for bar graph display purpose.
        eachPatientData.add('$location:$timeSpent');
      }
    } // end of FOR loop
    print(
        '----------------------------eachPatientData: $eachPatientData------------------------------------------');

    // sort eachPatientData list as per timespent in ascending order for display purpose.

    for (int k = 0; k < eachPatientData.length; k++) {
      String record = eachPatientData[k];
      print('record: $record');

      List<String> locationTimespentList = record.split(':');
      final String location = locationTimespentList[0];
      print('         ******* location: $location');
      final String timeSpent = locationTimespentList[1];
      print('         ******* timeSpent: $timeSpent');
      double timeSpentDouble = double.parse(timeSpent);
      print('         ******* timeSpentDouble: $timeSpentDouble');
      finalTimeSpentList.add(timeSpentDouble);
    } // end of FOR loop

    // print('finalTimeSpentList - before sorting: $finalTimeSpentList');
    finalTimeSpentList.sort();
    // print('finalTimeSpentList - after sorting: $finalTimeSpentList');

    // empty the list: eachPatientData_array
    // print('eachPatientData_array before clearing: $eachPatientData_array');
    eachPatientData_array.clear();
    // print('eachPatientData_array after clearing: $eachPatientData_array');

    for (int i = 0; i < finalTimeSpentList.length; i++) {
      double finalTimeSpent = finalTimeSpentList[i];
      // print('-------------------- finalTimeSpent: $finalTimeSpent ---------------------');
      for (int k = 0; k < eachPatientData.length; k++) {
        String record = eachPatientData[k];
        List<String> locationTimespentList = record.split(':');
        final String location = locationTimespentList[0];
        // print('         ******* location: $location *******');
        final String timeSpent = locationTimespentList[1];
        // print('         timeSpent: $timeSpent');
        double timeSpentDouble = double.parse(timeSpent);
        // print('         timeSpentDouble: $timeSpentDouble');

        if (timeSpentDouble == finalTimeSpent) {
          // print('         +++++ MATCH ++++');
          var record = <String, double>{location: timeSpentDouble};
          eachPatientData_array.addEntries(record.entries);
        }
        // print('         eachPatientData_array: $eachPatientData_array');
      }
    }

    print(
        '----------------------------eachPatientData_array: $eachPatientData_array------------------------------------------');

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadCSV3() async {
    setState(() {
      isLoading = true;
    });

    String patientIDSelected = _btn2SelectedVal.toString();
    print('patientIDSelected: $patientIDSelected');

    String locationIDSelected = _btn3SelectedVal.toString();
    print('locationIDSelected: $locationIDSelected');

    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = await ss.worksheetByTitle('Copy of all_usage_data');
    print("Gsheets initalized in _loadCSV3() function");

    List<String> location_data = await sheet!.values.column(5);
    List ST_data = await sheet.values.column(8);
    List ED_data = await sheet.values.column(9);
    List PID_data = await sheet.values.column(10);

    // clear the contents of the array: eachPatientData_array
    eachPatientData_array1.clear();

    // for a given patient id & location id, calculate the time spent for every occurance in the original excel sheet.
    for (int i = 0; i < location_data.length; i++) {
      print('********* i: $i ************');

      String orgPateintId = PID_data[i];
      String orgLocationId = location_data[i];
      String orgStartTime = ST_data[i];
      String orgEndTime = ED_data[i];

      print('orgPateintId: $orgPateintId');
      print('orgLocationId: $orgLocationId');
      print('orgStartTime: $orgStartTime');
      print('orgEndTime: $orgEndTime');

      int startTimestamp = int.parse(orgStartTime);
      final DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(startTimestamp);
      int endTimestamp = int.parse(orgEndTime);
      final DateTime endDate =
          DateTime.fromMillisecondsSinceEpoch(endTimestamp);
      final Duration timeSpent = endDate.difference(startDate);
      int timeSpentInMins = timeSpent.inMinutes;
      double timeSpentInMins_double = timeSpentInMins.toDouble();

      if (timeSpentInMins_double != 0) {
        if (orgPateintId == patientIDSelected &&
            orgLocationId.contains(locationIDSelected)) {
          print('both PateintId & LocationId matches');
          var record = <String, double>{
            startDate.toString(): timeSpentInMins_double
          };
          eachPatientData_array1.addEntries(record.entries);
        } /* else {
          print('both PateintId & LocationId does NOT matches');
        } */
      }
    } // end of FOR loop
    print(
        '----------------------------eachPatientData_array in _loadCSV3() : $eachPatientData_array1------------------------------------------');
    setState(() {
      isLoading = false;
    });
  } // end of _loadCSV3()

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carewell Clinical Dashboard"),
        centerTitle: true,
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

      List<PatientData1> getChartData1() {
        print('finally eachPatientData_array: $eachPatientData_array1');
        final List<PatientData1> chartData1 = [
          for (var entry in eachPatientData_array1.entries)
            PatientData1(entry.key, entry.value),
        ];
        return chartData1;
      }

      setState(() {
        _chartData = getChartData();
        _chartData1 = getChartData1();
        _tooltipBehavior = TooltipBehavior(enable: true);
      });

      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SfCartesianChart(
              legend: Legend(isVisible: false),
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
                  title: AxisTitle(text: 'Time spent(in Minutes)')),
            ),
          ),
          Expanded(
            child: SfCartesianChart(
              legend: Legend(isVisible: false),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                BarSeries<PatientData1, String>(
                    name: 'Patient Data',
                    dataSource: _chartData1,
                    xValueMapper: (PatientData1 gdp, _) => gdp.Screens,
                    yValueMapper: (PatientData1 gdp, _) => gdp.time,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  numberFormat: NumberFormat.compact(),
                  title: AxisTitle(text: 'Time spent(in Minutes)')),
            ),
          ),
        ],
      );

/*
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
              title: AxisTitle(text: 'Time spent(in Minutes)')),
        ),
      );
         SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )

                      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          Text("Choose Patient ID")
        ],
      );


*/

    } else {
      return const SizedBox(
        height: 2000,
        width: 2000,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 220,
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
              _loadCSV();
            },
            child: Text("Load Patient Data"),
          ),
          Divider(),
          if (isLoading == false) ...[
            ElevatedButton(
              onPressed: () {
                _loadCSV2();
              },
              child: Text("Load Patient Data in an order"),
            ),
            Divider(),
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
                _loadCSV3();
              },
              child: Text("Load Screen Data"),
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

class PatientData1 {
  PatientData1(this.Screens, this.time);
  final String Screens;
  final double time;
}
