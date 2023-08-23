import 'dart:async';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'ipa_calculator_log_sqlite.dart';

class ButtonCalculateWithCSV extends StatelessWidget {
  final TextEditingController resultInputAmountController;
  final TextEditingController resultMoistureController;
  final TextEditingController returnInputAmountController;
  final TextEditingController returnMoistureController;
  final TextEditingController purifyInputIPAController;
  final TextEditingController purifyInputWaterController;
  final TextEditingController purifyTemperatureController;
  final TextEditingController purifyMoistureController;
  final TextEditingController newTemperatureController;
  final TextEditingController newMoistureController;


  ButtonCalculateWithCSV({Key? key
    , required this.resultInputAmountController
    , required this.resultMoistureController
    , required this.returnInputAmountController
    , required this.returnMoistureController
    , required this.purifyInputIPAController
    , required this.purifyInputWaterController
    , required this.purifyTemperatureController
    , required this.purifyMoistureController
    , required this.newTemperatureController
    , required this.newMoistureController
  }) : super(key: key);

  void _showCalculatePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          CalculatePageWithCSV(
              resultInputAmountController : resultInputAmountController
              , resultMoistureController: resultMoistureController
              , returnInputAmountController: returnInputAmountController
              , returnMoistureController: returnMoistureController
              , newTemperatureController: newTemperatureController
              , newMoistureController: newMoistureController
              , purifyInputIPAController: purifyInputIPAController
              , purifyInputWaterController: purifyInputWaterController
              , purifyTemperatureController : purifyTemperatureController
              , purifyMoistureController: purifyMoistureController
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showCalculatePage(context);
      },
      child: const Text('Calculate(CSV)'),
    );
  }
}

class CalculatePageWithCSV extends StatefulWidget {
  TextEditingController resultInputAmountController;
  TextEditingController resultMoistureController;
  TextEditingController returnInputAmountController;
  TextEditingController returnMoistureController;
  TextEditingController purifyTemperatureController;
  TextEditingController purifyMoistureController;
  TextEditingController newTemperatureController;
  TextEditingController newMoistureController;
  TextEditingController purifyInputIPAController;
  TextEditingController purifyInputWaterController;

  CalculatePageWithCSV( {Key? key
    , required this.resultInputAmountController
    , required this.resultMoistureController
    , required this.returnInputAmountController
    , required this.returnMoistureController
    , required this.newTemperatureController
    , required this.newMoistureController
    , required this.purifyInputIPAController
    , required this.purifyInputWaterController
    , required this.purifyTemperatureController
    , required this.purifyMoistureController
  }) : super(key: key);

  @override
  State<CalculatePageWithCSV> createState() =>
      _CalculatePageWithCSVStatus(
          resultInputAmountController
          , resultMoistureController
          , returnInputAmountController
          , returnMoistureController
          , newTemperatureController
          , newMoistureController
          , purifyInputIPAController
          , purifyInputWaterController
          ,purifyTemperatureController
          , purifyMoistureController
      );
}

class _CalculatePageWithCSVStatus extends State<CalculatePageWithCSV> {
  TextEditingController? resultInputAmountController;
  TextEditingController? resultMoistureController;
  TextEditingController? returnInputAmountController;
  TextEditingController? returnMoistureController;
  TextEditingController? newTemperatureController;
  TextEditingController? newMoistureController;
  TextEditingController? purifyInputIPAController;
  TextEditingController? purifyInputWaterController;
  TextEditingController? purifyTemperatureController;
  TextEditingController? purifyMoistureController;

  _CalculatePageWithCSVStatus(
      this.resultInputAmountController
      , this.resultMoistureController
      , this.returnInputAmountController
      , this.returnMoistureController
      , this.newTemperatureController
      , this.newMoistureController
      , this.purifyInputIPAController
      , this.purifyInputWaterController
      , this.purifyTemperatureController
      , this.purifyMoistureController
      );

