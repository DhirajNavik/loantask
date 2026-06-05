import '../enum/eligibility_status.dart';

class LoanRecord {
  final int? id;
  final String timestamp;
  final double income;
  final double existingEmi;
  final double loanAmount;
  final int tenure;
  final String employmentType;
  final double calculatedEmi;
  final EligibilityStatus status;

  const LoanRecord({
    this.id,
    required this.timestamp,
    required this.income,
    required this.existingEmi,
    required this.loanAmount,
    required this.tenure,
    required this.employmentType,
    required this.calculatedEmi,
    required this.status,
  });
}
