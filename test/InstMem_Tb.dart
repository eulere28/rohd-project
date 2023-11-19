//Instant Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class InstMem extends Module {
  InstMem({
    required Logic addR,
    required Logic clk,
    super.name = 'inst_mem',
  }) {
    addR = addInput('addR', addR, width: 8);
    final instruction = addOutput('instruction', width: 32);
    final memory = LogicArray([64], 32, name: 'memory');
    final memList = [
      28723,
      1065107,
      2113811,
      3195283,
      4243987,
      5325459,
      6374163,
      2147251,
      4371507,
      4318387,
      4388147,
      5399987,
      22067,
      54963,
      2139955,
      2172851,
      2299955,
      5445683,
      2197555,
      7539043
    ];
    memList.asMap().forEach((index, value) {
      memory.elements[index] <= Const(value, width: 32);
    });
    Combinational([instruction < memory.elements[addR.value.toInt()]]);
  }
  Logic get instruction => output('instruction');
}

Future<void> main() async {
  final addR = Logic(name: 'addR', width: 8);
  final clk = Logic(name: 'clk', width: 1);
  print('Test: ');
  for (var i = 0; i <= 19; i++) {
    addR.put(i);
    final mod = InstMem(addR: addR, clk: clk);
    var ins = mod.instruction.value.toInt();
    print('addR: $i, instruction: $ins');
  }
}
