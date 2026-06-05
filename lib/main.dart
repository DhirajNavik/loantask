import 'package:flutter/material.dart';
import 'package:loantask/feature/loan/data/datasource/loan_local_datasource.dart';
import 'package:loantask/feature/loan/data/repositories/loan_repositories_impl.dart';
import 'package:loantask/feature/loan/presentation/view/loan_view.dart';
import 'package:loantask/feature/loan/presentation/viewmodel/loan_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          LoanViewModel(LoanRepositoryImpl(LoanLocalDatasource()))
            ..loadHistory(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoanView());
  }
}
