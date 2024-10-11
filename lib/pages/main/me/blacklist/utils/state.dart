enum Status {
  INIT,
  EMPTY,
  DATA,
}

class StatusHand {
  int type = Status.INIT.index;

  void initState() {
    type = Status.INIT.index;
  }

  void dataState() {
    type = Status.DATA.index;
  }

  void emptyState() {
    type = Status.EMPTY.index;
  }
}
