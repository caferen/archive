import 'transaction.dart';

// take to list of transactions, compare and return the internals
List filterInternals(List<Transaction> positiveTransactions,
    List<Transaction> negativeTransactions) {
  List<List<Transaction>> internalTransaction = [];
  List<Transaction> externalTransfer = [];

  positiveTransactions.forEach((positiveTransaction) {
    negativeTransactions.forEach((negativeTransaction) {
      // if the amounts and the dates are the same and they are both unmtahced, they are internals
      if (positiveTransaction.amount == negativeTransaction.amount &&
          positiveTransaction.date == negativeTransaction.date &&
          !positiveTransaction.isMatched &&
          !negativeTransaction.isMatched) {
        // add them to the list
        internalTransaction.add([positiveTransaction, negativeTransaction]);

        // they are matched change the property to true
        positiveTransaction.isMatched = true;
        negativeTransaction.isMatched = true;
      }
    });
  });

  positiveTransactions.forEach((element) {
    if (!element.isMatched) {
      externalTransfer.add(element);
    }
  });
  negativeTransactions.forEach((element) {
    if (!element.isMatched) {
      externalTransfer.add(element);
    }
  });

  return [internalTransaction, externalTransfer];
}
