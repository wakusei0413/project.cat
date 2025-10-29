import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String display;
  final bool isError;

  const CalculatorDisplay({
    super.key,
    required this.display,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Text(
            display,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: isError
                  ? colorScheme.error
                  : colorScheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
