// ignore_for_file: unused_local_variable, dead_code, override_on_non_overriding_member, avoid_print, non_constant_identifier_names, unused_element

// import 'dart:ffi';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/androidpublisher/v3.dart';
import 'package:googleapis/clouddebugger/v2.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis/containeranalysis/v1.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/drive/v2.dart' as drive2;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:http/io_client.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:csv/csv.dart' as csv1;
import 'package:faker/faker.dart' as faker;
import 'package:timezone/standalone.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/browser.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/src/date_time.dart';
import 'package:timezone/timezone.dart';
import 'package:kt_dart/kt.dart';
import 'bar.dart';
import 'package:gsheets/gsheets.dart';
import 'dart:convert';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAYaKSPN3A8ru15JhkPQI3JV-xPspA9yag",
        authDomain: "filedisplay2.firebaseapp.com",
        projectId: "filedisplay2",
        storageBucket: "filedisplay2.appspot.com",
        messagingSenderId: "1008627958968",
        appId: "1:1008627958968:web:754f762a89926797b1a04d"),
  );
  print("firebase Initalized");

  runApp(
    MaterialApp(
      home: GoogleDriveTest(),
    ),
  );
}

class GoogleDriveTest extends StatefulWidget {
  @override
  _GoogleDriveTest createState() => _GoogleDriveTest();
}

class _GoogleDriveTest extends State<GoogleDriveTest> {
  bool _loginStatus = false;
  final googleSignIn = GoogleSignIn.standard(scopes: [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
    drive.DriveApi.driveReadonlyScope,
  ]);

