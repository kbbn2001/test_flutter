import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Log {
  final double? resultInputAmount;
  final double? resultMoisture;
  final double? returnInputAmount;
  final double? returnMoisture;
  final double? purifyInputIPA;
  final double? purifyInputWater;
  final double? purifyTemperature;
  final double? purifyMoisture;
  final double? newTemperature;
  final double? newMoisture;
  final String? log_date;


  Log({
    this.resultInputAmount
    , this.resultMoisture
    , this.returnInputAmount
    , this.returnMoisture
    , this.purifyInputIPA
    , this.purifyInputWater
    , this.purifyTemperature
    , this.purifyMoisture
    , this.newTemperature
    , this.newMoisture
    , this.log_date
  });

  Map<String, dynamic> toMap() {
    return {
      'resultInputAmount': resultInputAmount
      ,'resultMoisture': resultMoisture
      ,'returnInputAmount': returnInputAmount
      ,'returnMoisture': returnMoisture
      ,'purifyInputIPA': purifyInputIPA
      ,'purifyInputWater': purifyInputWater
      ,'purifyTemperature': purifyTemperature
      ,'purifyMoisture': purifyMoisture
      ,'newTemperature': newTemperature
      ,'newMoisture': newMoisture
      ,'log_date': log_date
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}


class SqliteTestModel {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'log_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE logs(resultInputAmount double, resultMoisture double, returnInputAmount double, returnMoisture double, purifyInputIPA double, purifyInputWater double, purifyTemperature double, purifyMoisture double, newTemperature double, newMoisture double"
              ", log_date TEXT)",
        );
      },
    );
  }

  Future<dynamic> SelectLogs() async {
    final db = await database;
    // testTable 테이블에 있는 모든 field 값을 maps에 저장한다.
    final List<Map<String, dynamic>> maps = await db.query('logs');
    return maps.isNotEmpty ? maps : null;
  }

  Future<void> InsertLogs(Log item) async {
    final db = await database;
    await db.insert(
        'logs',
        item.toMap()
    );
  }

}