import 'package:get_it/get_it.dart';

import '../domain/usecase/calculate_from_expression_use_case.dart';
import 'calculator_core.dart';

class _Injector {
  final GetIt locator = GetIt.instance;

  void init() {
    // Use Case
    locator.registerLazySingleton<CalculateFromExpressionUseCase>(() => CalculateFromExpressionUseCase(calculatorCore: locator()));

    // Calculator Core
    locator.registerLazySingleton<CalculatorCore>(() => CalculatorCore());
  }
}

// ignore: non_constant_identifier_names
final Injector = _Injector();