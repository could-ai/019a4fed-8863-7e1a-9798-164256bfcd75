import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalculatorScreen extends StatefulWidget {
  const LoanCalculatorScreen({super.key});

  @override
  State<LoanCalculatorScreen> createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  final _principalController = TextEditingController();
  final _rateController = TextEditingController(text: '5.0');
  final _termController = TextEditingController(text: '12');

  double _monthlyPayment = 0.0;
  double _totalPayment = 0.0;
  double _totalInterest = 0.0;

  void _calculateLoan() {
    final principal = double.tryParse(_principalController.text) ?? 0.0;
    final rate = double.tryParse(_rateController.text) ?? 0.0;
    final term = int.tryParse(_termController.text) ?? 0;

    if (principal > 0 && rate > 0 && term > 0) {
      final monthlyRate = rate / 100 / 12;
      final monthlyPayment = principal * 
          (monthlyRate * pow(1 + monthlyRate, term)) / 
          (pow(1 + monthlyRate, term) - 1);
      
      setState(() {
        _monthlyPayment = monthlyPayment;
        _totalPayment = monthlyPayment * term;
        _totalInterest = _totalPayment - principal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Loan Calculator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _principalController,
              decoration: const InputDecoration(
                labelText: 'Loan Amount',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateLoan(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateController,
              decoration: const InputDecoration(
                labelText: 'Annual Interest Rate (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateLoan(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _termController,
              decoration: const InputDecoration(
                labelText: 'Loan Term (months)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateLoan(),
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Payment Summary',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Monthly Payment:'),
                        Text('\$${_monthlyPayment.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Payment:'),
                        Text('\$${_totalPayment.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Interest:'),
                        Text('\$${_totalInterest.toStringAsFixed(2)}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _principalController.dispose();
    _rateController.dispose();
    _termController.dispose();
    super.dispose();
  }
}