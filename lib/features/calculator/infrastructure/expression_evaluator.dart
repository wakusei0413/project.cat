import 'package:math_expressions/math_expressions.dart';

class ExpressionEvaluator {
  String evaluate(String expression) {
    try {
      final processedExpression = _preprocessExpression(expression);
      
      if (processedExpression.isEmpty) {
        return '0';
      }

      final parser = Parser();
      final exp = parser.parse(processedExpression);
      final contextModel = ContextModel();
      final result = exp.evaluate(EvaluationType.REAL, contextModel);

      if (result.isNaN || result.isInfinite) {
        return 'Error';
      }

      if (result == result.toInt().toDouble()) {
        return result.toInt().toString();
      }

      return _formatDecimal(result);
    } catch (e) {
      return 'Error';
    }
  }

  String _preprocessExpression(String expression) {
    return expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll(',', '.');
  }

  String _formatDecimal(double value) {
    final str = value.toStringAsFixed(10);
    final parts = str.split('.');
    if (parts.length == 2) {
      final decimal = parts[1].replaceAll(RegExp(r'0+$'), '');
      if (decimal.isEmpty) {
        return parts[0];
      }
      return '${parts[0]}.${decimal}';
    }
    return str;
  }
}
