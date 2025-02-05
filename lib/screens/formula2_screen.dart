import 'package:flutter/material.dart';

class Formula2Screen extends StatefulWidget {
  @override
  _Formula2ScreenState createState() => _Formula2ScreenState();
}

class _Formula2ScreenState extends State<Formula2Screen> {
  final TextEditingController inputHeatValue = TextEditingController(); // Q_i
  final TextEditingController inputAshContent = TextEditingController(); // A_r
  final TextEditingController inputGammaContent =
      TextEditingController(); // G_viv
  final TextEditingController inputEfficiency = TextEditingController(); // η_ЗУ
  final TextEditingController inputLightAsh = TextEditingController(); // a_вив
  final TextEditingController inputSulfurInteraction =
      TextEditingController(); // k_твS (опціональний)

  String result = '';

  void calculate() {
    double Q_i =
        double.tryParse(inputHeatValue.text.replaceAll(',', '.')) ?? -1.0;
    double A_r =
        double.tryParse(inputAshContent.text.replaceAll(',', '.')) ?? -1.0;
    double G_viv =
        double.tryParse(inputGammaContent.text.replaceAll(',', '.')) ?? -1.0;
    double efficiency =
        double.tryParse(inputEfficiency.text.replaceAll(',', '.')) ?? -1.0;
    double a_viv =
        double.tryParse(inputLightAsh.text.replaceAll(',', '.')) ?? -1.0;
    double k_tvs =
        double.tryParse(inputSulfurInteraction.text.replaceAll(',', '.')) ??
            0.0; // Опціональний параметр

    if (Q_i > 0 && A_r >= 0 && G_viv >= 0 && efficiency >= 0 && a_viv >= 0) {
      // Розрахунок показника емісії твердих частинок
      double k_tv =
          (1e6 / Q_i) * a_viv * (A_r / (100 - G_viv)) * (1 - efficiency) +
              k_tvs;

      setState(() {
        result =
            "Показник емісії твердих частинок: ${k_tv.toStringAsFixed(2)} г/ГДж";
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
      appBar: AppBar(title: Text('Formula 2')),
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
                  controller: inputAshContent,
                  decoration: InputDecoration(labelText: 'A_r (вміст золи)')),
              TextField(
                  controller: inputGammaContent,
                  decoration:
                      InputDecoration(labelText: 'G_viv (вміст летючих)')),
              TextField(
                  controller: inputEfficiency,
                  decoration:
                      InputDecoration(labelText: 'η_ЗУ (ефективність)')),
              TextField(
                  controller: inputLightAsh,
                  decoration:
                      InputDecoration(labelText: 'a_вив (летюча зола)')),
              TextField(
                  controller: inputSulfurInteraction,
                  decoration: InputDecoration(
                      labelText: 'k_твS (сірчисті сполуки, опціонально)')),
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
