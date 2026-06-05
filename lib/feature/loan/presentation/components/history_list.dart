import 'package:flutter/material.dart';
import '../../domain/entity/loan_record.dart';

class HistoryList extends StatelessWidget {
  final List<LoanRecord> history;

  const HistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Text("No History Available");
    }
    return Column(
      children: history
          .map(
            (item) => ListTile(
              leading: CircleAvatar(
                radius: 15,
                child: Text(item.id.toString()),
              ),
              contentPadding: EdgeInsets.only(bottom: 10),
              minVerticalPadding: 0,
              minTileHeight: 0,
              isThreeLine: true,
              title: Text('Loan ₹${item.loanAmount.toStringAsFixed(0)}'),
              subtitle: Text(
                'EMI ₹${item.calculatedEmi.toStringAsFixed(2)}',
              ),
              trailing: Text(item.status.name.toUpperCase()),
            ),
          )
          .toList(),
    );
  }
}
