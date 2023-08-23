import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ipa_calculator_calculatePage.dart';
import 'ipa_calculator_calculatePageWithCSV.dart';
import 'ipa_calculator_logPage.dart';

class BackData {
  final double? temperature;
  final double? moisture;
  final double? resultValue;

  BackData({this.temperature, this.moisture, this.resultValue});

  Map<String, dynamic> toMap() {
    return {
      'temperature': temperature,
      'moisture': moisture,
      'result_value': resultValue,
    };
  }

  //정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'BackData{temperature: $temperature, moisture: $moisture, result_value: $resultValue}';
  }
}

class ButtonIPACalculator extends StatelessWidget {
  const ButtonIPACalculator({Key? key}) : super(key: key);

  void _showIPACalculatorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IpaCalculator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showIPACalculatorPage(context);
      },
      child: const Text('IPA Calculator'),
    );
  }
}

class IpaCalculator extends StatefulWidget {
  const IpaCalculator({super.key});

  @override
  IpaCalculatorState createState() => IpaCalculatorState();
}



class IpaCalculatorState extends State<IpaCalculator>{
  @override
  void initState() {
    super.initState();
    // Load ads.
  }
  final _resultInputAmount = TextEditingController();
  final _resultMoisture = TextEditingController();
  final _returnInputAmount = TextEditingController();
  final _returnMoisture = TextEditingController();

  final _purifyInputIPA = TextEditingController();
  final _purifyInputWater = TextEditingController();
  final _purifyTemperature = TextEditingController();
  final _purifyMoisture = TextEditingController();
  final _newTemperature = TextEditingController();
  final _newMoisture = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _resultInputAmount.text = '5400';
    _resultMoisture.text = '16';
    _returnInputAmount.text = '245';
    _returnMoisture.text = '34';

    _purifyInputIPA.text = '4000';
    _purifyInputWater.text = '6';
    _purifyTemperature.text = '17';
    _purifyMoisture.text = '11.5';

    _newTemperature.text = '17';
    _newMoisture.text = '0.01';

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('IPA calculator'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                          child: Text("목표값"),
                        ),
                        Flexible(
                          child: TextField(
                            controller: _resultInputAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              labelText: '총투입량',
                            ),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: _resultMoisture,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: '기준수분',
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("회수IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _returnInputAmount,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '초기투입',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _returnMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("정제IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyInputIPA,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '초기투입',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyInputWater,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '세척수',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyTemperature,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '온도',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _purifyMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      )),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20), //apply padding to all four sides
                        child: Text("새IPA"),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _newTemperature,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            labelText: '온도',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _newMoisture,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: '수분',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 10)
                ),
                Row(
                    children: [
                      const ButtonSelectLogs(),
                      ButtonCalculate(
                          resultInputAmountController : _resultInputAmount
                          , resultMoistureController : _resultMoisture
                          , returnInputAmountController : _returnInputAmount
                          , returnMoistureController : _returnMoisture
                          , newTemperatureController : _newTemperature
                          , newMoistureController : _newMoisture
                          , purifyInputIPAController : _purifyInputIPA
                          , purifyInputWaterController : _purifyInputWater
                          , purifyTemperatureController: _purifyTemperature
                          , purifyMoistureController : _purifyMoisture
                      ),
                      ButtonCalculateWithCSV(
                          resultInputAmountController : _resultInputAmount
                          , resultMoistureController : _resultMoisture
                          , returnInputAmountController : _returnInputAmount
                          , returnMoistureController : _returnMoisture
                          , newTemperatureController : _newTemperature
                          , newMoistureController : _newMoisture
                          , purifyInputIPAController : _purifyInputIPA
                          , purifyInputWaterController : _purifyInputWater
                          , purifyTemperatureController: _purifyTemperature
                          , purifyMoistureController : _purifyMoisture
                      ),
                    ]
                ),
                Row(
                  children: [
                    //adContainer,
                  ],
                ),
             ]
          ),
        ),
      );

  }
}