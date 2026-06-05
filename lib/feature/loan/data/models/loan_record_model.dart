import '../../domain/entity/loan_record.dart';
import '../../domain/enum/eligibility_status.dart';

class LoanRecordModel extends LoanRecord {
  const LoanRecordModel({
    super.id,
    required super.loanAmount,
    required super.calculatedEmi,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loanAmount': loanAmount,
      'calculatedEmi': calculatedEmi,
      'status': status.name,
    };
  }

  factory LoanRecordModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LoanRecordModel(
      id: map['id'],
      loanAmount: map['loanAmount'],
      calculatedEmi: map['calculatedEmi'],
      status: map['status'] == 'eligible'
          ? EligibilityStatus.eligible
          : EligibilityStatus.notEligible,
    );
  }
}