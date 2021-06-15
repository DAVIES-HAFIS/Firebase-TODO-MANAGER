import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  RoundedButton({ this.colour, this.title, @required this.onPressed});
  final String title;
  final Color colour;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          //     () {
          //   //Go to registration screen.
          //   Navigator.pushNamed(context, RegistrationScreen.id);
          // },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title, style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'amatic',fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
