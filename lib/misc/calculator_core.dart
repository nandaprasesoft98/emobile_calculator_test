import 'package:function_tree/function_tree.dart';

import 'load_data_result.dart';

class CalculatorCore {
  LoadDataResult<num> execute(String expression) {
    try {
      return SuccessLoadDataResult<num>(value: expression.interpret());
    } catch (e) {
      return FailedLoadDataResult<num>(e: e);
    }
  }
}