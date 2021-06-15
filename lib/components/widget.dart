import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:intl/intl.dart';

class TaskCardWidget extends StatefulWidget {
  final String title;
  final String desc;


  TaskCardWidget({this.title, this.desc});

  @override
  _TaskCardWidgetState createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {

  bool status = false;
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);



    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.deepPurpleAccent, width: 2,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text(
                widget.title ?? "(Unnamed Task)",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                  width:20
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(color: Colors.black, fontSize: 12,fontStyle:FontStyle.italic, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ':',style: TextStyle(color: Colors.black45, fontSize: 14,),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(color:  Colors.black, fontSize: 12,fontStyle:FontStyle.italic,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ] ,
          ),


          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(
                  widget.desc ?? "No Description Added",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),

                CustomSwitch(
                  activeColor: Colors.deepPurple,
                  value: status,
                  onChanged: (value){
                    print("VALUE: $value");
                    setState(() {
                      status = value;
                    });
                  },
                ),
              ] ,
            ),
          )
        ],
      ),
    );
  }
}

class TodoWidget extends StatefulWidget {
  final String text;
  final bool isDone;

  TodoWidget({this.text, @required this.isDone});

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(

            width: 30.0,
            height: 30.0,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: widget.isDone ? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: widget.isDone ? null : Border.all(
                    color: Color(0xFF86829D),
                    width: 1.5
                )
            ),
          ),
          Flexible(
            child: Text(
              widget.text ?? "(Unnamed Todo)",
              style: TextStyle(
                color: widget.isDone ? Color(0xFF211551) : Colors.purple,
                fontSize: 18.0,
                fontWeight: widget.isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}