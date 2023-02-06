import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe_services.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final payBloc = BlocProvider.of<PayBloc>(context).state;

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
            children: [
              const Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              Text('${payBloc.amountToPay} ${payBloc.currency}', style: const TextStyle(fontSize: 20))
            ],
          ),

          BlocBuilder<PayBloc, PayState>(
            builder: (context, state) {
              return _PayButton(state: state);
            },
          )

        ]
      )
    );
  }
}

class _PayButton extends StatelessWidget {

  final PayState state;

  const _PayButton({
    Key? key, 
    required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.isCardActivate
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
      onPressed: () async {
        showLoading(context);

        final stripeServices = StripeServices();
        final payState = BlocProvider.of<PayBloc>(context).state;
        final card = payState.card;
        final monthYear = card!.expiracyDate.split('/');

        final resp = await stripeServices.payWithExistingCard(
          amount: payState.amountToPayToString, 
          currency: payState.currency, 
          card: CreditCard(
            number: card.cardNumber,
            expMonth: int.parse(monthYear[0]),
            expYear: int.parse(monthYear[1])
          )
        );

        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        if(resp.ok) {
          // ignore: use_build_context_synchronously
          showAlert(context, 'tarjeta ok', 'todo bien');
        } else {
          // ignore: use_build_context_synchronously
          showAlert(context, 'algo salio mal', resp.msg!);
        }
      }
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
      onPressed: () async {
        final stripeServices = StripeServices();
        final payState = BlocProvider.of<PayBloc>(context).state;

        final resp = await stripeServices.payWithAppleOrGoogle(
          amount: payState.amountToPayToString, 
          currency: payState.currency
        );
      }
    );
  }
}