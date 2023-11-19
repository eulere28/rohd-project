//ALU File
//Done

import 'package:rohd/rohd.dart';
import 'dart:async';

class Alu extends Module {
  Alu({
    required a,
    required b,
    required op,
    super.name = 'alu_op',
  }) {
    a = addInput('a', a, width: 32);
    b = addInput('b', b, width: 32);
    op = addInput('op', op, width: 3);
    final c = addOutput('c', width: 32);
    Combinational([
      Case(
        op,
        [
          CaseItem(Const(LogicValue.ofString('000')), [
            c < a & b,
          ]),
          CaseItem(Const(LogicValue.ofString('001')), [
            c < a | b,
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
  final mod = Alu(a: a, b: b, op: op);

  await mod.build();
  print(mod.generateSynth());
}
