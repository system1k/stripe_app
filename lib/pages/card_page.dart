import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final card = BlocProvider.of<PayBloc>(context).state.card;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            context.read<PayBloc>().add(OnDesactivateCard());
            Navigator.pop(context);
          },          
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          Hero(
            tag: card!.cardNumber,
            child: CreditCardWidget(
              cardNumber: card.cardNumberHidden, 
              expiryDate: card.expiracyDate, 
              cardHolderName: card.cardHolderName, 
              cvvCode: card.cvv, 
              showBackView: false, 
              onCreditCardWidgetChange: (creditCardBrand){}
            )
          ),

          const Positioned(
            bottom: 0,
            child: TotalPayButton()
          )

        ]
      )
    );
  }
}