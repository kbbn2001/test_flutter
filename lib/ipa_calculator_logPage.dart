
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ipa_calculator_log_sqlite.dart';

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

    final double dataWidth = 70;
    final double dataWidthLarge = 150;
    final double headerHeight = 50;
    final double dataHeight = 30;

    final ScrollController horizontalScroll = ScrollController();
    final ScrollController verticalScroll = ScrollController();

    final model = SqliteTestModel();


    return Scaffold(
        appBar: AppBar(
          title: const Text('Select All'),
        ),
        body: Center(
            child: AdaptiveScrollbar(
                controller: verticalScroll,
                width: 5,
                child: AdaptiveScrollbar(
                    controller: horizontalScroll,
                    width: 5,
                    position: ScrollbarPosition.bottom,
                    underSpacing: const EdgeInsets.only(bottom: 5),
                    child: SingleChildScrollView(
                      controller: horizontalScroll,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                          width: 900,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: headerHeight,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('목표투입'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('목표수분'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('회수투입'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('회수수분'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('정제추투입'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('세척수'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('정제온도'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('정제수분'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('새온도'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidth,
                                        child: const Center(
                                          child: Text('새수분'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dataWidthLarge,
                                        child: const Center(
                                          child: Text('시간'),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                  child: Scrollbar (
                                    child: FutureBuilder(
                                      future: model.SelectLogs(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.hasData) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.all(8),
                                              itemCount: snapshot.data.length,
                                              itemBuilder:(BuildContext context, int index){
                                                return SizedBox(
                                                    height: dataHeight,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['resultInputAmount']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['resultMoisture']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['returnInputAmount']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['returnMoisture']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['purifyInputIPA']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['purifyInputWater']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['purifyTemperature']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['purifyMoisture']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['newTemperature']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidth,
                                                          child: Center(
                                                            child: Text('${snapshot.data[index]['newMoisture']}'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dataWidthLarge,
                                                          child: Center(
                                                            child: Text(snapshot.data[index]['log_date'].toString().substring(0,19)),
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
                      ),
                    )))


        )
    );
  }
}