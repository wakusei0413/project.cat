import 'package:flutter/material.dart';

enum ButtonType {
  number,
  operator,
  function,
  equals,
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.number,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    Color backgroundColor;
    Color textColor;
    
    switch (type) {
      case ButtonType.operator:
        backgroundColor = colorScheme.primaryContainer;
        textColor = colorScheme.onPrimaryContainer;
        break;
      case ButtonType.function:
        backgroundColor = colorScheme.secondaryContainer;
        textColor = colorScheme.onSecondaryContainer;
        break;
      case ButtonType.equals:
        backgroundColor = colorScheme.primary;
        textColor = colorScheme.onPrimary;
        break;
      case ButtonType.number:
      default:
        backgroundColor = colorScheme.surfaceContainerHighest;
        textColor = colorScheme.onSurface;
    }

    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
