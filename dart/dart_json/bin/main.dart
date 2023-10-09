import '../lib/filter_internals.dart';
import '../lib/get_transfers.dart';
import '../lib/transaction.dart';

void main() async {
  List<List<Transaction>> results = await getTransfers();
  List<List<Transaction>> internals =
      filterInternals(results[0], results[1])[0];

  internals.forEach((value) {
    print('${value[0].id}, ${value[1].id}');
  });
}
