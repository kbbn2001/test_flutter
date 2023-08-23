import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class ButtonIPAError extends StatelessWidget {
  const ButtonIPAError({Key? key}) : super(key: key);

  void _showIPAErrorPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IpaError()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showIPAErrorPage(context);
      },
      child: const Text('IPA Error'),
    );
  }
}

class IpaError extends StatefulWidget {
  const IpaError({super.key});

  @override
  IpaErrorState createState() => IpaErrorState();
}



class IpaErrorState extends State<IpaError>{
  @override
  void initState() {
    super.initState();
    // Load ads.
    _baseIPA1.text = '5400';
    _baseMoisture1.text = '16';
  }
  final _baseIPA1 = TextEditingController();
  final _baseMoisture1 = TextEditingController();
  final _baseIPA2 = TextEditingController();
  final _baseMoisture2 = TextEditingController();
  final _baseIPA3 = TextEditingController();
  final _baseMoisture3 = TextEditingController();
  final _inputIPA1 = TextEditingController();
  final _inputIPA2 = TextEditingController();
  final _inputIPA3 = TextEditingController();
  final _inputIPA4 = TextEditingController();
  final _inputIPA5 = TextEditingController();
  final _inputMoisture1 = TextEditingController();
  final _inputMoisture2 = TextEditingController();
  final _inputMoisture3 = TextEditingController();
  final _inputMoisture4 = TextEditingController();
  final _inputMoisture5 = TextEditingController();
  final _newIPA1 = TextEditingController();
  final _newIPA2 = TextEditingController();
  final _newIPA3 = TextEditingController();
  final _newIPA4 = TextEditingController();
  final _newIPA5 = TextEditingController();
  final _inputH2O1 = TextEditingController();
  final _inputH2O2 = TextEditingController();
  final _inputH2O3 = TextEditingController();
  final _inputH2O4 = TextEditingController();
  final _inputH2O5 = TextEditingController();
  final _currentIPA = TextEditingController();

  double H5 = 0, D5 = 0, F5 = 0, J5 = 0;
  double H6 = 0, D6 = 0, F6 = 0, J6 = 0;
  double H7 = 0, D7 = 0, F7 = 0, J7 = 0;
  double H8 = 0, D8 = 0, F8 = 0, J8 = 0;
  double D9 = 0, D10 = 0, D11 = 0, D12 = 0, D13 = 0;
  double F9 = 0, F10 = 0, F11 = 0, F12 = 0, F13 = 0;
  double H9 = 0, H10 = 0, H11 = 0, H12 = 0, H13 = 0;
  double J9 = 0, J10 = 0, J11 = 0, J12 = 0, J13 = 0;
  double H14 = 0, H15 = 0, H16 = 0, H17 = 0, H18 = 0;
  double J19 = 0, J20 = 0, J21 = 0, J22 = 0, J23 = 0;
  double F24 = 0, H24 = 0 , J24 = 0;
  double F25 = 0, H25 = 0 , J25 = 0;
  double F26 = 0;
  bool X16 = false, X17 = false;
  bool Y11 = false, Y12 = false, Y13 = false, Y14 = false, Y15 = false, Y16 = false, Y17 = false;
  bool Z11 = false, Z12 = false, Z13 = false, Z14 = false, Z15 = false, Z16 = false, Z17 = false;
  bool AA11 = false, AA12 = false, AA15 = false;
  bool AB11 = false, AB12 = false, AB13 = false, AB14 = false, AB15 = false, AB16 = false, AB17 = false;
  bool AC11 = false, AC12 = false, AC18 = false, AC19 = false;
  bool W11 = false, W12 = false, W13 = false, W14 = false, W15 = false, W16 = false, W17 = false, W18 = false, W19 = false;
  double O15 = 0, O16 = 0, O17 = 0;
  double Q11 = 0, Q13 = 0, Q17 = 0, Q18 = 0;
  double S12 = 0, S14 = 0, S16 = 0, S18 = 0;
  double U11 = 0, U12 = 0, U13 = 0, U14 = 0, U15 = 0, U16 = 0, U17 = 0, U18 = 0, U19 = 0;


