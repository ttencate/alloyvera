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
        new Goal(2, new Alloy().set(Metal.IRON, 1).set(Metal.ZINC, 1)),
      ],
    },
  ];

}
