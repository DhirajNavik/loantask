import '../../domain/entity/loan_record.dart';
import '../../domain/enum/eligibility_status.dart';

class LoanRecordModel extends LoanRecord {
  const LoanRecordModel({
    super.id,
    required super.timestamp,
    required super.income,
    required super.existingEmi,
    required super.loanAmount,
    required super.tenure,
    required super.employmentType,
    required super.calculatedEmi,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'income': income,
      'existingEmi': existingEmi,
      'loanAmount': loanAmount,
      'tenure': tenure,
      'employmentType': employmentType,
      'calculatedEmi': calculatedEmi,
      'status': status.name,
    };
  }

  factory LoanRecordModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LoanRecordModel(
      id: map['id'],
      timestamp: map['timestamp'],
      income: map['income'],
      existingEmi: map['existingEmi'],
      loanAmount: map['loanAmount'],
      tenure: map['tenure'],
      employmentType: map['employmentType'],
      calculatedEmi: map['calculatedEmi'],
      status: map['status'] == 'eligible'
          ? EligibilityStatus.eligible
          : EligibilityStatus.notEligible,
    );
  }
}