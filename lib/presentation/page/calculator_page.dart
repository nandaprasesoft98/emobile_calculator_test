import 'package:emobile_calculator_test/domain/usecase/calculate_from_expression_use_case.dart';
import 'package:emobile_calculator_test/misc/ext/load_data_result_ext.dart';
import 'package:emobile_calculator_test/misc/injector.dart';
import 'package:emobile_calculator_test/provider/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/load_data_result.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late CalculatorProvider _calculatorProvider;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _calculatorProvider = CalculatorProvider(calculateFromExpressionUseCase: Injector.locator<CalculateFromExpressionUseCase>());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _focusNode.requestFocus());
  }

  void _updateTextField(String newText, {bool concatenated = true}) {
    TextSelection selection = _textEditingController.selection;
    String oldText = _textEditingController.text;
    int start = selection.start;

    String updatedText = concatenated ? oldText.replaceRange(start, selection.end, newText) : newText;
    TextSelection newSelection = TextSelection.fromPosition(
      TextPosition(offset: concatenated ? start + newText.length : newText.length),
    );

    setState(() {
      _textEditingController.value = _textEditingController.value.copyWith(
        text: updatedText,
        selection: newSelection,
      );
    });
  }

  void _backspace() {
    TextSelection selection = _textEditingController.selection;
    String oldText = _textEditingController.text;
    int start = selection.start;

    if (selection.isCollapsed) {
      if (start > 0) {
        String updatedText = oldText.replaceRange(start - 1, start, '');
        TextSelection newSelection = TextSelection.fromPosition(
          TextPosition(offset: start - 1),
        );

        setState(() {
          _textEditingController.value = _textEditingController.value.copyWith(
            text: updatedText,
            selection: newSelection,
          );
        });
      }
    } else {
      String updatedText = oldText.replaceRange(selection.start, selection.end, '');
      TextSelection newSelection = TextSelection.fromPosition(
        TextPosition(offset: selection.start),
      );

      setState(() {
        _textEditingController.value = _textEditingController.value.copyWith(
          text: updatedText,
          selection: newSelection,
        );
      });
    }
  }

  Widget _buildButton(dynamic buttonText, Orientation orientation) {
    return Expanded(
      child: SizedBox(
        height: orientation == Orientation.portrait ? 80 : 40,
        child: ElevatedButton(
          onPressed: () {
            if (buttonText is IconData) {
              if (buttonText.codePoint == 0xe0c5) {
                _backspace();
              }
            } else if (buttonText is String) {
              if (buttonText == "=") {
                LoadDataResult<num> calculatorResultLoadDataResult = _calculatorProvider.calculateFromExpression(_textEditingController.text);
                if (calculatorResultLoadDataResult.isSuccess) {
                  num value = calculatorResultLoadDataResult.resultIfSuccess!;
                  bool hasDecimal = value != value.floorToDouble();
                  if (hasDecimal) {
                    _updateTextField(value.toString(), concatenated: false);
                  } else {
                    _updateTextField(value.toInt().toString(), concatenated: false);
                  }
                }
              } else if (buttonText == "C") {
                _updateTextField("", concatenated: false);
              } else {
                _updateTextField(buttonText);
              }
            }
          },
          child: buttonText is String ? Text(
            buttonText,
            style: TextStyle(fontSize: orientation == Orientation.portrait ? 20 : 16),
          ) : Icon(
            buttonText as IconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double paddingSize = 10;
    Widget horizontalSpacing() {
      return SizedBox(
        width: paddingSize
      );
    }
    Widget verticalSpacing() {
      return SizedBox(
        height: paddingSize
      );
    }
    return ChangeNotifierProvider.value(
      value: _calculatorProvider,
      child: Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, __) => Scaffold(
          appBar: AppBar(
            title: const Text('Calculator'),
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              bool isLandscape = orientation == Orientation.landscape;
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        decoration: const InputDecoration.collapsed(
                          hintText: "",
                        ),
                        textAlign: TextAlign.right,
                        focusNode: _focusNode,
                        style: TextStyle(fontSize: orientation == Orientation.portrait ? 32 : 20),
                        keyboardType: TextInputType.none, // Prevent keyboard
                        showCursor: true,
                        controller: _textEditingController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildButton('C', orientation),
                            horizontalSpacing(),
                            _buildButton('(', orientation),
                            horizontalSpacing(),
                            _buildButton(')', orientation),
                            horizontalSpacing(),
                            _buildButton('/', orientation),
                            horizontalSpacing(),
                            _buildButton('%', orientation),
                            if (isLandscape) ...[
                              horizontalSpacing(),
                              _buildButton('log', orientation),
                            ]
                          ],
                        ),
                        verticalSpacing(),
                        Row(
                          children: [
                            _buildButton('7', orientation),
                            horizontalSpacing(),
                            _buildButton('8', orientation),
                            horizontalSpacing(),
                            _buildButton('9', orientation),
                            horizontalSpacing(),
                            _buildButton('*', orientation),
                            horizontalSpacing(),
                            _buildButton('^', orientation),
                            if (isLandscape) ...[
                              horizontalSpacing(),
                              _buildButton('ln', orientation),
                            ]
                          ],
                        ),
                        verticalSpacing(),
                        Row(
                          children: [
                            _buildButton('4', orientation),
                            horizontalSpacing(),
                            _buildButton('5', orientation),
                            horizontalSpacing(),
                            _buildButton('6', orientation),
                            horizontalSpacing(),
                            _buildButton('-', orientation),
                            horizontalSpacing(),
                            _buildButton('sin', orientation),
                            if (isLandscape) ...[
                              horizontalSpacing(),
                              _buildButton('e', orientation),
                            ]
                          ],
                        ),
                        verticalSpacing(),
                        Row(
                          children: [
                            _buildButton('1', orientation),
                            horizontalSpacing(),
                            _buildButton('2', orientation),
                            horizontalSpacing(),
                            _buildButton('3', orientation),
                            horizontalSpacing(),
                            _buildButton('+', orientation),
                            horizontalSpacing(),
                            _buildButton('cos', orientation),
                            if (isLandscape) ...[
                              horizontalSpacing(),
                              _buildButton('|x|', orientation),
                            ]
                          ],
                        ),
                        verticalSpacing(),
                        Row(
                          children: [
                            _buildButton(Icons.backspace, orientation),
                            horizontalSpacing(),
                            _buildButton('0', orientation),
                            horizontalSpacing(),
                            _buildButton('.', orientation),
                            horizontalSpacing(),
                            _buildButton('=', orientation),
                            horizontalSpacing(),
                            _buildButton('tan', orientation),
                            if (isLandscape) ...[
                              horizontalSpacing(),
                              _buildButton(String.fromCharCode(0x03C6), orientation),
                            ]
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}