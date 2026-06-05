import '../enum/eligibility_status.dart';

class LoanRecord {
  final int? id;
  final double loanAmount;
  final double calculatedEmi;
  final EligibilityStatus status;

  const LoanRecord({
    this.id,
    required this.loanAmount,
    required this.calculatedEmi,
    required this.status,
  });
}