  Future<dynamic> SelectCalculateIPA_DATA() async {

    final double purifyTemperature = double.parse(purifyTemperatureController!.text);
    final double purifyMoisture = double.parse(purifyMoistureController!.text);
    final double newTemperature = double.parse(newTemperatureController!.text);
    final double newMoisture = double.parse(newMoistureController!.text);

    //List<Map<String, dynamic>> result = [];
    List<double> result = [];
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'database-1.czithwdbbjzn.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'test',
        db: 'IPA',
        password: 'test'));

    var results = await conn.query(
        'select result_value from IPA_DATA where temperature = ? and moisture = ?'
        , [purifyTemperature, purifyMoisture]);
    if(results.isEmpty){
      result.add(-99999);
    }
    else{
      for (var row in results) {
        result.add(row['result_value']);
      }
    }

    results = await conn.query(
        'select result_value from IPA_DATA where temperature = ? and moisture = ?'
        , [newTemperature, newMoisture]);
    if(results.isEmpty){
      result.add(-99999);
    }
    else{
      for (var row in results) {
        result.add(row['result_value']);
      }
    }

    conn.close();
    return result;
  }

  Future<List<double>> processCsv() async {
    //csv파일 로딩하는 부분.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "backdata.csv");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'excelFile/backdata.csv'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
    }

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = join(appDocDir.path, 'backdata.csv');

    var myData = await rootBundle.loadString("assets/excelFile/backdata.csv");
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(myData);

    final int purifyTemperature = int.parse(purifyTemperatureController!.text);
    final double purifyMoisture = double.parse(purifyMoistureController!.text);
    final int newTemperature = int.parse(newTemperatureController!.text);
    final double newMoisture = double.parse(newMoistureController!.text);

    List<double> result = [];
    for (var element in rowsAsListOfValues) {
      if(element[0] == purifyMoisture){
        result.add(element[purifyTemperature + 1]);
        break;
      }
    }

    for (var element in rowsAsListOfValues) {
      if(element[0] == newMoisture){
        result.add(element[newTemperature + 1]);
        break;
      }
    }
    /*
    rowsAsListOfValues.forEach((element) {
      if(element[0] == purifyMoisture){
        print(element[purifyTemperature + 1]);
        result.add(element[purifyTemperature + 1]);
      }
    });
    rowsAsListOfValues.forEach((element) {
      if(element[0] == newMoisture){
        print(element[newTemperature + 1]);
        result.add(element[newTemperature + 1]);
      }
    });
     */
    return result;
  }

  @override
  Widget build(BuildContext context) {

    final double headWidth = 130;
    final double valueWidth = 200;

    final double tableHeadWidth = 130;
    final double tableColWidth = 50;

    final _model = SqliteTestModel();
    _model.InsertLogs(Log(
        resultInputAmount : double.parse(resultInputAmountController!.text)
        ,resultMoisture : double.parse(resultMoistureController!.text)
        ,returnInputAmount : double.parse(returnInputAmountController!.text)
        ,returnMoisture : double.parse(returnMoistureController!.text)
        ,purifyInputIPA : double.parse(purifyInputIPAController!.text)
        ,purifyInputWater : double.parse(purifyInputWaterController!.text)
        ,purifyTemperature : double.parse(purifyTemperatureController!.text)
        ,purifyMoisture : double.parse(purifyMoistureController!.text)
        ,newTemperature : double.parse(newTemperatureController!.text)
        ,newMoisture : double.parse(newMoistureController!.text)
        , log_date :  DateTime.now().toString()
    ));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculate'),
        ),
        body: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView (
                    child: FutureBuilder(
                      future: processCsv(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.hasData) {
                          print("=======ttt========");
                          print(snapshot);

                          double D4 = double.parse(resultInputAmountController!.text);
                          double D5 = double.parse(resultMoistureController!.text);
                          double D6 = double.parse(returnInputAmountController!.text);
                          double D7 = double.parse(returnMoistureController!.text);

                          double D8 = double.parse(purifyInputIPAController!.text);
                          double D9 = double.parse(purifyInputWaterController!.text);
                          double D10 = double.parse(purifyTemperatureController!.text);
                          double D11 = double.parse(purifyMoistureController!.text);


                          double D12 = double.parse(newTemperatureController!.text);
                          double D13 = double.parse(newMoistureController!.text);

                          double Q4 = snapshot.data[0]; //내삽에서 가져온거랑 똑같은값
                          double Q5 = snapshot.data[1]; //내삽에서 가져온거랑 똑같은값
                          double Q6 = double.parse('0.9982'); //고정된숫자.
                          double Q8 = D8 * Q4;
                          double Q9 = D9 * 61.21 * Q4;

                          double V4 = D4 * D5 / 100;
                          double W4 = D4 * (100 - D5) / 100;
                          double U4 = V4 / (V4 + W4) * 100;


                          double V5 = D6 * D7 / 100;
                          double W5 = D6 * (100 - D7) / 100;
                          double U5 = V5 / (V5 + W5) * 100;


                          double V6 = Q8 * D11 / 100;
                          double W6 = Q8 * (100 - D11) / 100;
                          double U6 = V6 / (V6 + W6) * 100;


                          double V7 = V4 - V5 - V6;
                          double W7 = W4 - W5 - W6;
                          double U7 = V7 / (V7 + W7) * 100;


                          bool U8 = (D11 == U7 ? true : false);
                          bool U9 = (D11 < U7 ? true : false);

                          double X9 = W7 / ((100 - D11) / 100);
                          double W9 = X9 * (100 - D11) / 100;
                          double V9 = X9 * D11 / 100;

                          double V10 = V7 - V9;

                          bool U11 = (D11 > U7 ? true : false);
                          double X11 = V7 / ((D11) / 100);
                          double V11 = X11 * D11 / 100;
                          double W11 = X11 * ((100 - D11) / 100);
                          double W12 = W7 - W11;

                          double Q12;
                          if(U9){
                            Q12 = X9;
                          }
                          else if(U11){
                            Q12 = X11;
                          }
                          else if(U8){
                            Q12 = D4 - Q8;
                          }
                          else{
                            Q12 = -99999;
                          }
                          double Q13 = (U11 ? W12 : 0);
                          double Q14 = (U9 ? V10 : 0);

                          double H4 = (Q12 - Q9) / Q4;

                          double Q10 = H4 * Q4;

                          double H5 = Q13 / Q5;
                          double H6 = Q14;
                          double H8 = D6;
                          double H9 = Q8 + Q10 - Q9;
                          double H10 = Q9;
                          double H11 = Q13;
                          double H12 = Q14;
                          double H13 = H8 + H9 + H10 + H11 + H12;



                          // 화면에 표시하기 위해 반올림 등 처리.
                          Q8 = Q8.roundToDouble();
                          Q9 = Q9.roundToDouble();
                          Q10 = Q10.roundToDouble();

                          U4 = (U4 * 100.0).roundToDouble() / 100;
                          V4 = V4.roundToDouble();
                          W4 = W4.roundToDouble();
                          U5 = (U5 * 100.0).roundToDouble() / 100;
                          V5 = V5.roundToDouble();
                          W5 = W5.roundToDouble();
                          U6 = (U6 * 100.0).roundToDouble() / 100;
                          U7 = (U7 * 100.0).roundToDouble() / 100;
                          V6 = V6.roundToDouble();
                          W6 = W6.roundToDouble();
                          V7 = V7.roundToDouble();
                          W7 = W7.roundToDouble();
                          D11 = (D11 * 100.0).roundToDouble() / 100;
                          V9 = V9.roundToDouble();
                          W9 = W9.roundToDouble();
                          X9 = X9.roundToDouble();
                          V10 = V10.roundToDouble();

                          X11 = X11.roundToDouble();
                          V11 = V11.roundToDouble();
                          W11 = W11.roundToDouble();
                          W12 = W12.roundToDouble();
                          Q12 = Q12.roundToDouble();
                          Q13 = Q13.roundToDouble();
                          Q14 = Q14.roundToDouble();
                          H4 = H4.roundToDouble();
                          H5 = H5.roundToDouble();
                          H6 = H6.roundToDouble();
                          Q10 = Q10.roundToDouble();



                          H8 = H8.roundToDouble();
                          H9 = H9.roundToDouble();
                          H10 = H10.roundToDouble();
                          H11 = H11.roundToDouble();
                          H12 = H12.roundToDouble();
                          H13 = H13.roundToDouble();


                          //return Text(snapshot.data['result_value'].toString());
                          //return Text('test');
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('추가 적산'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('정제IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$H4'),
                                          ),
                                          const Text('L'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('새IPA'),
                                          ),
                                          Container(
                                              width: valueWidth,
                                              child: Text('$H5')
                                          ),
                                          const Text('L'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('H2O'),
                                          ),
                                          Container(
                                              width: valueWidth,
                                              child: Text('$H6')
                                          ),
                                          Text('L'),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('투입량'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('회수IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$H8'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('정제IPA'),
                                          ),
                                          Container(
                                              width: valueWidth,
                                            child: Text('$H9'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('세척수'),
                                          ),
                                          Container(
                                              width: valueWidth,
                                              child: Text('$H10'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('새IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$H11'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('H2O'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$H12'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('총량'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$H13'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('적용 비중'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('정제IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q4'),
                                          ),
                                          const Text('g/cm3'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('새IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q5'),
                                          ),
                                          const Text('g/cm3'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('H2O'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q6'),
                                          ),
                                          Text('g/cm3'),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('정제IPA 투입내역'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('초기투입'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q8'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('세척수'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q9'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('추가투입'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q10'),
                                          ),
                                          Text('kg'),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('추가 투입량'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('정제IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q12'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('새IPA'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q13'),
                                          ),
                                          const Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: headWidth,
                                            child: const Text('H20'),
                                          ),
                                          Container(
                                            width: valueWidth,
                                            child: Text('$Q14'),
                                          ),
                                          Text('kg'),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Column(
                                    children: [
                                      const Text('계산과정'),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 5), //apply padding to all four sides
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('농도'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('H2O'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('IPA'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('정제IPA'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('목표값'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U4'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V4'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W4'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('회수IPA투입량'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U5'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V5'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W5'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('초기투입량'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U6'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V6'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W6'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('추가필요량'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U7'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V7'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W7'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('수분동일'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U8'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('저수분'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U9'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V9'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W9'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$X9'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('저수분 + H2O'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V10'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('고수분'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$U11'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$V11'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W11'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$X11'),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: tableHeadWidth,
                                            child: Text('고수분 + IPA'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text('$W12'),
                                          ),
                                          Container(
                                            width: tableColWidth,
                                            child: Text(''),
                                          ),
                                          Text('kg'),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          return const Text('no data');
                        }
                      },
                    ),
                  )
                )

              ],
            )


        )
    );
  }
}

