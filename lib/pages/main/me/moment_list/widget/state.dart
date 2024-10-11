import 'package:oliapro/pages/main/me/blacklist/utils/state.dart';

mixin class ListState {
  int state = Status.INIT.index; // 0 empty, 1 loading ,2 list

  int get loading => state = Status.INIT.index;

  int get empty => state = Status.EMPTY.index;

  int get data => state = Status.DATA.index;
}
