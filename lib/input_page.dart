import 'dart:math';

import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedGender = 0, height = 170, age = 23, weight = 65;
  double bmi = 0;
  bool isShown=false;

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 159, 147, 147),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 199, 219, 236),
          centerTitle: true,
          title: const Text("BMI Calculator",style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
        ),
        body: buildUI(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
             isShown=true;
            setState(() {
              bmi = weight / pow(height / 100, 2);
            });

            await Future.delayed(Duration(seconds: 2)).then((value) {
              setState(() {
                isShown=false;
              });
            });
          },
          child: const Icon(
            Icons.calculate,
          ),
        ),
      ),
    );
  }

  Widget buildUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        genderSelector(),
        heightInput(),
        weightAndAgeInputRow(),
        bmiResult(),
       if(isShown) bmiadvice(),
        const SizedBox(height: 35,)
      ],
    );
  }

  Widget genderSelector() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            15,
          )),
      margin: const EdgeInsets.all(
        18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    selectedGender = 0;
                  });
                },
                icon: Icon(
                  Icons.male,
                  color: selectedGender == 0
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                ),
              ),
              const Text(
                "Male",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                iconSize: 60,
                onPressed: () {
                  setState(() {
                    selectedGender = 1;
                  });
                },
                icon: Icon(
                  Icons.female,
                  color: selectedGender == 1
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black,
                ),
              ),
              const Text(
                "Female",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget heightInput() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            15,
          )),
      margin: const EdgeInsets.all(
        18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        children: [
          const Text(
            'Height',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Slider(
            min: 0,
            max: 300,
            divisions: 300,
            value: height.toDouble(),
            onChanged: (value) {
              setState(
                () {
                  height = value.toInt();
                },
              );
            },
          ),
          Text(
            "$height cm",
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget weightAndAgeInputRow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        weightInput(),
        ageInput(),
      ],
    );
  }

  Widget weightInput() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            15,
          )),
      margin: const EdgeInsets.all(
        18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          const Text(
            'Weight',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          ItemCount(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              buttonSizeHeight: 30,
              buttonSizeWidth: MediaQuery.of(context).size.width * .13,
              initialValue: weight,
              minValue: 40,
              maxValue: 400,
              onChanged: (value) {
                setState(() {
                  weight = value.toInt();
                });
              },
              decimalPlaces: 0)
        ],
      ),
    );
  }

  Widget ageInput() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            15,
          )),
      margin: const EdgeInsets.all(
        18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          const Text(
            'Age',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          ItemCount(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              buttonSizeHeight: 30,
              buttonSizeWidth: MediaQuery.of(context).size.width * .13,
              initialValue: age,
              minValue: 1,
              maxValue: 120,
              onChanged: (value) {
                setState(() {
                  age = value.toInt();
                });
              },
              decimalPlaces: 0)
        ],
      ),
    );
  }

  Widget bmiResult() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(
            15,
          )),
      margin: const EdgeInsets.all(
        18.0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Text(
        'BMI: ${bmi.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bmiadvice() {
    return Container(
      child: (bmi >= 18 && bmi <= 25)
          ? Text(
              'You are perfectly healthy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text('You need to maintain yourself',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
    );
  }
  
}


void demo() async {
 await Future.delayed(Duration(seconds: 3)).then((value) {
    print('Ths is demo');
  });
}