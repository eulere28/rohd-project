//Imm Gen File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ImmGen extends Module {
  ImmGen({
    required instCode,
    super.name = 'Imm',
  }) {
    instCode = addInput('instCode', instCode, width: 32);
    final immOut = addOutput('immOut', width: 32);
    Sequential(instCode, [
      Case(
        instCode.slice(0, 6),
        [
          CaseItem(Const(LogicValue.ofString('0000011')), [
            immOut < instCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0010011')), [
            immOut < instCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0100011')), [
            immOut < instCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0000011')), [
            immOut < instCode.slice(31, 20),
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
  final mod = ImmGen(instCode: instCode);

  await mod.build();
  print(mod.generateSynth());
}
