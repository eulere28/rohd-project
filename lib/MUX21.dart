//MUX File
//Done

import 'package:rohd/rohd.dart';
import 'dart:async';

class MUX21 extends Module {
  MUX21({
    required S,
    required D1,
    required D2,
    required clk,
    super.name = 'dff',
  }) {
    S = addInput('S', S, width: 1);
    D1 = addInput('D1', D1, width: 32);
    D2 = addInput('D2', D2, width: 32);
    clk = addInput('clk', clk, width: 1);
    final Y = addOutput('Y', width: 32);
    if (S == 0) {
      Y < D1;
    } else {
      Y < D2;
    }
  }
}

Future<void> main() async {
  final S = Logic(name: 'S', width: 1);
  final D1 = Logic(name: 'D1', width: 32);
  final D2 = Logic(name: 'D2', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final mod = MUX21(S: S, D1: D1, D2: D2, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
