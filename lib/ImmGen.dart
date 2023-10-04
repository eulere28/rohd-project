//Imm Gen File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ImmGen extends Module {
  ImmGen({
    required InstCode,
    super.name = 'ImmGen',
  }) {
    InstCode = addInput('InstCode', InstCode, width: 32);
    final ImmOut = addOutput('ImmOut', width: 32);
    Sequential(InstCode, [
      Case(
        InstCode.substring(0, 6),
        [
          CaseItem(Const(LogicValue.ofString('0000011')),
              [if (InstCode[31] == 1) {}]),
          CaseItem(Const(LogicValue.ofString('001')), [
            c < a & b,
          ]),
          CaseItem(Const(LogicValue.ofString('010')), [
            c < ~a,
          ]),
          CaseItem(Const(LogicValue.ofString('011')), [
            c < a + b,
          ]),
          CaseItem(Const(LogicValue.ofString('100')), [
            c < a - b,
          ]),
          CaseItem(Const(LogicValue.ofString('101')), [
            c < a * b,
          ]),
          CaseItem(Const(LogicValue.ofString('110')), [
            c < a / b,
          ]),
          CaseItem(Const(LogicValue.ofString('111')), [
            c < a % b,
          ]),
        ],
        defaultItem: [
          c < c,
        ],
      ),
    ]);
  }
}

Future<void> main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final op = Logic(name: 'op', width: 3);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ImmGen(a: a, b: b, op: op, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
