//Imm Gen File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ImmGen extends Module {
  ImmGen({
    required InstCode,
    super.name = 'Imm',
  }) {
    InstCode = addInput('InstCode', InstCode, width: 32);
    final ImmOut = addOutput('ImmOut', width: 32);
    Sequential(InstCode, [
      Case(
        InstCode.slice(0, 6),
        [
          CaseItem(Const(LogicValue.ofString('0000011')), [
            ImmOut < InstCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0010011')), [
            ImmOut < InstCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0100011')), [
            ImmOut < InstCode.slice(31, 20),
          ]),
          CaseItem(Const(LogicValue.ofString('0000011')), [
            ImmOut < InstCode.slice(31, 20),
          ]),
        ],
        defaultItem: [
          ImmOut < 0,
        ],
      ),
    ]);
  }
}

Future<void> main() async {
  final InstCode = Logic(name: 'InstCode', width: 32);
  final mod = ImmGen(InstCode: InstCode);

  await mod.build();
  print(mod.generateSynth());
}
