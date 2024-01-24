import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp es el widget principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyCalculator(),
    );
  }
}

// MyCalculator es el widget principal de la calculadora.
class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key}) : super(key: key);

  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

// _MyCalculatorState es el estado de la calculadora.
class _MyCalculatorState extends State<MyCalculator> {
  String _currentNumber = '0';  // Número de entrada actual
  String _operator = '';         // Operador actual
  double _result = 0.0;          // Resultado de los cálculos

  // Maneja los toques en los botones de números.
  void _handleNumberTap(String number) {
    setState(() {
      if (_currentNumber == '0') {
        _currentNumber = number;
      } else {
        _currentNumber += number;
      }
    });
  }

  // Maneja los toques en los botones de operadores.
  void _handleOperatorTap(String operator) {
    setState(() {
      _operator = operator;
      _result = double.parse(_currentNumber);
      _currentNumber = '0';
    });
  }

  // Maneja el toque en el botón de limpiar (C).
  void _handleClear() {
    setState(() {
      _currentNumber = '0';
      _operator = '';
      _result = 0.0;
    });
  }

  // Maneja el toque en el botón de igual (=) y realiza cálculos.
  void _handleCalculate() {
    switch (_operator) {
      case '+':
        _result += double.parse(_currentNumber);
        break;
      case '-':
        _result -= double.parse(_currentNumber);
        break;
      case '*':
        _result *= double.parse(_currentNumber);
        break;
      case '/':
        _result /= double.parse(_currentNumber);
        break;
    }
    setState(() {
      _currentNumber = _result.toString();
      _operator = '';
    });
  }

  // Construye la interfaz de usuario de la calculadora.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pantalla para el número de entrada actual.
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _currentNumber,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 48.0),
                ),
              ),
            ),
          ),
          // Cuadrícula para los botones de números y operadores.
          Expanded(
            flex: 3,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                // Botones de números
                for (int i = 1; i <= 9; i++)
                  _buildNumberButton(i.toString()),
                _buildNumberButton('0'),
                // Botones de operadores
                _buildOperatorButton('+'),
                _buildOperatorButton('-'),
                _buildOperatorButton('*'),
                _buildOperatorButton('/'),
                // Botones de acción
                _buildActionButton('C'),
                _buildActionButton('='),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para construir botones de números.
  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () => _handleNumberTap(number),
      child: Text(
        number,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }

  // Método auxiliar para construir botones de operadores.
  Widget _buildOperatorButton(String operator) {
    return TextButton(
      onPressed: () => _handleOperatorTap(operator),
      child: Text(
        operator,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }

  // Método auxiliar para construir botones de acción (limpiar e igual).
  Widget _buildActionButton(String label) {
    return TextButton(
      onPressed: label == 'C' ? _handleClear : _handleCalculate,
      child: Text(
        label,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
