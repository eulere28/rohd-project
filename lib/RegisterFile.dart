//Register File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class RegisterFile extends Module {
  RegisterFile({
    required Logic regWrite,
    required Logic r1,
    required Logic r2,
    required Logic w1,
    required Logic wd1,
    required Logic clk,
    required Logic rst,
    super.name = 'reg',
  }) {
    regWrite = addInput('regWrite', regWrite, width: 1);
    r1 = addInput('r1', r1, width: 5);
    r2 = addInput('r2', r2, width: 5);
    w1 = addInput('w1', w1, width: 5);
    wd1 = addInput('wd1', wd1, width: 32);
    clk = addInput('clk', clk, width: 1);
    rst = addInput('rst', rst, width: 1);
    final rd1 = addOutput('rd1', width: 32);
    final rd2 = addOutput('rd2', width: 32);
    final register = LogicArray([10], 32, name: 'register');

    Sequential((clk | rst), [
      If(rst, then: [
        register < 0,
      ], orElse: [
        If(regWrite, then: [
          register.elements[w1.value.toInt()] < wd1,
        ])
      ])
    ]);
    rd1 <= register.elements[r1.value.toInt()];
    rd2 <= register.elements[r2.value.toInt()];
  }
}

Future<void> main() async {
  final regWrite = Logic(name: 'regWrite', width: 1);
  final r1 = Logic(name: 'r1', width: 5);
  final r2 = Logic(name: 'r2', width: 5);
  final w1 = Logic(name: 'w1', width: 5);
  r1.put(1);
  r2.put(1);
  w1.put(1);
  final wd1 = Logic(name: 'wd1', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final rst = Logic(name: 'rst', width: 1);
  final mod = RegisterFile(
      regWrite: regWrite, r1: r1, r2: r2, w1: w1, wd1: wd1, clk: clk, rst: rst);
  await mod.build();
  print(mod.generateSynth());
}
