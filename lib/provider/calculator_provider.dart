import 'package:emobile_calculator_test/domain/usecase/calculate_from_expression_use_case.dart';
import 'package:emobile_calculator_test/misc/load_data_result.dart';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  final CalculateFromExpressionUseCase calculateFromExpressionUseCase;

  CalculatorProvider({
    required this.calculateFromExpressionUseCase
  });

  LoadDataResult<num> calculateFromExpression(String expression) {
    return calculateFromExpressionUseCase.execute(expression);
  }
}