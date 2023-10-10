//Datapath
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';
import 'Alu.dart';
import 'DataMem.dart';
import 'DFlipFlop.dart';
import 'InstMem.dart';
import 'MUX21.dart';
import 'RegisterFile.dart';
import 'ImmGen.dart';

class DataPath extends Module {
  DataPath({
    required clk,
    required rst,
    required regWrite,
    required mem2Reg,
    required aluSrc,
    required memWrite,
    required memRead,
    required aluCC,
    super.name = 'dff',
  }) {
    int pC_W = 8; //Program Counter Width
    int i_W = 32; //Instruction Width
    int reg_Add = 5; //Register File Address
    int data_W = 32; //Data Write Data
    int dM_Add = 9; //Data Memory Address
    int aluCC_W = 4; //ALU Control Code Width

    rst = addInput('rst', rst, width: 1);
    clk = addInput('clk', clk, width: 1);
    regWrite = addInput('regWrite', regWrite, width: 1);
    mem2Reg = addInput('mem2Reg', mem2Reg, width: 1);
    aluSrc = addInput('aluSrc', aluSrc, width: 1);
    memWrite = addInput('memWrite', memWrite, width: 1);
    memRead = addInput('memRead', memRead, width: 1);
    aluCC = addInput('aluCC', aluCC, width: aluCC_W);

    final opCode = addOutput('opCode', width: 7);
    final funct7 = addOutput('funct7', width: 7);
    final funct3 = addOutput('funct3', width: 3);
    final aluResult = addOutput('aluResult', width: data_W);

    final cOut = Logic(name: 'cOut', width: 1);
    final zero = Logic(name: 'zero', width: 1);
    final overflow = Logic(name: 'overflow', width: 1);
    final nPCCount = Logic(name: 'nPCCount', width: pC_W);
    final pCCount = Logic(name: 'pCCount', width: pC_W);
    final instrCode = Logic(name: 'instrCode', width: i_W);
    final wrtData = Logic(name: 'wrtData', width: i_W);
    final aluIn1 = Logic(name: 'aluIn1', width: i_W);
    final aluIn2 = Logic(name: 'aluIn2', width: i_W);
    final rgData = Logic(name: 'rgData', width: i_W);
    final immitValue = Logic(name: 'immitValue', width: i_W);
    final memData = Logic(name: 'memData', width: i_W);

    final fF1 = DFlipFlop(d: nPCCount, clk: clk, rst: rst);
    nPCCount < pCCount + 4;
    final iM1 = InstMem(addR: pCCount);
    final rg1 = RegisterFile(
        clk: clk,
        rst: rst,
        regWrite: regWrite,
        r1: instrCode.slice(19, 19 - reg_Add + 1),
        r2: instrCode.slice(24, 24 - reg_Add + 1),
        w1: instrCode.slice(11, 11 - reg_Add + 1),
        wd1: wrtData);
    final mux1 = MUX21(clk: clk, s: aluSrc, d1: rgData, d2: immitValue);
    final iG1 = ImmGen(clk: clk, instCode: instrCode);
    final a1 = Alu(clk: clk, op: aluCC, a: aluIn1, b: aluIn2);
    final dm1 = DataMem(
        memRead: memRead,
        memWrite: memWrite,
        addR: aluResult.slice(dM_Add - 1, 0),
        writeData: rgData,
        clk: clk);
    final mux2 = MUX21(clk: clk, s: mem2Reg, d1: aluResult, d2: memData);
    opCode < instrCode.slice(6, 0);
    funct3 < instrCode.slice(14, 12);
    funct7 < instrCode.slice(31, 25);
  }
}

Future<void> main() async {
  final rst = Logic(name: 'rst', width: 1);
  final clk = Logic(name: 'clk', width: 1);
  final regWrite = Logic(name: 'regWrite', width: 1);
  final mem2Reg = Logic(name: 'mem2Reg', width: 1);
  final aluSrc = Logic(name: 'aluSrc', width: 1);
  final memWrite = Logic(name: 'memWrite', width: 1);
  final memRead = Logic(name: 'memRead', width: 1);
  final aluCC = Logic(name: 'aluCC', width: 4);
  final mod = DataPath(
      rst: rst,
      clk: clk,
      regWrite: regWrite,
      mem2Reg: mem2Reg,
      aluSrc: aluSrc,
      memWrite: memWrite,
      memRead: memRead,
      aluCC: aluCC);
  await mod.build();
  print(mod.generateSynth());
}
