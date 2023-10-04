//Instant Memory File
//In Progress

import 'package:rohd/rohd.dart';
import 'dart:async';

class InstMem extends Module {
  InstMem({
    required addr,
    super.name = 'inst_mem',
  }) {
    addr = addInput('addr', addr, width: 8);
    final instruction = addOutput('instruction', width: 32);
    LogicArray([64], 32, name: 'memory');

    memory[0]<00007033,

  }
}

Future<void> main() async {
  final addr = Logic(name: 'addr', width: 8);
  final mod = InstMem(addr:addr);

  await mod.build();
  print(mod.generateSynth());
}
