
import '../entity/loan_record.dart';

abstract class LoanRepository {
  Future<void> saveLoan(LoanRecord loan);
  Future<List<LoanRecord>> getHistory();
}