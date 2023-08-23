import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'ipa_calculator_deviceInfo.dart';

class Log {
  final String? info;
  final String? log_date;
  final String? id;

  Log({this.info, this.log_date, this.id});

  Map<String, dynamic> toMap() {
    return {
      'info': info,
      'log_date': log_date,
      'id' : id,
    };
  }

  @override
  String toString() {
    return 'Log{info: $info, log_date: $log_date, id : $id}';
  }

  static Future<dynamic> select() async {
    String id = await DeviceInfo.getAndroidId();

    List<Map<String, dynamic>> result = [];
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'database-1.czithwdbbjzn.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'test',
        db: 'IPA',
        password: 'test'));

    var results = await conn.query(
        'select info, log_date, id result_value from LOG where id = ? limit 100' , [id]);

    for (var row in results) {
      if (kDebugMode) {
        print('info: ${row[0]}, log_date: ${row[1]}');
      }

      Log myData = Log(info: row[0]
          , log_date: row[1]
          , id: row[2]
      );
      result.add(myData.toMap());
    }
    conn.close();
    return result;
  }

  static Future<dynamic> insert(String info, String id) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'database-1.czithwdbbjzn.ap-northeast-2.rds.amazonaws.com',
        port: 3306,
        user: 'test',
        db: 'IPA',
        password: 'test'));

    await conn.query(
        'insert into LOG(info, log_date, id) values (?, ?, ?)'
        , [info, DateTime.now().toString(), id]
    );

    conn.close();
  }
}
