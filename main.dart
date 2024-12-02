import 'package:flutter/material.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  bool isMale = true;
  int weight = 70;
  int age = 23;
  double height = 170.0;
  double bmi = 0.0;
  String bmiResult = "";

  void calculateBMI() {
    double heightInMeters = height / 100;
    setState(() {
      bmi = weight / (heightInMeters * heightInMeters);
      if (bmi < 18.5) {
        bmiResult = "Underweight";
      } else if (bmi >= 18.5 && bmi < 24.9) {
        bmiResult = "Normal weight";
      } else if (bmi >= 25 && bmi < 29.9) {
        bmiResult = "Overweight";
      } else {
        bmiResult = "Obesity";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    Text(
    'BMI Calculator',
    style: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 20),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    GenderButton(
    title: 'Male',
    isSelected: isMale,
    onTap: () {
    setState(() {
    isMale = true;
    });
    },
    ),
    SizedBox(width: 10),
    GenderButton(
    title: 'Female',
    isSelected: !isMale,
    onTap: () {
    setState(() {
    isMale = false;
    });
    },
    ),
    ],
    ),
    SizedBox(height: 20),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    CounterWidget(
    label: 'Weight',
    value: weight,
    onIncrement: () {
    setState(() {
    weight++;
    });
    },
    onDecrement: () {
    setState(() {
    weight--;
    });
    },
    ),
    CounterWidget(
    label: 'Age',
    value: age,
    onIncrement: () {
    setState(() {
    age++;
    });
    },
    onDecrement: () {
    setState(() {
    age--;
    });
    },
    ),
    ],
    ),
    SizedBox(height: 20),
    TextField(
    decoration: InputDecoration(
    labelText: 'Height (cm)',
    border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    onChanged: (value) {
    height = double.tryParse(value) ?? 0.0;
    },
    ),
    SizedBox(height: 20),
    Text(
    bmi == 0.0 ? '' : bmi.toStringAsFixed(1),
    style: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
    ),
      textAlign: TextAlign.center,
    ),
      Text(
        bmiResult,
        style: TextStyle(
          fontSize: 24,
          color: Colors.blueGrey,
        ),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      ElevatedButton(
        onPressed: calculateBMI,
        child: Text('Let\'s Go'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20), backgroundColor: Colors.blue,
        ),
      ),
    ],
    ),
        ),
        ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  GenderButton({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  CounterWidget({
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove),
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}