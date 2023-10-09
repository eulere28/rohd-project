//Instant Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class InstMem extends Module {
  InstMem({
    required addR,
    super.name = 'inst_mem',
  }) {
    addR = addInput('addR', addR, width: 8);
    final instruction = addOutput('instruction', width: 32);
    LogicArray([64], 32, name: 'memory');

    memory[0]<00007033,

  }
}

Future<void> main() async {
  final addR = Logic(name: 'addR', width: 8);
  final mod = InstMem(addR:addR);

  await mod.build();
  print(mod.generateSynth());
}
