import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/calculator_state.dart';
import '../infrastructure/expression_evaluator.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>(
  (ref) => CalculatorNotifier(),
);

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(CalculatorState.initial());

  final _evaluator = ExpressionEvaluator();

  void appendNumber(String number) {
    if (state.isError) {
      _clear();
    }

    final currentExpression = state.expression;
    
    if (currentExpression == '0' && number != '.') {
      state = state.copyWith(
        expression: number,
        display: number,
      );
      return;
    }

    if (number == '.' && _lastNumberHasDot()) {
      return;
    }

    final newExpression = currentExpression + number;
    state = state.copyWith(
      expression: newExpression,
      display: newExpression,
    );
  }

  void appendOperator(String operator) {
    if (state.isError) {
      _clear();
      return;
    }

    final currentExpression = state.expression;
    
    if (currentExpression.isEmpty) {
      return;
    }

    if (_isOperator(currentExpression[currentExpression.length - 1])) {
      final newExpression =
          currentExpression.substring(0, currentExpression.length - 1) +
              operator;
      state = state.copyWith(
        expression: newExpression,
        display: newExpression,
      );
      return;
    }

    final newExpression = currentExpression + operator;
    state = state.copyWith(
      expression: newExpression,
      display: newExpression,
    );
  }

  void calculate() {
    if (state.isError) {
      return;
    }

    final expression = state.expression;
    
    if (expression.isEmpty) {
      return;
    }

    if (_isOperator(expression[expression.length - 1])) {
      return;
    }

    final result = _evaluator.evaluate(expression);
    
    if (result == 'Error') {
      state = state.copyWith(
        display: result,
        isError: true,
      );
    } else {
      state = state.copyWith(
        expression: result,
        display: result,
      );
    }
  }

  void clear() {
    _clear();
  }

  void _clear() {
    state = CalculatorState.initial();
  }

  void delete() {
    if (state.isError) {
      _clear();
      return;
    }

    final currentExpression = state.expression;
    
    if (currentExpression.isEmpty || currentExpression == '0') {
      return;
    }

    if (currentExpression.length == 1) {
      state = CalculatorState.initial();
      return;
    }

    final newExpression =
        currentExpression.substring(0, currentExpression.length - 1);
    state = state.copyWith(
      expression: newExpression,
      display: newExpression,
    );
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '×' || char == '÷';
  }

  bool _lastNumberHasDot() {
    final expression = state.expression;
    
    for (int i = expression.length - 1; i >= 0; i--) {
      final char = expression[i];
      if (_isOperator(char)) {
        return false;
      }
      if (char == '.') {
        return true;
      }
    }
    return false;
  }
}
