import 'dart:convert';
import 'dart:io';
import 'transaction.dart';

// read the files and return the transaction object list
Future<List<Transaction>> getTransactions() async {
  List<Transaction> transactions = [];

  List<String> paths = [
    'json/ex1-account1.json',
    'json/ex1-account2.json',
    'json/ex1-account3.json',
  ];

  // read the files => cast them into a map => map them into transaction objects
  for (String path in paths) {
    String fileContents = await File(path).readAsString();
    var parsed = json.decode(fileContents).cast<Map<String, dynamic>>();

    transactions.addAll(
        parsed.map<Transaction>((json) => Transaction.fromJson(json)).toList());
  }

  return transactions;
}
