import 'package:flutter/material.dart';
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
    final provider = context.watch<LoanViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("LOAN APP")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
              RadioGroup(
                groupValue: provider.isSalaried ? "Salaried" : "Self Employed",
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
              ),

              ElevatedButton(
                onPressed: () {
                  provider.saveCheck();
                },
                child: Text("Save Plan"),
              ),

              if (provider.status != null)
                ResultCard(
                  emi: provider.emi,
                  totalPayable: provider.totalPayable,
                  totalInterest: provider.totalInterest,
                  status: provider.status!,
                ),

              Align(
                alignment: .centerLeft,
                child: const Text(
                  'History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              HistoryList(history: provider.history),
            ],
          ),
        ),
      ),
    );
  }
}
