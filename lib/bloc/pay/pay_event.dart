part of 'pay_bloc.dart';

@immutable
abstract class PayEvent {}

class OnSelectCard extends PayEvent {

  final CustomCreditCard card;
  OnSelectCard(this.card);
  
}

class OnDesactivateCard extends PayEvent {}
