part of 'pay_bloc.dart';

@immutable
class PayState {

  final double amountToPay;
  final String currency;
  final bool isCardActivate;
  final CustomCreditCard? card;

  String get amountToPayToString => '${(amountToPay * 100).floor()}';

  const PayState({
    this.amountToPay = 100.0, 
    this.currency = 'DOP', 
    this.isCardActivate = false, 
    this.card
  });

  PayState copyWith({
    double? amountToPay,
    String? currency,
    bool? isCardActivate,
    CustomCreditCard? card    
  }) => PayState(
    amountToPay: amountToPay ?? this.amountToPay,
    currency: currency ?? this.currency,
    isCardActivate: isCardActivate ?? this.isCardActivate,
    card: card ?? this.card
  );

}

