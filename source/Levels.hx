class Levels {

  public static var ALL: Array<Level> = [
    {
      startState: new State([
        new Beaker(12, new Alloy().set(Metal.IRON, 10)),
        new Beaker(1),
        new Beaker(2),
        new Beaker(12, new Alloy().set(Metal.ZINC, 10)),
      ]),
      goals: [
        new Goal(new Alloy().set(Metal.IRON, 1).set(Metal.ZINC, 1)),
      ],
    },
    {
      startState: new State([
        new Beaker(12, new Alloy().set(Metal.IRON, 10)),
        new Beaker(3),
        new Beaker(2),
        new Beaker(12, new Alloy().set(Metal.ZINC, 10)),
      ]),
      goals: [
        new Goal(new Alloy().set(Metal.IRON, 1).set(Metal.ZINC, 1)),
      ],
    },
    {
      startState: new State([
        new Beaker(10, new Alloy().set(Metal.IRON, 10)),
        new Beaker(10, new Alloy().set(Metal.ZINC, 10)),
        new Beaker(10, new Alloy().set(Metal.COPPER, 10)),
        new Beaker(5),
        new Beaker(3),
        new Beaker(2),
      ]),
      goals: [
        new Goal(new Alloy().set(Metal.IRON, 1).set(Metal.ZINC, 1).set(Metal.COPPER, 1)),
      ],
    },
  ];

  public static var COUNT = ALL.length;

}
