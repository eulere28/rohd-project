import 'package:rohd/rohd.dart';
import 'dart:async';

class ALU extends Module {
  ALU({
    required MemRead,
    required MemWrite,
    required addr,
    required write_data,
    required clk,
    super.name = 'memory',
  }) {
    MemRead = addInput('MemRead', MemRead, width: 1);
    MemWrite = addInput('MemWrite', MemWrite, width: 1);
    addr = addInput('addr', addr, width: 8);
    write_data = addInput('write_data', write_data, width: 32);
    clk = addInput('clk',clk,width:1);
    final read_data = addOutput('read_data', width: 32);
    LogicArray([10], 32, name: 'memory');
    Sequential(clk, [
      If(MemWrite,then:[
        memory[addr]<write_data,
      ])
    ]);
    if(MemRead){
      read_data<memory[addr];
    }
    else{
      read_data<0;
    }
  }
}

Future<void> main() async {
  final MemRead = Logic(name: 'MemRead', width: 1);
  final MemWrite = Logic(name: 'MemWrite', width: 1);
  final addr = Logic(name: 'addr', width: 8);
  final write_data = Logic(name: 'write_data', width: 31);
  final clk = Logic(name: 'clk', width: 1);
  final mod = ALU(MemRead: MemRead, MemWrite: MemWrite, addr:addr,write_data:write_data,clk: clk);

  await mod.build();
  print(mod.generateSynth());
}
