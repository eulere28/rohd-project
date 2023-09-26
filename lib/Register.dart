import 'package:rohd/rohd.dart';
import 'dart:async';

class RegisterFile extends Module {
  RegisterFile({
    required RegWrite,
    required R1,
    required R2,
    required W1,
    required WD1,
    required clk,
    required reset,
    super.name = 'reg',
  }) {
    RegWrite = addInput('RegWrite', RegWrite, width: 1);
    R1 = addInput('R1', R1, width: 5);
    R2 = addInput('R2', R2, width: 5);
    W1 = addInput('W1', W1, width: 5);
    WD1 = addInput('WD1', WD1, width: 32);
    clk = addInput('clk', clk, width: 1);
    reset = addInput('reset', reset, width: 1);
    final RD1 = addOutput('RD1', width: 5);
    final RD2 = addOutput('RD2', width: 5);
    LogicArray([10], 32, name: 'Register');

    Sequential((clk | reset), [
      If(reset, then: [
        Register[0] < 0,
        Register[1] < 0,
        Register[2] < 0,
        Register[3] < 0,
        Register[4] < 0,
        Register[5] < 0,
        Register[6] < 0,
        Register[7] < 0,
        Register[8] < 0,
        Register[9] < 0,
      ], orElse: [
        If(RegWrite, then: [
          Register[W1] < WD1,
        ])
      ])
    ]);
    RD1 < Register[R1];
    RD2 < Register[R2];
  }
}

Future<void> main() async {
  final RegWrite = Logic(name: 'RegWrite', width: 1);
  final R1 = Logic(name: 'R1', width: 5);
  final R2 = Logic(name: 'R2', width: 5);
  final W1 = Logic(name: 'W1', width: 5);
  final WD1 = Logic(name: 'WD1', width: 32);
  final clk = Logic(name: 'clk', width: 1);
  final reset = Logic(name: 'reset', width: 1);
  final mod = RegisterFile(
      RegWrite: RegWrite,
      R1: R1,
      R2: R2,
      W1: W1,
      WD1: WD1,
      clk: clk,
      reset: reset);
  await mod.build();
  print(mod.generateSynth());
}
