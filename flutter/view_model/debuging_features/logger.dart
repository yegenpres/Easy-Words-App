import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:l/l.dart';

void Function(Object) lv6 = (Object log) {};

class Logger extends ProviderObserver {
  static void logger(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    lv6 = l.v6;

    lv6('''
    
    
-----------------------${provider.name ?? provider.runtimeType} ---------------------------
------------------------previousValue------------------------------------------------------
${previousValue.toString()}
-------------------------------------------------------------------------------------------
++++++++++++++++++++++++NewValue+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
${newValue.toString()}  
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


''');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    logger(provider, null, value, container);
    super.didAddProvider(provider, value, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logger(provider, previousValue, newValue, container);
  }
}
