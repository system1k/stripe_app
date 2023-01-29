import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/data/credit_cards.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/models/custom_credit_cards.dart';
import 'package:stripe_app/pages/pages.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){} 
          )
        ],
      ),
      body: Stack(
        children: [

          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: const _ShowCreditCardsList()
          ),

          const Positioned(
            bottom: 0,
            child: TotalPayButton()
          )

        ],
      )
    );
  }
}

class _ShowCreditCardsList extends StatelessWidget {
  const _ShowCreditCardsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.9
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: cards.length,
      itemBuilder: ( _, index) {

        final card = cards[index];

        return GestureDetector(
          onTap: () {
            context.read<PayBloc>().add(OnSelectCard(card));
            Navigator.push(context, navegateFadeIn( context, const CardPage() ));
          },
          child: _CreditCardList(card: card),
        );

      }
    );
  }
}

class _CreditCardList extends StatelessWidget {
  
  final CustomCreditCard card;
  
  const _CreditCardList({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: card.cardNumber,
      child: CreditCardWidget(
        cardNumber: card.cardNumberHidden, 
        expiryDate: card.expiracyDate, 
        cardHolderName: card.cardHolderName, 
        cvvCode: card.cvv, 
        showBackView: false, 
        onCreditCardWidgetChange: (creditCardBrand){}
      ),
    );
  }
}