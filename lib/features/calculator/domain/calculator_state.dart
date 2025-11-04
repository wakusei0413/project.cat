class CalculatorState {
  final String display;
  final String expression;
  final bool isError;

  const CalculatorState({
    required this.display,
    required this.expression,
    this.isError = false,
  });

  factory CalculatorState.initial() {
    return const CalculatorState(
      display: '0',
      expression: '',
    );
  }

  CalculatorState copyWith({
    String? display,
    String? expression,
    bool? isError,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      expression: expression ?? this.expression,
      isError: isError ?? this.isError,
    );
  }
}
