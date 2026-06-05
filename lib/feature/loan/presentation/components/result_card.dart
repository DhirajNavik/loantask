import 'package:flutter/material.dart';
import 'package:loantask/feature/loan/domain/enum/eligibility_status.dart';

class ResultCard extends StatelessWidget {
  final double emi;
  final double totalPayable;
  final double totalInterest;
  final EligibilityStatus status;

  const ResultCard({
    super.key,
    required this.emi,
    required this.totalPayable,
    required this.totalInterest,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isEligible = status == EligibilityStatus.eligible;

    return Card(
      color: isEligible ? Colors.green.shade100 : Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('EMI : ₹${emi.toStringAsFixed(2)}'),
            Text('Total Payable : ₹${totalPayable.toStringAsFixed(2)}'),
            Text('Interest : ₹${totalInterest.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            Text(isEligible ? 'Eligible' : 'EMI exceeds 50% of your income'),
          ],
        ),
      ),
    );
  }
}
