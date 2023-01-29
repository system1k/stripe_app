import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_app/models/custom_credit_cards.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super(const PayState()) {
    on<PayEvent>((event, emit) {

      if(event is OnSelectCard) {
        emit(state.copyWith(isCardActivate: true, card: event.card));
      } else if (event is OnDesactivateCard) {
        emit(state.copyWith(isCardActivate: false));
      }
      
    });
  }
}
