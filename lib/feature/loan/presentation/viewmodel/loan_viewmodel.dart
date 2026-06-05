import 'package:flutter/material.dart';
import 'package:loantask/feature/loan/data/repositories/loan_repositories_impl.dart';
import 'package:loantask/feature/loan/domain/entity/loan_record.dart';
import 'package:loantask/feature/loan/domain/enum/eligibility_status.dart';

class LoanViewModel extends ChangeNotifier {
  final LoanRepositoryImpl repository;

  LoanViewModel(this.repository);

  final incomeController = TextEditingController();
  final existingEmiController = TextEditingController(text: '0');
  final loanAmountController = TextEditingController();

  int tenure = 12;
  bool isSalaried = true;

  double emi = 0;
  double totalPayable = 0;
  double totalInterest = 0;

  EligibilityStatus? status;

  List<LoanRecord> history = [];

  bool get isFormValid {
    return incomeController.text.isNotEmpty &&
        loanAmountController.text.isNotEmpty &&
        (double.tryParse(incomeController.text) ?? 0) > 0 &&
        (double.tryParse(loanAmountController.text) ?? 0) > 0;
  }

  Future<void> loadHistory() async {
    history = await repository.getHistory();
    notifyListeners();
  }

  double _power(double value, int exponent) {
    double result = 1;

    for (int i = 0; i < exponent; i++) {
      result *= value;
    }

    return result;
  }

  void calculate() {
    if (!isFormValid) return;

    final income = double.parse(incomeController.text);

    final existingEmi = double.tryParse(existingEmiController.text) ?? 0;

    final loanAmount = double.parse(loanAmountController.text);

    final annualRate = isSalaried ? 10.5 : 13.0;

    final r = annualRate / 12 / 100;

    final factor = _power(1 + r, tenure);

    emi = (loanAmount * r * factor) / (factor - 1);

    totalPayable = emi * tenure;

    totalInterest = totalPayable - loanAmount;

    status = existingEmi + emi <= income * 0.5
        ? EligibilityStatus.eligible
        : EligibilityStatus.notEligible;
    notifyListeners();
  }

  Future<void> saveCheck() async {
    if (!isFormValid || status == null) {
      return;
    }

    final record = LoanRecord(
      loanAmount: double.parse(loanAmountController.text),
      calculatedEmi: emi,
      status: status!,
    );

    await repository.saveLoan(record);

    await loadHistory();
  }

  void updateTenure(int value) {
    tenure = value;
    calculate();
  }

  void updateEmployment(bool value) {
    isSalaried = value;
    calculate();
  }
}
