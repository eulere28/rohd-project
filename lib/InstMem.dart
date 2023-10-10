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
    final memory = LogicArray([64], 32, name: 'memory');

    memory.elements[0] < 28723;
    memory.elements[1] < 65683;
    memory.elements[2] < 2097427;
    memory.elements[3] < 3178899;
    memory.elements[4] < 4227603;
    memory.elements[5] < 5309075;
    memory.elements[6] < 6357779;
    memory.elements[7] < 7439251;
    memory.elements[8] < 2130995;
    memory.elements[9] < 1078199475;
    memory.elements[10] < 3241267;
    memory.elements[11] < 4318643;
    memory.elements[12] < 4302387;
    memory.elements[13] < 7554739;
    memory.elements[14] < 1295316755;
    memory.elements[15] < 2369120147;
    memory.elements[16] < 1294379027;
    memory.elements[17] < 1295272083;
    memory.elements[18] < 45099043;
    memory.elements[19] < 50341379;
    instruction < memory.elements[addR];
  }
}

Future<void> main() async {
  final addR = Logic(name: 'addR', width: 8);
  final mod = InstMem(addR: addR);

  await mod.build();
  print(mod.generateSynth());
}
