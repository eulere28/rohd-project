import 'package:rohd/rohd.dart';
import 'dart:async';

class ALU extends Module {
  ALU({
    required a,
    required b,
    required op,
    required clk,
    super.name = 'alu_op',
  }) {
    a = addInput('a', a, width: 32);
    b = addInput('b', b, width: 32);
    op = addInput('op', op, width: 3);
    clk = addInput('clk', clk, width: 1);
    final c = addOutput('c', width: 32);
    Sequential(clk, [
      Case(
        op,
        [
          CaseItem(Const(LogicValue.ofString('000')), [
            c < a | b,
          ]),
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
  final mod = ALU(a: a, b: b, op: op, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
