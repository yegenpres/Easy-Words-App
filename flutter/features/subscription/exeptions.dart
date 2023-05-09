import 'package:wordsapp/architect/abstract/abstracts.dart';

abstract class SubscriptionsException extends AppException {
  @override
  String errMsg();
}

class NoInternetException extends SubscriptionsException {
  Object message;

  NoInternetException(this.message);

  @override
  String errMsg() =>
      'No internet connection to ches subscriptions status $message';
}
