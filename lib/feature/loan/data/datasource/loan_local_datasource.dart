import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/loan_record_model.dart';


class LoanLocalDatasource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await openDatabase(
      join(
        await getDatabasesPath(),
        'loan_history.db',
      ),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE loan_history(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timestamp TEXT,
          income REAL,
          existingEmi REAL,
          loanAmount REAL,
          tenure INTEGER,
          employmentType TEXT,
          calculatedEmi REAL,
          status TEXT
        )
        ''');
      },
    );

    return _database!;
  }

  Future<void> saveLoan(
    LoanRecordModel model,
  ) async {
    final db = await database;

    await db.insert(
      'loan_history',
      model.toMap(),
    );
  }

  Future<List<LoanRecordModel>> getHistory() async {
    final db = await database;

    final result = await db.query(
      'loan_history',
      orderBy: 'id DESC',
      limit: 5,
    );

    return result
        .map(
          (e) => LoanRecordModel.fromMap(e),
        )
        .toList();
  }
}