//Full Adder File
//Done

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
  Logic get sum => output('sum');
  Logic get cOut => output('cOut');
}

Future<void> main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final cIn = Logic(name: 'cIn', width: 32);
  final mod = FullAdder(a: a, b: b, cIn: cIn);
  print('Test:');
  for (var i = 0; i < 2; i++) {
    for (var j = 0; j < 2; j++) {
      for (var k = 0; k < 2; k++) {
        a.put(i);
        b.put(j);
        cIn.put(k);
        var d = mod.sum.value.toInt();
        var e = mod.cOut.value.toInt();
        print('a:$i, b:$j, C In:$k, Sum:$d, C Out:$e');
      }
    }
  }
}
