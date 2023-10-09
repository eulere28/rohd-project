//Data Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ALU extends Module {
  ALU({
    required memRead,
    required memWrite,
    required addR,
    required writeData,
    required clk,
    super.name = 'memory',
  }) {
    memRead = addInput('memRead', memRead, width: 1);
    memWrite = addInput('memWrite', memWrite, width: 1);
    addR = addInput('addR', addR, width: 8);
    writeData = addInput('writeData', writeData, width: 32);
    clk = addInput('clk', clk, width: 1);
    final readData = addOutput('readData', width: 32);
    LogicArray([10], 32, name: 'memory');
    Sequential(clk, [
      If(memWrite, then: [
        memory[addR] < writeData,
      ])
    ]);
    if (memRead) {
      readData < memory[addR];
    } else {
      readData < 0;
    }
  }
}

Future<void> main() async {
  final memRead = Logic(name: 'memRead', width: 1);
  final memWrite = Logic(name: 'memWrite', width: 1);
  final addR = Logic(name: 'addR', width: 8);
  final writeData = Logic(name: 'writeData', width: 31);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ALU(
      memRead: memRead,
      memWrite: memWrite,
      addR: addR,
      writeData: writeData,
      clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
