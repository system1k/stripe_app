part of 'pay_bloc.dart';

@immutable
class PayState {

  final double amountToPay;
  final String coin;
  final bool isCardActivate;
  final CustomCreditCard? card;

  const PayState({
    this.amountToPay = 100.0, 
    this.coin = 'DOP', 
    this.isCardActivate = false, 
    this.card
  });

  PayState copyWith({
    double? amountToPay,
    String? coin,
    bool? isCardActivate,
    CustomCreditCard? card    
  }) => PayState(
    amountToPay: amountToPay ?? this.amountToPay,
    coin: coin ?? this.coin,
    isCardActivate: isCardActivate ?? this.isCardActivate,
    card: card ?? this.card
  );

}

