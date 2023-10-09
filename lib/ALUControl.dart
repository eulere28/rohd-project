//ALU Control File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class ALUControl extends Module {
  ALUControl({
    required Logic aluOp,
    required Logic funct3,
    required Logic clk,
    super.name = 'alu_control',
  }) {
    aluOp = addInput('Aluop', aluOp, width: 2);
    funct3 = addInput('funct3', funct3, width: 3);
    clk = addInput('clk', clk, width: 1);

    final operation = addOutput('operation', width: 4);
    Sequential(clk, [
      Case(
        [funct3, aluOp].swizzle(),
        [
          CaseItem(Const(LogicValue.ofString('11110')), [
            operation < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('11010')), [
            operation < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('10110')), [
            operation < 2,
          ]),
          CaseItem(Const(LogicValue.ofString('10010')), [
            operation < 3,
          ]),
          CaseItem(Const(LogicValue.ofString('01110')), [
            operation < 4,
          ]),
          CaseItem(Const(LogicValue.ofString('01010')), [
            operation < 5,
          ]),
          CaseItem(Const(LogicValue.ofString('00110')), [
            operation < 6,
          ]),
          CaseItem(Const(LogicValue.ofString('00010')), [
            operation < 7,
          ]),
          CaseItem(Const(LogicValue.ofString('11100')), [
            operation < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('11000')), [
            operation < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('10000')), [
            operation < 3,
          ]),
        ],
        defaultItem: [
          operation < 0,
        ],
      )
    ]);
  }
}

Future<void> main() async {
  final aluOp = Logic(name: 'aluOp', width: 2);
  final funct3 = Logic(name: 'funct3', width: 3);
  final clk = Logic(name: 'clk', width: 1);

  final mod = ALUControl(aluOp: aluOp, funct3: funct3, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
