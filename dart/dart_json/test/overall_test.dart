import 'package:test/test.dart';
import 'package:cash_coach/filter_internals.dart';
import 'package:cash_coach/get_transfers.dart';

void main() {
  test(
      'the sum of internal and external transfers should be equal to total number of transfers',
      () async {
    var transfers = await getTransfers();
    var internals = filterInternals(transfers[0], transfers[1])[0];
    var externals = filterInternals(transfers[0], transfers[1])[1];
    expect(transfers[0].length + transfers[1].length,
        internals.length * 2 + externals.length);
  });
}
