import 'package:flutter/material.dart';

class CounterStateful extends StatefulWidget {
  Color buttonColor;

  CounterStateful({Key? key,required this.buttonColor}):super(key: key);


  @override
  State<CounterStateful> createState() {
    State<CounterStateful> stateClassAssociatedWithThisWidget =
        _CounterStatefulState();
    return stateClassAssociatedWithThisWidget;
  }
}

class _CounterStatefulState extends State<CounterStateful> {

  int counter=-0;




  void increment()
  {
    setState(() {
      counter++;
    });

    print(counter);
  }

  void decrement()
  {
    setState(() {
      counter--;
    });

    print(counter);
  }


  void reset()
  {
    setState(() {
      counter=0;
    });

    print(counter);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: widget.buttonColor,
            child: Icon(Icons.add),
            onPressed: () { increment(); },
          ),
          SizedBox(width: 16), // Adding some space between the buttons
          FloatingActionButton(
            child: Icon(Icons.exposure_minus_1),
            onPressed: () { decrement(); },
          ),
          SizedBox(width: 16), // Adding some space between the buttons
          FloatingActionButton(
            child: Icon(Icons.lock_reset),
            onPressed: () { reset(); },
          ),
        ],
      ),
      body: Center(
        child: Text(
          '$counter',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }

}
