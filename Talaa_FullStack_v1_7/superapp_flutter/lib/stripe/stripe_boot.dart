import 'package:flutter_stripe/flutter_stripe.dart';
Future<void> initStripe() async { const k=String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue:''); if(k.isEmpty) return; Stripe.publishableKey=k; await Stripe.instance.applySettings(); }
