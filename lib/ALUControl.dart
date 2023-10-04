//ALU Control File
//In Progress

import 'package:rohd/rohd.dart';
import 'package:test/test.dart';
import 'dart:async';

class ALUControl extends Module {
  ALUControl({
    required Aluop,
    required funct7,
    required funct3,
    required clk,
    super.name = 'alu_control',
  }) {
    Aluop = addInput('Aluop', Aluop, width: 2);
    funct3 = addInput('funct3', funct3, width: 3);
    clk = addInput('clk', clk, width: 1);
    final Operation = addOutput('Operation', width: 4);
    Sequential(clk, [
      Case(
        [funct3, Aluop].swizzle(),
        [
          CaseItem(Const(LogicValue.ofString('11110')), [
            Operation < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('11010')), [
            Operation < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('10110')), [
            Operation < 2,
          ]),
          CaseItem(Const(LogicValue.ofString('10010')), [
            Operation < 3,
          ]),
          CaseItem(Const(LogicValue.ofString('01110')), [
            Operation < 4,
          ]),
          CaseItem(Const(LogicValue.ofString('01010')), [
            Operation < 5,
          ]),
          CaseItem(Const(LogicValue.ofString('00110')), [
            Operation < 6,
          ]),
          CaseItem(Const(LogicValue.ofString('00010')), [
            Operation < 7,
          ]),
          CaseItem(Const(LogicValue.ofString('11100')), [
            Operation < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('11000')), [
            Operation < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('10000')), [
            Operation < 3,
          ]),
        ],
        defaultItem: [
          Operation < 0,
        ],
      )
    ]);
  }
}

Future<void> main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final op = Logic(name: 'op', width: 3);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ALUControl(a: a, b: b, op: op, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
