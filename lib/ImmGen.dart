// ImmGen.dart
// Generate immidiate value based on the instruction code
//
// 2023 November 28
// Author: Lim Kim Lun <limkimlun@gmail.com>

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

    Sequential(clk, [
      Case(
        instCode.slice(0, 6),
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
          CaseItem(Const(LogicValue.ofString('0000011')), [
            immOut < instCode,
          ]),
        ],
        defaultItem: [
          immOut < 0,
        ],
      ),
    ]);
  }
}

Future<void> main() async {
  final instCode = Logic(name: 'instCode', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ImmGen(instCode: instCode, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
