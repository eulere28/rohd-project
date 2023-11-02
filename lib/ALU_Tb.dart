//ALU File
//Done

import 'package:rohd/rohd.dart';
import 'dart:async';

class Alu extends Module {
  Alu({
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
  Logic get c => output('c');
}

Future<void> main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final op = Logic(name: 'op', width: 3);
  final clk = Logic(name: 'clk', width: 1);
  final mod = Alu(a: a, b: b, op: op, clk: clk);

  print('\nTest: ');
  for (var o = 0; o <= 7; o++) {
    op.put(o);
    print('\nOperation: $o');
    for (var i = 0; i <= 1; i++) {
      for (var j = 0; j <= 1; j++) {
        a.put(i);
        b.put(j);
        var d = mod.c.value.toInt();
        print('a:$i,b:$j c:$d');
      }
    }
  }
}
