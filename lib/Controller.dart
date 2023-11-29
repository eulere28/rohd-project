// Controller.dart
// Determine the signals for aluSrc, memToReg, regWrite, memRead, memWrite and aluOp
//
// 2023 November 28
// Author: Lim Kim Lun <limkimlun@gmail.com>

import 'package:rohd/rohd.dart';
import 'dart:async';

class Controller extends Module {
  Controller({
    required opCode,
    required clk,
    super.name = 'controller',
  }) {
    opCode = addInput('opCode', opCode, width: 7);
    clk = addInput('clk', clk, width: 1);
    final aluSrc = addOutput('aluSrc', width: 1);
    final memToReg = addOutput('memToReg', width: 1);
    final regWrite = addOutput('regWrite', width: 1);
    final memRead = addOutput('memRead', width: 1);
    final memWrite = addOutput('memWrite', width: 1);
    final aluOp = addOutput('aluOp', width: 2);
    Sequential(clk, [
      Case(
        opCode,
        [
          CaseItem(Const(LogicValue.ofString('0000011')), [
            memToReg < 1,
            memWrite < 0,
            memRead < 1,
            aluSrc < 1,
            regWrite < 1,
            aluOp < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('0100011')), [
            memToReg < 0,
            memWrite < 1,
            memRead < 0,
            aluSrc < 1,
            regWrite < 0,
            aluOp < 1,
          ]),
          CaseItem(Const(LogicValue.ofString('0010011')), [
            memToReg < 0,
            memWrite < 0,
            memRead < 0,
            aluSrc < 1,
            regWrite < 1,
            aluOp < 0,
          ]),
          CaseItem(Const(LogicValue.ofString('0110011')), [
            memToReg < 0,
            memWrite < 0,
            memRead < 0,
            aluSrc < 0,
            regWrite < 1,
            aluOp < 2,
          ]),
        ],
        defaultItem: [
          memToReg < 0,
          memWrite < 0,
          memRead < 0,
          aluSrc < 0,
          regWrite < 0,
          aluOp < 0,
        ],
      ),
    ]);
  }
}

Future<void> main() async {
  final opCode = Logic(name: 'opCode', width: 7);
  final clk = Logic(name: 'clk', width: 1);
  final mod = Controller(opCode: opCode, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
