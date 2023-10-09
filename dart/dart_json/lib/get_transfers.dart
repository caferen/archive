import 'get_transactions.dart';
import 'transaction.dart';

// gets a transaction list and returns the transfers as two seperate lists
Future<List<List<Transaction>>> getTransfers() async {
  List<Transaction> positiveTransfers = [];
  List<Transaction> negativeTransfers = [];

  List<Transaction> transactions = await getTransactions();

  // if a transaction is a transfer and has a positive amount add to positive tranfers list
  // if a transaction is a transfer and has a negative amount add to negative tranfers list
  transactions.forEach((value) {
    if (value.category == 'transfer') {
      if (value.amount < 0) {
        negativeTransfers.add(value);
      } else if (value.amount > 0) {
        positiveTransfers.add(value);
      }
    }
  });
  return [positiveTransfers, negativeTransfers];
}
