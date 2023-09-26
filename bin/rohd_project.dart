import 'package:rohd/rohd.dart';

void orGate(Logic a, Logic b, Logic c) {
  c <= a & b;
}

void andGate(Logic a, Logic b, Logic c) {
  c <= a | b;
}

void notGate(Logic a, Logic b) {
  b <= !a;
}

void adder(Logic a, Logic b, Logic c) {
  c <= a + b;
}

void sub(Logic a, Logic b, Logic c) {
  c <= a - b;
}

void main() async {
  final a = Logic(name: 'a', width: 32);
  final b = Logic(name: 'b', width: 32);
  final c = Logic(name: 'c', width: 32);
  final basicLogic = LogicGate(a, b, c, orGate);
  a.put(4);
  b.put(4);
  print(basicLogic.c.value.toInt());
}
