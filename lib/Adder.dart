// Adder.dart
// Full Adder Module
//
// 2023 November 28
// Author: Lim Kim Lun <limkimlun@gmail.com>

import 'package:rohd/rohd.dart';
import 'dart:async';

class FullAdder extends Module {
  FullAdder({
    required a,
    required b,
    required cIn,
    super.name = 'full_adder',
  }) {
    a = addInput('a', a, width: 32);
    b = addInput('b', b, width: 32);
    cIn = addInput('cIn', cIn, width: 32);
    final sum = addOutput('sum', width: 32);
    final cOut = addOutput('cOut', width: 32);
    final and1 = cIn & (a ^ b);
    final and2 = b & a;
    Combinational([
      sum < (a ^ b) ^ cIn,
      cOut < and1 | and2,
    ]);
  }
}

Future<void> main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final cIn = Logic(name: 'cIn', width: 32);
  final mod = FullAdder(a: a, b: b, cIn: cIn);

  await mod.build();
  print(mod.generateSynth());
}
