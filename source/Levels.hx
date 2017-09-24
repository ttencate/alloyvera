class Levels {

  public static var ALL: Array<Level> = [
    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(Metal.CRIMSIUM, 12)),
        new Beaker(12, new Alloy().set(Metal.BYZANTIUM, 12)),
        new Beaker(2),
        new Beaker(1),
      ]),
      goal: new Goal(new Alloy().set(Metal.CRIMSIUM, 1).set(Metal.BYZANTIUM, 1)),
      completionText: "Hello world! We can write long text here because it will be wrapped, methinks.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(10, new Alloy().set(Metal.AMBERIUM, 10)),
        new Beaker(12, new Alloy().set(Metal.BYZANTIUM, 12)),
        new Beaker(3),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(Metal.AMBERIUM, 1).set(Metal.BYZANTIUM, 1)),
      completionText: "Hello world! We can write long text here because it will be wrapped, methinks.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(Metal.CRIMSIUM, 12)),
        new Beaker(12, new Alloy().set(Metal.BYZANTIUM, 12)),
        new Beaker(12, new Alloy().set(Metal.AMBERIUM, 12)),
        new Beaker(5),
        new Beaker(3),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(Metal.CRIMSIUM, 1).set(Metal.BYZANTIUM, 1).set(Metal.AMBERIUM, 1)),
      completionText: "Hello world! We can write long text here because it will be wrapped, methinks.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(Metal.CARROTIUM, 12)),
        new Beaker(12, new Alloy().set(Metal.CELESTIUM, 12)),
        new Beaker(4),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(Metal.CARROTIUM, 3).set(Metal.CELESTIUM, 1)),
      completionText: "Hello world! We can write long text here because it will be wrapped, methinks.",
    },
  ];

  public static var COUNT = ALL.length;

  public static function init() {
    for (level in ALL) {
      if (level.instructions == null) {
        level.instructions = 'To make:\n${level.goal}';
      }
    }
  }

}
