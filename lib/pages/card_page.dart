import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_app/models/custom_credit_cards.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final card = CustomCreditCard(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Julio Fermin'
    );
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagar')
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          Hero(
            tag: card.cardNumber,
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