  void _calculateValue() {

    D5 = (_baseIPA1.text.isEmpty ? 0 : double.parse(_baseIPA1.text));
    F5 = (_baseMoisture1.text.isEmpty ? 0 : double.parse(_baseMoisture1.text));
    D6 = (_baseIPA2.text.isEmpty ? 0 : double.parse(_baseIPA2.text));
    F6 = (_baseMoisture2.text.isEmpty ? 0 : double.parse(_baseMoisture2.text));
    D7 = (_baseIPA3.text.isEmpty ? 0 : double.parse(_baseIPA3.text));
    F7 = (_baseMoisture3.text.isEmpty ? 0 : double.parse(_baseMoisture3.text));

    H5 = D5 * (100 - F5) / 100;
    J5 = D5 * F5 / 100;
    H6 = (D6 == 0 || F6 == 0) ? 0 : D6 * (100 - F6) / 100;
    J6 = D6 * F6 / 100;
    H7 = (D7 == 0 || F7 == 0) ? 0 : D7 * (100 - F7) / 100;
    J7 = D7 * F7 / 100;

    D8 = D5 + D6 + D7;
    H8 = H5 + H6 + H7;
    J8 = J5 + J6 + J7;
    F8 = (D8 == 0 ? 0 : J8 / D8 * 100);

    D9 = (_inputIPA1.text.isEmpty ? 0 : double.parse(_inputIPA1.text));
    D10 = (_inputIPA2.text.isEmpty ? 0 : double.parse(_inputIPA2.text));
    D11 = (_inputIPA3.text.isEmpty ? 0 : double.parse(_inputIPA3.text));
    D12 = (_inputIPA4.text.isEmpty ? 0 : double.parse(_inputIPA4.text));
    D13 = (_inputIPA5.text.isEmpty ? 0 : double.parse(_inputIPA5.text));

    F9 = (_inputMoisture1.text.isEmpty ? 0 : double.parse(_inputMoisture1.text));
    F10 = (_inputMoisture2.text.isEmpty ? 0 : double.parse(_inputMoisture2.text));
    F11 = (_inputMoisture3.text.isEmpty ? 0 : double.parse(_inputMoisture3.text));
    F12 = (_inputMoisture4.text.isEmpty ? 0 : double.parse(_inputMoisture4.text));
    F13 = (_inputMoisture5.text.isEmpty ? 0 : double.parse(_inputMoisture5.text));

    H9 = D9 * (100 - F9 ) / 100;
    H10 = D10 * (100 - F10 ) / 100;
    H11 = D11 * (100 - F11 ) / 100;
    H12 = D12 * (100 - F12 ) / 100;
    H13 = D13 * (100 - F13 ) / 100;

    J9 = D9 * F9 / 100;
    J10 = D10 * F10 / 100;
    J11 = D11 * F11 / 100;
    J12 = D12 * F12 / 100;
    J13 = D13 * F13 / 100;

    F9 = (_inputMoisture1.text.isEmpty ? 0 : double.parse(_inputMoisture1.text));
    F10 = (_inputMoisture2.text.isEmpty ? 0 : double.parse(_inputMoisture2.text));
    F11 = (_inputMoisture3.text.isEmpty ? 0 : double.parse(_inputMoisture3.text));
    F12 = (_inputMoisture4.text.isEmpty ? 0 : double.parse(_inputMoisture4.text));
    F13 = (_inputMoisture5.text.isEmpty ? 0 : double.parse(_inputMoisture5.text));

    H14 = (_newIPA1.text.isEmpty ? 0 : double.parse(_newIPA1.text));
    H15 = (_newIPA2.text.isEmpty ? 0 : double.parse(_newIPA2.text));
    H16 = (_newIPA3.text.isEmpty ? 0 : double.parse(_newIPA3.text));
    H17 = (_newIPA4.text.isEmpty ? 0 : double.parse(_newIPA4.text));
    H18 = (_newIPA5.text.isEmpty ? 0 : double.parse(_newIPA5.text));

    J19 = (_inputH2O1.text.isEmpty ? 0 : double.parse(_inputH2O1.text));
    J20 = (_inputH2O2.text.isEmpty ? 0 : double.parse(_inputH2O2.text));
    J21 = (_inputH2O3.text.isEmpty ? 0 : double.parse(_inputH2O3.text));
    J22 = (_inputH2O4.text.isEmpty ? 0 : double.parse(_inputH2O4.text));
    J23 = (_inputH2O5.text.isEmpty ? 0 : double.parse(_inputH2O5.text));

    H24 = H9 + H10 + H11 + H12 + H13 + H14 + H15 + H16 + H17 + H18;
    J24 = J9 + J10 + J11 + J12 + J13 + J19 + J20 + J21 + J22 + J23;
    F24 = (H24 + H24 == 0 ? 0 : J24 / (H24 + J24) * 100);

    H25 = H8 - H24;
    J25 = J8 - J24;
    F25 = (H25 + J25 == 0 ? 0 : J25 / (H25 + J25) * 100);
    F26 =


    H5 = (H5 * 10.0).roundToDouble() / 10;
    H6 = (H6 * 10.0).roundToDouble() / 10;
    H7 = (H7 * 10.0).roundToDouble() / 10;
    H8 = (H8 * 10.0).roundToDouble() / 10;
    H9 = (H9 * 10.0).roundToDouble() / 10;
    H10 = (H10 * 10.0).roundToDouble() / 10;
    H11 = (H11 * 10.0).roundToDouble() / 10;
    H12 = (H12 * 10.0).roundToDouble() / 10;
    H13 = (H13 * 10.0).roundToDouble() / 10;

    J5 = (J5 * 10.0).roundToDouble() / 10;
    J6 = (J6 * 10.0).roundToDouble() / 10;
    J7 = (J7 * 10.0).roundToDouble() / 10;
    J8 = (J8 * 10.0).roundToDouble() / 10;
    J9 = (J9 * 10.0).roundToDouble() / 10;
    J10 = (J10 * 10.0).roundToDouble() / 10;
    J11 = (J11 * 10.0).roundToDouble() / 10;
    J12 = (J12 * 10.0).roundToDouble() / 10;
    J13 = (J13 * 10.0).roundToDouble() / 10;

    F24 = (F24 * 100.0).roundToDouble() / 100;

    F26 = (_currentIPA.text.isEmpty ? 0 : double.parse(_currentIPA.text));

    bool overMoisture = F26 > F25 ? true : false;
    bool overIPA = H25 < -2 ? true : false;
    bool overH2O = J25 < -2 ? true : false;
    X16 = overMoisture;
    X17 = overMoisture;
    Y11 = overIPA;
    Y12 = overIPA;
    Y13 = overIPA;
    Y14 = overIPA;
    Y15 = overIPA;
    Y16 = overIPA;
    Y17 = overIPA;
    Z11 = overH2O;
    Z12 = overH2O;
    Z13 = overH2O;
    Z14 = overH2O;
    Z15 = overH2O;
    Z16 = overH2O;
    Z17 = overH2O;

    O15 = (H25 + J25).floor().toDouble();


    AA11 = ((F8 - F24).abs() < 0.09 ? true : false);
    AA12 = ((F8 - F24).abs() < 0.09 ? true : false);
    AA15 = ((F25 - F26).abs() < 0.09 ? true : false);
    AB11 = (Q11 < 5 ? false : true);



    setState(() {

    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    _baseIPA1.addListener(_calculateValue);
    _baseMoisture1.addListener(_calculateValue);
    _baseIPA2.addListener(_calculateValue);
    _baseMoisture2.addListener(_calculateValue);
    _baseIPA3.addListener(_calculateValue);
    _baseMoisture3.addListener(_calculateValue);

    _inputIPA1.addListener(_calculateValue);
    _inputIPA2.addListener(_calculateValue);
    _inputIPA3.addListener(_calculateValue);
    _inputIPA4.addListener(_calculateValue);
    _inputIPA5.addListener(_calculateValue);
    _inputMoisture1.addListener(_calculateValue);
    _inputMoisture2.addListener(_calculateValue);
    _inputMoisture3.addListener(_calculateValue);
    _inputMoisture4.addListener(_calculateValue);
    _inputMoisture5.addListener(_calculateValue);

    _newIPA1.addListener(_calculateValue);
    _newIPA2.addListener(_calculateValue);
    _newIPA3.addListener(_calculateValue);
    _newIPA4.addListener(_calculateValue);
    _newIPA5.addListener(_calculateValue);
    _inputH2O1.addListener(_calculateValue);
    _inputH2O2.addListener(_calculateValue);
    _inputH2O3.addListener(_calculateValue);
    _inputH2O4.addListener(_calculateValue);
    _inputH2O5.addListener(_calculateValue);

    double Width1 = 60;
    double Width2 = 110;
    double Width3 = 60;
    double Width4 = 50;
    double Width5 = 70;
    double Width6 = 50;

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('IPA Error'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: Width1,
                    ),
                    SizedBox(
                      width: Width2,
                      child: const Center(
                        child: Text('항목'),
                      ),
                    ),
                    SizedBox(
                      width: Width3,
                      child: const Center(
                        child: Text('정제IPA'),
                      ),
                    ),
                    SizedBox(
                      width: Width4,
                      child: const Center(
                        child: Text('수분'),
                      ),
                    ),
                    SizedBox(
                      width: Width5,
                      child: const Center(
                        child: Text('순IPA'),
                      ),
                    ),
                    SizedBox(
                      width: Width6,
                      child: const Center(
                        child: Text('순H2O'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView (
                    child: Column(
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
                              Container(
                                width: Width1,
                                child: const Center(
                                  child: Text('기준'),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('목표값1'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseIPA1,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseMoisture1,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H5'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J5'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('목표값2'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseIPA2,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseMoisture2,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H6'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J6'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('목표값3'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseIPA3,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseMoisture3,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H7'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J7'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('목표합'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: Text('$D8'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: Text('$F8'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H8'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J8'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
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
                              SizedBox(
                                width: Width1,
                                child: const Center(
                                  child: Text('투입기록'),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('정제IPA 투입1'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputIPA1,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputMoisture1,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H9'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J9'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('정제IPA 투입2'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputIPA2,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputMoisture2,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H10'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J10'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('정제IPA 투입3'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputIPA3,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputMoisture3,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H11'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J11'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('정제IPA 투입4'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputIPA4,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputMoisture4,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H12'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J12'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('정제IPA 투입5'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputIPA5,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _inputMoisture5,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H13'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J13'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('새IPA 투입1'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('새IPA 투입2'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('새IPA 투입3'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('새IPA 투입4'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('새IPA 투입5'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('H2O 투입1'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('H2O 투입2'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('H2O 투입3'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('H2O 투입4'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Width2,
                                            child: Center(
                                              child: Text('H2O 투입5'),
                                            ),
                                          ),
                                          Container(
                                            width: Width3,
                                          ),
                                          Container(
                                            width: Width4,
                                          ),
                                          Container(
                                            width: Width5,
                                            child: Center(
                                            ),
                                          ),
                                          Container(
                                            width: Width6,
                                            child: TextField(
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
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
                              Container(
                                width: Width1,
                                child: const Center(
                                  child: Text('현황'),
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('투입총량'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: Text('$F24'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H24'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J24'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('투입필요량'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: Text('$F25'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                            child: Center(
                                              child: Text('$H25'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width6,
                                            child: Center(
                                              child: Text('$J25'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Width2,
                                            child: const Center(
                                              child: Text('현재 정제IPA 수분'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width3,
                                          ),
                                          SizedBox(
                                            width: Width4,
                                            child: Center(
                                              child: TextField(
                                                controller: _baseMoisture3,
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Width5,
                                          ),
                                          SizedBox(
                                            width: Width6,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        const Padding(
                            padding: EdgeInsets.only(top: 10)
                        ),

                        const Padding(
                            padding: EdgeInsets.only(top: 10)
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('계산')
                ),
             ]
          ),
        ),
      );
  }
}
