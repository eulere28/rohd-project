//Controller File
//Done

import 'package:rohd/rohd.dart';
import 'dart:async';

class Controller extends Module {
  Controller({
    required Opcode,
    required clk,
    super.name = 'controller',
  }) {
    Opcode = addInput('Opcode', Opcode, width: 7);
    clk = addInput('clk', clk, width: 1);
    final ALUSrc = addOutput('ALUSrc', width: 1);
    final MemtoReg = addOutput('MemtoReg', width: 1);
    final RegWrite = addOutput('RegWrite', width: 1);
    final MemRead = addOutput('MemRead', width: 1);
    final MemWrite = addOutput('MemWrite', width: 1);
    final ALUOp = addOutput('ALUOp', width: 2);
    Sequential(clk, [
      Case(
        Opcode,
        [
          CaseItem(Const(LogicValue.ofString('0000011')), [
            MemtoReg < 1,
            MemWrite < 0,
            MemRead < 1,
            ALUSrc < 1,
            RegWrite < 1,
            ALUOp < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('0100011')), [
            MemtoReg < 0,
            MemWrite < 1,
            MemRead < 0,
            ALUSrc < 1,
            RegWrite < 0,
            ALUOp < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('0010011')), [
            MemtoReg < 0,
            MemWrite < 0,
            MemRead < 0,
            ALUSrc < 1,
            RegWrite < 1,
            ALUOp < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('0110011')), [
            MemtoReg < 0,
            MemWrite < 0,
            MemRead < 0,
            ALUSrc < 0,
            RegWrite < 1,
            ALUOp < 2,
          ]),
        ],
        defaultItem: [
          MemtoReg < 0,
          MemWrite < 0,
          MemRead < 0,
          ALUSrc < 0,
          RegWrite < 0,
          ALUOp < 0,
        ],
      ),
    ]);
  }
}

Future<void> main() async {
  final Opcode = Logic(name: 'Opcode', width: 7);
  final clk = Logic(name: 'clk', width: 1);
  final mod = Controller(Opcode: Opcode, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
