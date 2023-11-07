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

    Combinational([
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
  Logic get rd1 => output('rd1');
  Logic get rd2 => output('rd2');
}

Future<void> main() async {
  final regWrite = Logic(name: 'regWrite', width: 1);
  final r1 = Logic(name: 'r1', width: 5);
  final r2 = Logic(name: 'r2', width: 5);
  final w1 = Logic(name: 'w1', width: 5);
  final wd1 = Logic(name: 'wd1', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final rst = Logic(name: 'rst', width: 1);
  final mod = RegisterFile(
      regWrite: regWrite, r1: r1, r2: r2, w1: w1, wd1: wd1, clk: clk, rst: rst);
  print('Test:');
  for (var z = 0; z <= 9; z++) {
    register.elements[z] < z + 1;
  }
  for (var i = 0; i <= 1; i++) {
    for (var j = 0; j <= 1; j++) {
      for (var k = 0; k <= 1; k++) {
        rst.put(i);
        regWrite.put(j);
        wd1.put(k);
        w1.put(i);
        r1.put(i);
        r2.put(j);
        var reg = mod.register[i].value.toInt();
        var rd1 = mod.rd1.value.toInt();
        var rd2 = mod.rd2.value.toInt();
        print(
            'Reset:$i , regWrite:$j, wd1:$k, w1:$i, r1:$j, r2:$k, register[w1]:$reg, rd1:$rd1, rd2:$rd2');
      }
    }
  }
}
