import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _amountController = TextEditingController();
  Map<String, dynamic>? _loan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loan = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  }

  void _makePayment() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0 && _loan != null) {
      // Mock payment processing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment of \$${amount.toStringAsFixed(2)} processed successfully!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid payment amount')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loan == null) {
      return const Scaffold(
        body: Center(child: Text('No loan selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_loan!['type']} Loan Payment',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Loan Amount: \$${_loan!['amount'].toStringAsFixed(2)}'),
                    Text('Remaining Balance: \$${_loan!['remainingBalance'].toStringAsFixed(2)}'),
                    Text('Status: ${_loan!['status']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Payment Amount',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _makePayment,
              child: const Text('Process Payment'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}