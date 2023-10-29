//Imm Gen File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ImmGen extends Module {
  ImmGen({
    required instCode,
    required clk,
    super.name = 'Imm',
  }) {
    instCode = addInput('instCode', instCode, width: 32);
    clk = addInput('clk', clk, width: 1);
    final immOut = addOutput('immOut', width: 32);

    Combinational([
      Case(
        instCode.slice(6, 0),
        [
          CaseItem(Const(LogicValue.ofString('0000011')), [
            immOut < instCode,
          ]),
          CaseItem(Const(LogicValue.ofString('0010011')), [
            immOut < instCode,
          ]),
          CaseItem(Const(LogicValue.ofString('0100011')), [
            immOut < instCode,
          ]),
          CaseItem(Const(LogicValue.ofString('0010111')), [
            immOut < instCode,
          ]),
        ],
        defaultItem: [
          immOut < 0,
        ],
      ),
    ]);
  }
  Logic get immOut => output('immOut');
}

Future<void> main() async {
  final instCode = Logic(name: 'instCode', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ImmGen(instCode: instCode, clk: clk);

  print('Test:');
  var instCodeList = [3, 131, 19, 147, 35, 163, 23, 151, 1, 2];
  for (var i = 1; i <= 10; i++) {
    var inst = instCodeList[i - 1];
    instCode.put(inst);
    var io = mod.immOut.value.toInt();
    print('No $i: instCode: $inst \timmOut: $io');
  }
}
