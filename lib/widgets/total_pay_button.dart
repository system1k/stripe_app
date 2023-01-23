import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              Text('\$ 250', style: TextStyle(fontSize: 20))
            ],
          ),

          const _PayButton()

        ]
      )
    );
  }
}

class _PayButton extends StatelessWidget {
  const _PayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return true 
      ? buildCreditCardPayButton(context) 
      : buildAppleAndGooglePayButton(context);
  }

  Widget buildCreditCardPayButton(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: const [

          Icon(FontAwesomeIcons.creditCard, color: Colors.white),

          Text('   Pay', style: TextStyle(color: Colors.white, fontSize: 22))
          
        ],
      ),
      onPressed: (){}
    );
  }

  Widget buildAppleAndGooglePayButton(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [

          Icon(
            Platform.isAndroid
              ? FontAwesomeIcons.google
              : FontAwesomeIcons.apple,
            color: Colors.white
          ),

          const Text(' Pay', style: TextStyle(color: Colors.white, fontSize: 22))
          
        ],
      ),
      onPressed: (){}
    );
  }
}