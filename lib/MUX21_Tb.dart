//MUX File
//Done

import 'package:rohd/rohd.dart';
import 'dart:async';

class MUX21 extends Module {
  MUX21({
    required s,
    required d1,
    required d2,
    required clk,
    super.name = 'dff',
  }) {
    s = addInput('s', s, width: 1);
    d1 = addInput('d1', d1, width: 32);
    d2 = addInput('d2', d2, width: 32);
    clk = addInput('clk', clk, width: 1);
    final y = addOutput('y', width: 32);
    Combinational([
      If.block([
        Iff(s.eq(0), [y < d1]),
        Else([y < d2])
      ])
    ]);
  }
  Logic get y => output('y');
}

Future<void> main() async {
  final s = Logic(name: 'S', width: 1);
  final d1 = Logic(name: 'd1', width: 32);
  final d2 = Logic(name: 'd2', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final mod = MUX21(s: s, d1: d1, d2: d2, clk: clk);

  await mod.build();
  for (var j = 0; j <= 1; j++) {
    for (var k = 3; k <= 4; k++) {
      for (var i = 0; i <= 1; i++) {
        s.put(i);
        d1.put(j);
        d2.put(k);
        var z = mod.y.value.toInt();
        print('s:$i, d1:$j, d2:$k, y:$z');
      }
    }
  }
}
