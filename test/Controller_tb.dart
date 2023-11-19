//Controller File
//Done

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
    Combinational([
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
  Logic get memToReg => output('memToReg');
  Logic get memWrite => output('memWrite');
  Logic get memRead => output('memRead');
  Logic get aluSrc => output('aluSrc');
  Logic get regWrite => output('regWrite');
  Logic get aluOp => output('aluOp');
}

Future<void> main() async {
  final opCode = Logic(name: 'opCode', width: 7);
  final clk = Logic(name: 'clk', width: 1);
  final mod = Controller(opCode: opCode, clk: clk);
  print('Test:');
  var opList = [3, 35, 19, 51, 0, 1, 2];
  for (var i = 0; i <= 6; i++) {
    var op = opList[i];
    opCode.put(op);
    var data1 = mod.memToReg.value.toInt();
    var data2 = mod.memWrite.value.toInt();
    var data3 = mod.memRead.value.toInt();
    var data4 = mod.aluSrc.value.toInt();
    var data5 = mod.regWrite.value.toInt();
    var data6 = mod.aluOp.value.toInt();
    print(
        'Op Code: $op \n memToReg:$data1\n memWrite:$data2\n memRead:$data3\n aluSrc:$data4\n regWrite:$data5\n aluOp:$data6\n\n');
  }
}
