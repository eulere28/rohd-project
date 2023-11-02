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
      65683,
      2097427,
      3178899,
      4227603,
      5309075,
      6357779,
      7439251,
      2130995,
      1078199475,
      3241267,
      4318643,
      4302387,
      7554739,
      1295316755,
      2369120147,
      1294379027,
      1295272083,
      45099043,
      50341379
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
