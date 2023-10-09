//Register File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class RegisterFile extends Module {
  RegisterFile({
    required regWrite,
    required r1,
    required r2,
    required w1,
    required wd1,
    required clk,
    required reset,
    super.name = 'reg',
  }) {
    regWrite = addInput('regWrite', regWrite, width: 1);
    r1 = addInput('r1', r1, width: 5);
    r2 = addInput('r2', r2, width: 5);
    w1 = addInput('w1', w1, width: 5);
    wd1 = addInput('wd1', wd1, width: 32);
    clk = addInput('clk', clk, width: 1);
    reset = addInput('reset', reset, width: 1);
    final rd1 = addOutput('rd1', width: 5);
    final rd2 = addOutput('rd2', width: 5);
    final register = LogicArray([10], 32, name: 'register');

    Sequential((clk | reset), [
      If(reset, then: [
        register < 0,
      ], orElse: [
        If(regWrite, then: [
          register[w1] < wd1,
        ])
      ])
    ]);
    rd1 < register[r1];
    rd2 < register[r2];
  }
}

Future<void> main() async {
  final regWrite = Logic(name: 'regWrite', width: 1);
  final r1 = Logic(name: 'r1', width: 5);
  final r2 = Logic(name: 'r2', width: 5);
  final w1 = Logic(name: 'w1', width: 5);
  final wd1 = Logic(name: 'wd1', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final reset = Logic(name: 'reset', width: 1);
  final mod = RegisterFile(
      regWrite: regWrite,
      r1: r1,
      r2: r2,
      w1: w1,
      wd1: wd1,
      clk: clk,
      reset: reset);
  await mod.build();
  print(mod.generateSynth());
}