  @override
  void initState() {
    _loginStatus = googleSignIn.currentUser != null;
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _loadCSV(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Builder(builder: (BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("File Display"),
          ),
          body: _createBody(context),
        ),
      );
    }));
  }

  Widget _createBody(BuildContext context) {
    final signIn = ElevatedButton(
      onPressed: () {
        _signIn();
      },
      child: Text("Sing in"),
    );
    final signOut = ElevatedButton(
      onPressed: () {
        _signOut();
      },
      child: Text("Sing out"),
    );

    final uploadToNormal = ElevatedButton(
      onPressed: () {
        _uploadToNormal();
      },
      child: Text("Upload to internship folder"),
    );

    final displayFileContent = ElevatedButton(
      onPressed: () {
        _downloadFile();
      },
      child: Text("display file content"),
    );
    final csvViewer = ElevatedButton(
      onPressed: () {
        _loadCSV(context);
      },
      child: Text("display csv content"),
    );
    final csvViewer1 = ElevatedButton(
      onPressed: () {
        _loadCSV2();
      },
      child: Text("display  the csv content"),
    );
    final new_page = ElevatedButton(
      child: const Text('Bar Graph'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FlBarChartExample()),
        );
      },
    );

    return Column(
      children: [
        Center(child: Text("Sign in status: ${_loginStatus ? "In" : "Out"}")),
        Center(child: signIn),
        Center(child: signOut),
        Divider(),
        Center(child: uploadToNormal),
        Center(
            child: _createButton(
                "Files in internship folder", _showFilesInMyFolder)),
        // Center(child: _createButton("file content is: ", _downloadFile())),
        Center(child: displayFileContent),
        Center(child: _createButton("All file list", _allFileList)),
        Center(child: csvViewer),
        Center(child: csvViewer1),
        Center(child: new_page),
      ],
    );
  }

  Future<void> _signIn() async {
    final googleUser = await googleSignIn.signIn();

    try {
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential loginUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

        assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
        print("Sign in complete");
        setState(() {
          _loginStatus = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    setState(() {
      _loginStatus = false;
    });
    print("Sign out complete");
  }

  Future<drive.DriveApi?> _getDriveApi() async {
    final googleUser = await googleSignIn.signIn();
    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      return null;
    }

    final client = GoogleAuthClient(headers);
    final driveApi = drive.DriveApi(client);
    return driveApi;
  }

  Future<drive.FileList> _allFileList(drive.DriveApi driveApi) async {
    return driveApi.files.list(
      spaces: 'drive',
    );
  }

  Future<String?> _getFolderId(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "Flutter-sample-by-tf";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        return null;
      }

      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder = new drive.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print(e);
      // I/flutter ( 6132): DetailedApiRequestError(status: 403, message: The granted scopes do not give access to all of the requested spaces.)
      return null;
    }
  }

  Future<void> _uploadToNormal() async {
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        return;
      }
      // Not allow a user to do something else
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(seconds: 2),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, animation, secondaryAnimation) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      final folderId = await _getFolderId(driveApi);
      if (folderId == null) {
        return;
      }

      // Create data here instead of loading a file
      const contents = "this is a sample file";
      final Stream<List<int>> mediaStream =
          Future.value(contents.codeUnits).asStream().asBroadcastStream();
      var media = new drive.Media(mediaStream, contents.length);

      // Set up File info
      var driveFile = new drive.File();
      final timestamp = DateFormat("yyyy-MM-dd-hhmmss").format(DateTime.now());
      driveFile.name = "sample file-$timestamp.txt";
      driveFile.modifiedTime = DateTime.now().toUtc();
      driveFile.parents = [folderId];

      // Upload
      final response =
          await driveApi.files.create(driveFile, uploadMedia: media);
      print("response: $response");

      // simulate a slow process
      await Future.delayed(Duration(seconds: 2));
    } finally {
      // Remove a dialog
      Navigator.pop(context);
    }
  }

  Future<drive.FileList> _showFilesInMyFolder(drive.DriveApi driveApi) async {
    final folderId = await _getMyFolderId(driveApi, "internship");
    return driveApi.files.list(
      spaces: 'drive',
      q: "'$folderId' in parents",
    );
  }

  Future<String?> _getMyFolderId(
    drive.DriveApi driveApi,
    String folderName,
  ) async {
    print('OK3');
    print(folderName);
    try {
      String _folderType = "application/vnd.google-apps.folder";
      print('OK4');
      final found = await driveApi.files.list(
        q: "mimeType = '$_folderType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      print('OK5');
      final files = found.files;
      print('OK6');
      if (files == null) {
        print('OK7');
        return null;
      }
      print(files);
      print('OK8');
      if (files.isNotEmpty) {
        print('OK9');
        return files.first.id;
      }
    } catch (e) {
      print(e);
    }
    print('OK10');
    return null;
  }

  Widget _createButton(String title, Function(drive.DriveApi driveApi) query) {
    return ElevatedButton(
      onPressed: () async {
        final driveApi = await _getDriveApi();
        if (driveApi == null) {
          return;
        }

        final fileList = await query(driveApi);
        final files = fileList.files;
        if (files == null) {
          return print("Data not found");
        }
        await _showList2(files);
      },
      child: Text(title),
    );
  }

  Future<void> _showList2(List<drive.File> files) {
    const _folderType = "application/vnd.google-apps.folder";
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("List"),
          content: Container(
            width: MediaQuery.of(context).size.height - 50,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final isFolder = files[index].mimeType == _folderType;

                return ListTile(
                  leading: Icon(isFolder
                      ? Icons.folder
                      : Icons.insert_drive_file_outlined),
                  title: Text(files[index].name ?? ""),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadFile() async {
    String fileID = '1PQLkN3vC_ew-1Otedw5YY_bYZ8rEHq9b';

    final driveApi = await _getDriveApi();
    if (driveApi == null) {
      return;
    }
    drive.Media fileContent = await driveApi.files.get(fileID,
        downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

    print("OK1");
    print(fileContent.toString());
    print(fileContent.stream);
    print("OK2");

    List<int> dataStore = [];
    fileContent.stream.listen((data) {
      print("OK3");
      print("DataReceived: ${data.length}");
      print("OK4");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () async {
      print("OK5");
      // print(dataStore);
      // Directory tempDir = await getTemporaryDirectory(); //Get temp folder using Path Provider
      // Directory tempDir = await getTemporaryDirectory();
      print("OK6");
      // String tempPath = tempDir.path; //Get path to that location
      print("OK7");

      File file = File(
          'C:/WBL/Projects/filedisplay_2/asset/test.csv'); //Create a dummy file
      print(file.path);
      print("OK8");
      // await file.writeAsString(contents);
      await file.writeAsBytes(
          dataStore); //Write to that file from the datastore you created from the Media stream
      print("OK9");
      String content = file.readAsStringSync(); // Read String from the file
      print("OK10");
      print(content); //Finally you have your text
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
  }

  Future<void> _loadCSV(BuildContext context) async {
    List<List<dynamic>> _data = [];
    final _rawData = await rootBundle.loadString("data1.csv");
    List<List<dynamic>> _listData = const CsvToListConverter(
            eol: "\r\n", fieldDelimiter: ",", shouldParseNumbers: true)
        .convert(_rawData);
    setState(() {
      _data = _listData;
    });

    List location = [];
    List ST = [];
    List ED = [];
    List<String> PID = [];

    for (int i = 1; i < _data.length; i++) {
      if (_data[i][4] == 'main_activity') {
        location.add(_data[i][4]);
        ST.add(_data[i][7]);
        ED.add(_data[i][8]);
        PID.add(_data[i][9]);
      } else {}
    }

    List<Duration> timeSpentList = [];
    for (int i = 0; i < ST.length; i++) {
      final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(ST[i]);
      final DateTime endDate = DateTime.fromMillisecondsSinceEpoch(ED[i]);
      final Duration duration = endDate.difference(startDate);
      timeSpentList.add(duration);
    }
    List<String> uniquePID = [];
    List<Duration> totalTimeSpentList = [];
    for (int i = 0; i < PID.length; i++) {
      String patientID = PID[i];
      if (uniquePID.contains(patientID)) {
        int index = uniquePID.indexOf(patientID, 0);
        Duration totalValue = totalTimeSpentList[index] + timeSpentList[i];
        totalTimeSpentList[index] = totalValue;
      } else {
        uniquePID.add(patientID);
        totalTimeSpentList.add(timeSpentList[i]);
      }
    }
    print('the patients are : $uniquePID');
    print('the total time spent is: $totalTimeSpentList');

    var OutputList = new Map<String, Duration>();

    for (var i = 0; i < uniquePID.length; i++) {
      OutputList[uniquePID[i]] = totalTimeSpentList[i];
    }

    print('the final data for the bar graph is: $OutputList');
  }

  Future<void> _loadCSV2() async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet = await ss.worksheetByTitle('Copy of all_usage_data');
    print("Gsheets initalized");

    List<String> location_data = await sheet!.values.column(5);
    List ST_data = await sheet.values.column(8);
    print(ST_data);
    List ED_data = await sheet.values.column(9);

    List PID_data = await sheet.values.column(10);

    /* List<List<dynamic>> csvData = [];
    final _rawData = await rootBundle.loadString("data2.csv");
    List<List<dynamic>> _listData = const CsvToListConverter(
            eol: "\r\n", fieldDelimiter: ",", shouldParseNumbers: true)
        .convert(_rawData);
    setState(() {
      csvData = _listData;
    });
*/
    //List location = [];
    //List ST = [];
    //List ED = [];
    // List<String> PID = [];

    /*for (int i = 1; i < csvData.length; i++) {
      //location.add(csvData[i][4]);
      //ST.add(csvData[i][7]);
      //ED.add(csvData[i][8]);
      // PID.add(csvData[i][9]);
    }*/

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
      print('startTimestamp: $startTimestamp');
      final DateTime startDate =
          DateTime.fromMillisecondsSinceEpoch(startTimestamp);

      int endTimestamp = int.parse(ED_data[i]);
      print('endTimestamp: $endTimestamp');
      final DateTime endDate =
          DateTime.fromMillisecondsSinceEpoch(endTimestamp);

      final Duration duration = endDate.difference(startDate);
      print('duration: $duration');

      timeSpentList.add(duration);
    }

    // for each unique patient, and for each unique location, calculate the sum of time spent.
    // create 2D List which contains empty rows & column to hold the final patienty data.
    int uniquePIDCount = uniquePID.length;
    print('uniquePIDCount: $uniquePIDCount');
    int uniqueLocationCount = uniqueLocation.length;
    print('uniqueLocationCount: $uniqueLocationCount');
    int finalRowsCount = uniquePIDCount * uniqueLocationCount;
    print('finalRowsCount: $finalRowsCount');
    List finalPatientData = List.generate(
        finalRowsCount, (_) => List.generate(3, (_) => ''),
        growable: true);
    print('finalPatientData: $finalPatientData');

    // List a = List.generate(4, (_) => List.generate(4, (_) => 0));
    // print(a);
    // [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
    /*
    [
      ['PatientID', 'Location', 'TimeSpent']
    ]; */

    int index = 0;
    for (int i = 0; i < uniquePID.length; i++) {
      print('-------------- i: $i  --------------');
      String patientID = uniquePID[i];
      print('patientID: $patientID');

      List<dynamic> record = [];
      for (int j = 0; j < uniqueLocation.length; j++) {
        print('         +++++++++++++++ j: $j  +++++++++++++');
        String locationID = uniqueLocation[j];
        print('         locationID: $locationID');

        var totalTimeSpent = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int k = 1; k < location_data.length; k++) {
          print('                  +++++++++++++++ k: $k  +++++++++++++');
          final String orgLocation = location_data[k];
          final String orgPatientID = PID_data[k];
          final Duration orgTimeSpent = timeSpentList[k];

          print('                  orgLocation: $orgLocation');
          print('                  orgPatientID: $orgPatientID');
          print('                  orgTimeSpent: $orgTimeSpent');

          if (orgPatientID == patientID && orgLocation == locationID) {
            print(
                '                  --------> both patient ID & location matches <--------');
            totalTimeSpent = totalTimeSpent + orgTimeSpent;
            print('                  totalValue: $totalTimeSpent');
          }
        } // end of for loop for csvData

        // build a new dynamic list to hold the final patient data
        // finalPatientData[index].insert(j, patientID);
        /*
        record.add(patientID);
        print('Yes 1');
        // recordList.add(',');
        record.add(locationID);
        print('Yes 2');
        // recordList.add(',');
        record.add(totalTimeSpent);
        print('Yes 3');
        record.add('\r\n');
        finalPatientData.insert(index, record);
        */

        print('finally .... patientID: $patientID');
        print('finally .... locationID: $locationID');
        print('finally .... totalTimeSpent: $totalTimeSpent');
        var totalTimeSpentString = totalTimeSpent.toString();
        print('finally .... totalTimeSpentString: $totalTimeSpentString');

        print('index: $index');

        print('Yes 1');
        print('finally .... finalPatientData: $finalPatientData');
        finalPatientData[index][0] = patientID;
        print('finally .... finalPatientData: $finalPatientData');
        print('Yes 2');
        finalPatientData[index][1] = locationID;
        print('finally .... finalPatientData: $finalPatientData');
        print('Yes 3');
        finalPatientData[index][2] = totalTimeSpentString;
        print('finally .... finalPatientData: $finalPatientData');
        print('Yes 4');
        print(
            '                  ************* ${finalPatientData[index]} ************* ');
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
    var eachPatientData_array = <double, double>{};

    for (int i = 0; i < finalPatientData.length; i++) {
      if (finalPatientData[i][0] == 'FT-01') {
        String location = finalPatientData[i][1];
        print('location: $location');
        String timeSpentStr = finalPatientData[i][2];
        print('timeSpentStr: $timeSpentStr');

        // Extract the hrs, mins, sec and micro sec from the time string.
        final time = timeSpentStr.split(':');
        print('time: $time');
        int hours = int.parse(time[0]);
        print('time - hours: $hours');
        int minutes = int.parse(time[1]);
        print('time - minutes: $minutes');
        String secondsStr = time[2];
        print('time - secondsStr: $secondsStr');

        // Extract the secoinds & micro seconds from Seconds string.
        final secondsTotal = secondsStr.split('.');
        print('secondsTotal: $secondsTotal');
        int seconds_Sec = int.parse(secondsTotal[0]);
        print('time - seconds_Sec: $seconds_Sec');
        int seconds_MicroSec = int.parse(secondsTotal[1]);
        print('time - seconds_MicroSec: $seconds_MicroSec');

        // convert the timeSpent into milli seconds for bar grpah display purpose.
        Duration timeSpentDuration = Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds_Sec,
            microseconds: seconds_MicroSec);
        print('timeSpentDuration: $timeSpentDuration');

        // Convert the Duration into minutes.
        double timeSpent = (timeSpentDuration.inMinutes).toDouble();
        print('timeSpent: $timeSpent');

        // build the list for bar graph display purpose.
        eachPatientData.add('$location: $timeSpent');
        print('eachPatientData: $eachPatientData');

        // get the location code from location description.
        double locationCode = -1.00;
        locationCodes.forEach((key, value) {
          print('$key:$value');
          if (key == location) {
            print('location found');
            locationCode = value;
            print('location code: $value');
            Breakpoint;
          } else {
            print('location NOT found');
          }
        });

        // convert the list into an array to display bar graph purpose
        var record = <double, double>{locationCode: timeSpent};
        eachPatientData_array.addEntries(record.entries);
        print('eachPatientData_array: $eachPatientData_array');
      }
    } // end of FOR loop

    // convert the list into an array to display bar graph purpose
    /*
    var eachPatientData_array = <String, int>{};
    for (int i = 1; i < eachPatientData.length; i++) {
      eachPatientData_array = eachPatientData[i];
    }
    print('eachPatientData_array: $eachPatientData_array');
    */
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
