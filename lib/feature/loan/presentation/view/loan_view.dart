import 'package:flutter/material.dart';
import 'package:loantask/feature/loan/domain/entity/loan_record.dart';
import 'package:loantask/feature/loan/domain/enum/eligibility_status.dart';
import 'package:loantask/feature/loan/presentation/components/common_textfield.dart';
import 'package:loantask/feature/loan/presentation/components/history_list.dart';
import 'package:loantask/feature/loan/presentation/components/result_card.dart';
import 'package:loantask/feature/loan/presentation/viewmodel/loan_viewmodel.dart';
import 'package:provider/provider.dart';

final List<int> dropDownValues = [12, 24, 36, 48, 60];

class LoanView extends StatefulWidget {
  const LoanView({super.key});

  @override
  State<LoanView> createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<LoanViewModel>();

      provider.incomeController.addListener(provider.calculate);

      provider.existingEmiController.addListener(provider.calculate);

      provider.loanAmountController.addListener(provider.calculate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoanViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("LOAN APP")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),

        physics: const ClampingScrollPhysics(),
        child: Column(
          spacing: 12,
          children: [
            CommonTextField(
              hintText: "Monthly Income",
              controller: provider.incomeController,
            ),
            CommonTextField(
              hintText: "Current EMI Amount",
              controller: provider.existingEmiController,
            ),
            CommonTextField(
              hintText: "Loan Amount",
              controller: provider.loanAmountController,
            ),

            DropdownMenu<int>(
              width: double.infinity,
              initialSelection: provider.tenure,
              hintText: "Select Tenure",
              onSelected: (value) {
                if (value != null) {
                  provider.updateTenure(value);
                }
              },
              dropdownMenuEntries: dropDownValues
                  .map<DropdownMenuEntry<int>>(
                    (int item) => DropdownMenuEntry<int>(
                      value: item,
                      label: "$item Months",
                    ),
                  )
                  .toList(),
            ),
            Selector<LoanViewModel, bool>(
              selector: (_, provider) => provider.isSalaried,
              builder: (context, isSalaried, child) {
                return RadioGroup(
                  groupValue: provider.isSalaried
                      ? "Salaried"
                      : "Self Employed",
                  onChanged: (value) {
                    provider.updateEmployment(value == "Salaried");
                  },
                  child: Row(
                    children: [
                      Radio(value: "Salaried"),
                      Text("Salaried"),
                      Radio(value: "Self Employed"),
                      Text("Self Employed"),
                    ],
                  ),
                );
              },
            ),

            ElevatedButton(
              onPressed: () {
                provider.saveCheck();
              },
              child: Text("Save Plan"),
            ),

            Selector<
              LoanViewModel,
              ({
                double emi,
                double totalPayable,
                double totalInterest,
                EligibilityStatus? status,
              })
            >(
              selector: (_, provider) => (
                emi: provider.emi,
                totalPayable: provider.totalPayable,
                totalInterest: provider.totalInterest,
                status: provider.status,
              ),
              builder: (context, data, child) {
                if (data.status == null) {
                  return const SizedBox.shrink();
                }

                return ResultCard(
                  emi: data.emi,
                  totalPayable: data.totalPayable,
                  totalInterest: data.totalInterest,
                  status: data.status!,
                );
              },
            ),

            Align(
              alignment: .centerLeft,
              child: const Text(
                'History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Selector<LoanViewModel, List<LoanRecord>>(
              selector: (_, provider) => provider.history,
              builder: (context, history, child) {
                return HistoryList(history: history);
              },
            ),
          ],
        ),
      ),
    );
  }
}
