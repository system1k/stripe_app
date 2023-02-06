import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/pages/pages.dart';
import 'package:stripe_app/services/stripe_services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final stripeServices = StripeServices();
    stripeServices.init();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PayBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StripeApp',
        initialRoute: 'home',
        routes: {
          'home' : (context) => HomePage(),
          'payment_completed' : (context) => const PaymentCompletedPage()
        },
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xff284879),
          scaffoldBackgroundColor: const Color(0xff21232A)
        )
      ),
    );
  }
}