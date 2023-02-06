import 'package:dio/dio.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';

class StripeServices {

  StripeServices._privateConstructor();
  static final StripeServices _instance = StripeServices._privateConstructor();
  factory StripeServices() => _instance;

  final _paymentApiUrl = 'https://api.stripe.com/v1/payments_intent';
  final _apiKey    = 'pk_test_51MXtFTDpIKmT4bNhgnBH3QcVHBkU8FRpbuUcPhrEtmQyD1YSbkJgBs90N8RgobiHjDlQSy2J1jClEFS6GdU6Mgxs00Jws6QvaC';
  static const _secretKey = 'sk_test_51MXtFTDpIKmT4bNhubYL7sDFygFeIHahiLr1wy99xbzjsTJ7nfgidX8ZxiJZHlAkPHCZo7LTHEvr9C1m0bQI2UsH00JoClI3LF';
  
  final headerOptions = Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      'Authorization' : 'Bearer $_secretKey'
    }
  );

  void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: _apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      )
    );
  }

  Future payWithExistingCard({
    required String amount,
    required String currency,
    required CreditCard card
  }) async {

    try {

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );

      final resp = await _makePayment(
        amount: amount, 
        currency: currency, 
        paymentMethod: paymentMethod
      );
      
      return resp;     
            
    } catch (error) {
      return StripeCustomResponse(
        ok: false,
        msg: error.toString()
      );      
    }    

  }  

  Future<StripeCustomResponse> payWithNewCard({
    required String amount,
    required String currency
  }) async {

    try {

      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      final resp = await _makePayment(
        amount: amount, 
        currency: currency, 
        paymentMethod: paymentMethod
      );
      
      return resp;     
            
    } catch (error) {
      return StripeCustomResponse(
        ok: false,
        msg: error.toString()
      );      
    }

  }  

  Future payWithAppleOrGoogle({
    required String amount,
    required String currency
  }) async {

    try {

      final newAmount = double.parse(amount) / 100;

      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency, 
          totalPrice: amount
        ), 
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'US',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Producto',
              amount: '$newAmount'
            )
          ]
        )
      );

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId
          )
        )
      );

      final resp = await _makePayment(
        amount: amount, 
        currency: currency, 
        paymentMethod: paymentMethod
      );

      await StripePayment.completeNativePayRequest();
      
      return resp;
      
    } catch (error) {
      return StripeCustomResponse(
        ok: false,
        msg: error.toString()
      );
    }

  }  
  
  Future _createPaymentIntent({
    required String amount,
    required String currency
  }) async {

    try {

      final dio = Dio();
      final data = {
        'amount' : amount,
        'currency' : currency
      };

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headerOptions
      );

      return PaymentIntentResponse.fromJson(resp.data);
      
    } catch (error) {
      return PaymentIntentResponse(status: '400');
    }
  }  

  Future _makePayment({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod
  }) async {

    try {

      final paymentIntent = await _createPaymentIntent(
        amount: amount, 
        currency: currency
      );  

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id
        )
      );

      if(paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: true);
      } else {
        return StripeCustomResponse(
          ok: false, 
          msg: 'Fallo: ${paymentResult.status}'
        );
      } 

    } catch (error) {

      return StripeCustomResponse(
        ok: false,
        msg: error.toString()
      );   
               
    }

  }  

}