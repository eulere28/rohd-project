//ALU Control File
//In Progress

import 'package:rohd/rohd.dart';
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
    final Control = addOutput('Control', width: 4);
    Sequential(clk, [
      Case(
        Aluop,
        [
          CaseItem(Const(LogicValue.ofString('00')), [
            Case(
              funct3,[
                CaseItem(Const(LogicValue.ofString('00')), [
              
          ]),
          ]),
          CaseItem(Const(LogicValue.ofString('01')), [
            Control < 6,
          ]),
          CaseItem(Const(LogicValue.ofString('10')), [
            Case(
              Aluop,
        [
                CaseItem(Const(LogicValue.ofString('0010')), [
                  Control < 
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
  final mod = ALUControl(a: a, b: b, op: op, clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
