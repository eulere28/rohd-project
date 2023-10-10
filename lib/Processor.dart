//Processor File
//In Proogress

//Instant Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';
import 'Datapath.dart';
import 'Controller.dart';
import 'ALUControl.dart';

class Processor extends Module {
  Processor({
    required clk,
    required rst,
    super.name = 'processor',
  }) {
    clk = addInput('clk', clk, width: 1);
    rst = addInput('rst', rst, width: 1);
    final result = addOutput('result', width: 8);
    final regWrite = Logic(name: 'regWrite', width: 1);
    final mem2Reg = Logic(name: 'mem2Reg', width: 1);
    final aluSrc = Logic(name: 'aluSrc', width: 1);
    final memWrite = Logic(name: 'memWrite', width: 1);
    final memRead = Logic(name: 'memRead', width: 1);
    final aluCC = Logic(name: 'aluCC', width: 4);
    final opCode = Logic(name: 'opCode', width: 7);
    final funct7 = Logic(name: 'funct7', width: 7);
    final funct3 = Logic(name: 'funct3', width: 3);
    final aluOp = Logic(name: 'aluOp', width: 2);

    final dP1 = DataPath(
        clk: clk,
        rst: rst,
        regWrite: regWrite,
        mem2Reg: mem2Reg,
        aluSrc: aluSrc,
        aluCC: aluCC,
        memRead: memRead,
        memWrite: memWrite);
    final c1 = Controller(opCode: opCode, clk: clk);
    final aC1 = ALUControl(aluOp: aluOp, funct3: funct3, clk: clk);
  }
}

Future<void> main() async {
  final clk = Logic(name: 'clk', width: 1);
  final rst = Logic(name: 'rst', width: 1);
  final mod = Processor(clk: clk, rst: rst);

  await mod.build();
  print(mod.generateSynth());
}
