import 'package:stripe_app/models/custom_credit_cards.dart';

final List<CustomCreditCard> cards = [

    CustomCreditCard(
      cardNumberHidden: '4242',
      cardNumber: '4242424242424242',
      brand: 'visa',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Julio Fermin'
    ),

    CustomCreditCard(
      cardNumberHidden: '5555',
      cardNumber: '5555555555554444',
      brand: 'master card',
      cvv: '213',
      expiracyDate: '01/25',
      cardHolderName: 'Yamilka Rodriguez'
    ),

    CustomCreditCard(
      cardNumberHidden: '3782',
      cardNumber: '378282246310005',
      brand: 'american express',
      cvv: '2134',
      expiracyDate: '01/25',
      cardHolderName: 'Pamela Fermin'
    )
    
  ];
