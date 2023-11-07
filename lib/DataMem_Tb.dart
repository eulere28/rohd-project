//Data Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class DataMem extends Module {
  DataMem({
    required memRead,
    required memWrite,
    required addR,
    required writeData,
    required clk,
    super.name = 'memory',
  }) {
    memRead = addInput('memRead', memRead, width: 1);
    memWrite = addInput('memWrite', memWrite, width: 1);
    addR = addInput('addR', addR, width: 8).value.toInt();
    writeData = addInput('writeData', writeData, width: 32);
    clk = addInput('clk', clk, width: 1);
    final readData = addOutput('readData', width: 32);
    final memory = LogicArray([10], 32, name: 'memory');

    Combinational([
      If(memWrite, then: [
        memory.elements[addR] < writeData,
      ])
    ]);
    Combinational([
      If(memRead,
          then: [readData < memory.elements[addR]], orElse: [readData < 0]),
    ]);
  }
  Logic get readData => output('readData');
}

Future<void> main() async {
  final memRead = Logic(name: 'memRead', width: 1);
  final memWrite = Logic(name: 'memWrite', width: 1);
  final addR = Logic(name: 'addR', width: 8);
  final writeData = Logic(name: 'writeData', width: 32);
  final clk = Logic(name: 'clk', width: 1);

  print('Test: ');
  for (var z = 0; z <= 9; z++) {
    memory.elements[z] < 5;
  }
  for (var i = 0; i < 2; i++) {
    for (var j = 0; j < 2; j++) {
      for (var k = 0; k < 2; k++) {
        for (var l = 0; l < 2; l++) {
          memRead.put(i);
          memWrite.put(j);
          addR.put(k);
          writeData.put(l);
          final mod = DataMem(
              memRead: memRead,
              memWrite: memWrite,
              addR: addR,
              writeData: writeData,
              clk: clk);
          var rD = mod.readData.value.toInt();
          var mem = mod.memory[k].value.toInt();
          print(
              'memRead:$i, memWrite:$j, addR:$k, writeData:$l,Memory[addR]:$mem, readData:$rD');
        }
      }
    }
  }
}
