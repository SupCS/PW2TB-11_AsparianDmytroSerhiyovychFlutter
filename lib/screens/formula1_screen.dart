import 'package:flutter/material.dart';

class Formula1Screen extends StatefulWidget {
  @override
  _Formula1ScreenState createState() => _Formula1ScreenState();
}

class _Formula1ScreenState extends State<Formula1Screen> {
  final TextEditingController inputHeatValue = TextEditingController();
  final TextEditingController inputFuelMass = TextEditingController();
  final TextEditingController inputEmissionFactor = TextEditingController();

  String result = '';

  void calculate() {
    double Q_i =
        double.tryParse(inputHeatValue.text.replaceAll(',', '.')) ?? 0.0;
    double B_i =
        double.tryParse(inputFuelMass.text.replaceAll(',', '.')) ?? 0.0;
    double k_j =
        double.tryParse(inputEmissionFactor.text.replaceAll(',', '.')) ?? 0.0;

    if (Q_i > 0 && B_i > 0 && k_j > 0) {
      double E_j = 1e-6 * k_j * Q_i * B_i;
      setState(() {
        result = "Валовий викид: ${E_j.toStringAsFixed(2)} т";
      });
    } else {
      setState(() {
        result = "Будь ласка, введіть коректні значення";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formula 1')),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  controller: inputHeatValue,
                  decoration: InputDecoration(
                      labelText: 'Q_i (теплотворна здатність)')),
              TextField(
                  controller: inputFuelMass,
                  decoration: InputDecoration(labelText: 'B_i (маса палива)')),
              TextField(
                  controller: inputEmissionFactor,
                  decoration:
                      InputDecoration(labelText: 'k_j (емісійний фактор)')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: calculate, child: Text('Розрахувати')),
              SizedBox(height: 20),
              Text(result, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
