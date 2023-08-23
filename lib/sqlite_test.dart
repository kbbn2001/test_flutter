
import 'dart:async';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Dog {
  final int? id;
  final String? name;
  final int? age;

  //Dog({required this.id, required this.name, required this.age});
  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class Log {
  final String? info;
  final String? log_date;

  Log({this.info, this.log_date});

  Map<String, dynamic> toMap() {
    return {
      'info': info,
      'log_date': log_date,
    };
  }

  @override
  String toString() {
    return 'Log{info: $info, log_date: $log_date}';
  }
}
class SqliteTestModel {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'test_database5.db');

    return await openDatabase(
        path,
        version: 2,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
          );
          autoExcelUpload();

          return db.execute(
            "CREATE TABLE logs(info TEXT, log_date TEXT)",
          );
        },
    );
  }

  Future<dynamic> Select() async {
    final db = await database;
    // testTable 테이블에 있는 모든 field 값을 maps에 저장한다.
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    print('Do Select');
    return maps.isNotEmpty ? maps : null;
  }

  Future<void> Insert(Dog item) async {
    final db = await database;
    await db.insert(
        'dogs',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> Delete(int id) async {
    final db = await database;
    await db.delete(
      'dogs',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> Update(Dog item) async {
    final db = await database;
    await db.update(
      'dogs',
      item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id]
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



Future<Excel> getExcel() async {
  //엑셀파일 로딩하는 부분.
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  print(documentsDirectory.path);
  String path = join(documentsDirectory.path, "flutter_excel_test.xlsx");

  // Only copy if the database doesn't exist
  if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('assets', 'excelFile/flutter_excel_test.xlsx'));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
  }

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String databasePath = join(appDocDir.path, 'flutter_excel_test.xlsx');
  var bytes = File(databasePath).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  return excel;
}

void autoExcelUpload() async {
  var excel = await getExcel();

  for (var table in excel.tables.keys) {
    Sheet? sheetObject = excel.tables[table];

    print(table); //sheet Name
    print(sheetObject?.maxCols);
    print(sheetObject?.maxRows);

    var index = 0;
    final model = SqliteTestModel();
    for (var row in excel.tables[table]!.rows) {
      if( index != 0){
        var myArr = List.generate(3, (index) => '');
        var i = 0;
        for(var col in row){
          myArr[i] = col!.value.toString() ;
          i ++;
        }
        print(myArr);
        var newDog = Dog(id : int.parse(myArr[0])
            , name :  myArr[1]
            , age : int.parse(myArr[2])
        );

        model.Insert(newDog).then((value){
          Fluttertoast.showToast(msg: '저장완료');
        });
      }
      else{
        print(row.getRange(0, 2));
      }
      index ++;

      //print(row.first?.value.toString());
      //print(row);
      //print('---');
    }
  }
}

class ButtonSelectAll extends StatelessWidget {
  const ButtonSelectAll({Key? key}) : super(key: key);

  void _showSelectAllPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectAllPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showSelectAllPage(context);
      },
      child: const Text('Select All'),
    );
  }
}

class SelectAllPage extends StatefulWidget {
  const SelectAllPage({Key? key}) : super(key: key);

  @override
  State<SelectAllPage> createState() => _SelectAllPageStatus();
}

class _SelectAllPageStatus extends State<SelectAllPage> {

