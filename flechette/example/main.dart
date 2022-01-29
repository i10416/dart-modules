import 'package:flechette/flechette.dart';

// ignore_for_file: avoid_print
void main() {
  final m = [1, 2, 3, 4, 5, 6]
      .groupBy((p0) => p0 % 2 == 0)
      .updateWith(true)((maybe) => maybe.flatMap((e) => e.map((e) => e * 2)));
  // => <bool,Iterable<int>>{true: [4,8,12],false : [1,3,5]};

  final l = [1, 2, 3, 4, 5].slide().map((e) => e.swap());
  // =>   <$<int,int>>[(2,1),(3,2),(4,3),(5,4)];
  print(m);
  print(l);
}
