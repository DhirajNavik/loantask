import 'package:loantask/feature/loan/data/datasource/loan_local_datasource.dart';
import 'package:loantask/feature/loan/data/models/loan_record_model.dart';
import 'package:loantask/feature/loan/domain/entity/loan_record.dart';
import '../../domain/repositories/loan_repositories.dart';

class LoanRepositoryImpl
    implements LoanRepository {
  final LoanLocalDatasource datasource;

  LoanRepositoryImpl(
    this.datasource,
  );

  @override
  Future<List<LoanRecord>> getHistory() {
    return datasource.getHistory();
  }

  @override
  Future<void> saveLoan(
    LoanRecord record,
  ) {
    return datasource.saveLoan(
      LoanRecordModel(
        id: record.id,
        timestamp: record.timestamp,
        income: record.income,
        existingEmi: record.existingEmi,
        loanAmount: record.loanAmount,
        tenure: record.tenure,
        employmentType:
            record.employmentType,
        calculatedEmi:
            record.calculatedEmi,
        status: record.status,
      ),
    );
  }
}