import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }


}

class HomeState extends State {
  final TextEditingController _ageController  = new TextEditingController();
  final TextEditingController _heightController  = new TextEditingController();
  final TextEditingController _weightController  = new TextEditingController();
   double inches = 0.0;
  double result = 0.0;//BMI result initiaalization
  String _resultReading = "";//string to check for normal,overweight,obese after the result is evaluated
  String _finalResult = "";
  /*
  resource- eoic4health.com, bcbst.com/providers/MPM..BMICalculator
  * BMI weight status
  * Below 18,5-24.9 Normal
  * 25.0-29.9 overweight
  * 29.9 and above Obese
  *
  * */
  void _calculateBmi(){
    setState(() {
      int age = int.parse(_ageController.text);
      double height = double.parse(_heightController
          .text); //height need to be converted to inch, so we need a variable inches
      inches = height * 12; // converting feet or height to inches , height*12
      double weight = double.parse(_weightController.text);

      //validation
      if ((_ageController.text.isNotEmpty || age > 0)
          && ((_heightController.text.isNotEmpty || inches > 0)
              && (_weightController.text.isNotEmpty || weight > 0))) {
        result = weight / (inches * inches) * 703; //Our BMI
        //on the reading
        if (double.parse(result.toStringAsFixed(1)) < 18.5) {
          _resultReading = "Underweight";
          print(_resultReading);
        } else
        if (double.parse(result.toStringAsFixed(1)) >= 18.5 && result < 25) {
          _resultReading = "Great Shape";
          print(_resultReading);
        } else
        if (double.parse(result.toStringAsFixed(1)) >= 25.0 && result < 30) {
          _resultReading = "Overweight";
          print(_resultReading);
        } else if (double.parse(result.toStringAsFixed(1)) >= 30) {
          _resultReading = "Obese";
          print(_resultReading);
        }
      } else {
        result = 0.0;
      }
    });
    //to print the _resultReading on the screen, we pass it to another variable _finalResult
    _finalResult = "Your BMI: ${result.toStringAsFixed(1)}";
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("BMI"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),

      //body begins here
      //backgroundColor: Colors.white,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            new Image.asset(
              'images/bmilogo.png',
              height: 85.0,
              width: 75.0,
            ),
            new Container(
              margin: const EdgeInsets.all(3.0),
              height: 245.0,
              width: 200.0,
              color: Colors.grey.shade300,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Age',
                        hintText: 'e.g: 34',
                        icon: new Icon(Icons.person_outline)
                    ),
                  ),
                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Height in feet',
                        hintText: 'e.g: 6.5',
                        icon: new Icon(Icons.insert_chart)
                    ),
                  ),
                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: 'Weight in lbs',
                        hintText: 'e.g: 180',
                        icon: new Icon(Icons.line_weight)
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(10.6)),
                  //calculate button
                  new Container(
                    alignment: Alignment.center,
                    child: new RaisedButton(onPressed: _calculateBmi,
                      color: Colors.pinkAccent,
                      child: new Text("Calculate"),
                      textColor: Colors.white,),
                  ),
                ],
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "$_finalResult", //assigned by result variable of the BMI
                  style: new TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 19.9,
                  ),),

                new Padding(padding: const EdgeInsets.all(5.0)),
                new Text("$_resultReading",
                  //Comparison of result based on normal,underweight,Obese
                  style: new TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19.9,
                      fontStyle: FontStyle.italic,
                      color: Colors.pinkAccent
                  ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}