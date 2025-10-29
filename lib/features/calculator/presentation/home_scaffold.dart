import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/calculator_notifier.dart';
import 'calculator_button.dart';
import 'calculator_display.dart';

class HomeScaffold extends ConsumerWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorProvider);
    final notifier = ref.read(calculatorProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CalculatorDisplay(
                display: state.display,
                isError: state.isError,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        _buildButtonRow([
                          _buildButton('C', () => notifier.clear(),
                              ButtonType.function),
                          _buildButton('( )', () {}, ButtonType.function),
                          _buildButton('%', () => notifier.appendOperator('%'),
                              ButtonType.function),
                          _buildButton('÷', () => notifier.appendOperator('÷'),
                              ButtonType.operator),
                        ]),
                        _buildButtonRow([
                          _buildButton(
                              '7', () => notifier.appendNumber('7')),
                          _buildButton(
                              '8', () => notifier.appendNumber('8')),
                          _buildButton(
                              '9', () => notifier.appendNumber('9')),
                          _buildButton('×', () => notifier.appendOperator('×'),
                              ButtonType.operator),
                        ]),
                        _buildButtonRow([
                          _buildButton(
                              '4', () => notifier.appendNumber('4')),
                          _buildButton(
                              '5', () => notifier.appendNumber('5')),
                          _buildButton(
                              '6', () => notifier.appendNumber('6')),
                          _buildButton('-', () => notifier.appendOperator('-'),
                              ButtonType.operator),
                        ]),
                        _buildButtonRow([
                          _buildButton(
                              '1', () => notifier.appendNumber('1')),
                          _buildButton(
                              '2', () => notifier.appendNumber('2')),
                          _buildButton(
                              '3', () => notifier.appendNumber('3')),
                          _buildButton('+', () => notifier.appendOperator('+'),
                              ButtonType.operator),
                        ]),
                        _buildButtonRow([
                          _buildButton('⌫', () => notifier.delete(),
                              ButtonType.function),
                          _buildButton(
                              '0', () => notifier.appendNumber('0')),
                          _buildButton(
                              '.', () => notifier.appendNumber('.')),
                          _buildButton('=', () => notifier.calculate(),
                              ButtonType.equals),
                        ]),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<Widget> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((button) => Expanded(child: button))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      [ButtonType type = ButtonType.number]) {
    return CalculatorButton(
      text: text,
      onPressed: onPressed,
      type: type,
    );
  }
}