  @override
  Widget build(BuildContext context) {
    final _model = SqliteTestModel();

    _model.InsertLogs(Log(info : "Select All Button Click"
        , log_date :  DateTime.now().toString()
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select All'),
      ),
      body: Center(
          child: Column(
            children: [
              Container(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        child: Center(
                          child: Text('id'),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Center(
                          child: Text('name'),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Center(
                          child: Text('ages'),
                        ),
                      ),
                    ],
                  )
              ),
              Expanded(
            child: Scrollbar (
                //physics: ScrollPhysics(),
                //scrollDirection: Axis.vertical,
                child: FutureBuilder(
                  future: _model.Select(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.hasData) {
                      print(snapshot);
                      print('==========time test=========');
                      print(DateTime.now().toString());

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data.length,
                          itemBuilder:(BuildContext context, int index){
                            print(snapshot.data[index]);
                            return Container(
                                height: 100,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text('${snapshot.data[index]['id']}'),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text('${snapshot.data[index]['name']}'),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Center(
                                        child: Text('${snapshot.data[index]['ages']}'),
                                      ),
                                    ),
                                  ],
                                )
                            );

                          }
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

class ButtonSelectLogs extends StatelessWidget {
  const ButtonSelectLogs({Key? key}) : super(key: key);

  void _showLogPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showLogPage(context);
      },
      child: const Text('Show logs'),
    );
  }
}

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageStatus();
}

class _LogPageStatus extends State<LogPage> {

  @override
  Widget build(BuildContext context) {
    final _model = SqliteTestModel();

    _model.InsertLogs(Log(info : "Show logs Button Click"
        , log_date :  DateTime.now().toString()
    ));
    final deviceWidth = MediaQuery.of(context).size.width;
    final dataWidth = deviceWidth / 100 * 40;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select All'),
        ),
        body: Center(
            child: Column(
              children: [
                Container(
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          width: dataWidth,
                          child: Center(
                            child: Text('info'),
                          ),
                        ),
                        Container(
                          width: dataWidth,
                          child: Center(
                            child: Text('date'),
                          ),
                        ),
                      ],
                    )
                ),
                Expanded(
                    child: Scrollbar (
                      //physics: ScrollPhysics(),
                      //scrollDirection: Axis.vertical,
                      child: FutureBuilder(
                        future: _model.SelectLogs(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(8),
                                itemCount: snapshot.data.length,
                                itemBuilder:(BuildContext context, int index){
                                  print(snapshot.data[index]);
                                  return Container(
                                      height: 100,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: dataWidth,
                                            child: Center(
                                              child: Text('${snapshot.data[index]['info']}'),
                                            ),
                                          ),
                                          Container(
                                            width: dataWidth,
                                            child: Center(
                                              child: Text('${snapshot.data[index]['log_date'].toString().substring(0,19)}'),
                                            ),
                                          ),
                                        ],
                                      )
                                  );

                                }
                            );
                          }
                          else{
                            return const Text('no data');
                          }
                        },
                      ),
                    )
                ),
                //adContainer,
              ],
            )
        )
    );
  }
}

void main() async {
  runApp(const MaterialApp (
    home: MyApp(),
  ));


  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  final _model = SqliteTestModel();
  _model.Select().then((value) {
    print('=====DB Check====');
    print('total rows : ${value.length}');
    print('=====DB Check====');
    if(value.length < 11){
      autoExcelUpload();
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  MyAppState createState() => MyAppState();
}



class MyAppState extends State<MyApp>{
  @override
  void initState() {
    super.initState();
    // Load ads.

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String iOSTestId = 'ca-app-pub-3940256099942544/2934735716';
    final String androidTestId = 'ca-app-pub-3940256099942544/6300978111';

    final BannerAd myBanner = BannerAd(
      //adUnitId: 'ca-app-pub-2383726789720442/5093561266', //이거는 운영때 써야함.
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', //테스트용 id
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );

    final myController = TextEditingController();
    final myController2 = TextEditingController();
    final myController3 = TextEditingController();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('sqllite test'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    children: [
                        const ButtonSelectLogs(),
                        ElevatedButton(
                        onPressed: () async {
                          autoExcelUpload();
                        },
                        child: const Text('Excel test'),
                      ),
                      ]
                ),
                TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                    labelText: 'Id',
                  ),
                ),
                TextField(
                  controller: myController2,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: myController3,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                Row(
                    children: [
                      const ButtonSelectAll(),
                      ElevatedButton(
                        onPressed: () async {
                          var testDog = Dog(id : int.parse(myController.text)
                              , name :  myController2.text
                              , age : int.parse(myController3.text)
                          );
                          final _model = SqliteTestModel();
                          _model.Insert(testDog).then((value){
                            myController.text = '';
                            myController2.text = '';
                            myController3.text = '';
                            Fluttertoast.showToast(msg: '저장완료');
                          });
                        },
                        child: const Text('insert'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var testDog = Dog(id : int.parse(myController.text)
                              , name :  myController2.text
                              , age : int.parse(myController3.text)
                          );
                          final _model = SqliteTestModel();
                          _model.Update(testDog).then((value){
                            myController.text = '';
                            myController2.text = '';
                            myController3.text = '';
                            Fluttertoast.showToast(msg: '저장완료');
                          });
                        },
                        child: const Text('update'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final _model = SqliteTestModel();
                          _model.Delete(int.parse(myController.text)).then((value){
                            myController.text = '';
                            myController2.text = '';
                            myController3.text = '';
                            Fluttertoast.showToast(msg: '삭제완료');
                          });
                        },
                        child: const Text('Delete'),
                      ),
                    ]
                ),
                Row(
                  children: [
                    adContainer,
                  ],
                ),
             ]
          ),
        ),
      ),
    );
  }
}

/*
class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'age' : age,
    };
  }
}

void main() async{
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version){
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  final fido = Dog(
      id : 0,
      name : 'Fido',
      age : 35
  );

  await insertDog(fido);

}
*/