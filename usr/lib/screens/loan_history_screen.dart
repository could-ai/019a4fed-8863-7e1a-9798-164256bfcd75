import 'package:flutter/material.dart';

class LoanHistoryScreen extends StatefulWidget {
  const LoanHistoryScreen({super.key});

  @override
  State<LoanHistoryScreen> createState() => _LoanHistoryScreenState();
}

class _LoanHistoryScreenState extends State<LoanHistoryScreen> {
  // Mock data for loan history
  final List<Map<String, dynamic>> _loans = [
    {
      'id': '1',
      'type': 'Personal',
      'amount': 5000.0,
      'status': 'Approved',
      'date': '2024-01-15',
      'remainingBalance': 3500.0,
    },
    {
      'id': '2',
      'type': 'Business',
      'amount': 10000.0,
      'status': 'Active',
      'date': '2023-11-20',
      'remainingBalance': 7500.0,
    },
    {
      'id': '3',
      'type': 'Home',
      'amount': 250000.0,
      'status': 'Paid Off',
      'date': '2022-05-10',
      'remainingBalance': 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Loan History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _loans.length,
                itemBuilder: (context, index) {
                  final loan = _loans[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                loan['type'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: loan['status'] == 'Approved' ? Colors.green[100] :
                                         loan['status'] == 'Active' ? Colors.blue[100] :
                                         Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  loan['status'],
                                  style: TextStyle(
                                    color: loan['status'] == 'Approved' ? Colors.green[800] :
                                           loan['status'] == 'Active' ? Colors.blue[800] :
                                           Colors.grey[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Amount: \$${loan['amount'].toStringAsFixed(2)}'),
                          Text('Date: ${loan['date']}'),
                          Text('Remaining Balance: \$${loan['remainingBalance'].toStringAsFixed(2)}'),
                          if (loan['status'] == 'Active') ...[
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to payment screen
                                Navigator.pushNamed(context, '/payment', arguments: loan);
                              },
                              child: const Text('Make Payment'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}