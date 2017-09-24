class Levels {

  public static var CRIMSIUM = new Metal("crimsium", 0xff990000);
  public static var LIMIUM = new Metal("limium", 0xffbfff00);
  public static var AMBERIUM = new Metal("amberium", 0xffffbf00);
  public static var BYZANTIUM = new Metal("byzantium", 0xff702963);
  public static var CANARIUM = new Metal("canarium", 0xffffef00);
  public static var CARROTIUM = new Metal("carrotium", 0xffed9121);
  public static var CELESTIUM = new Metal("celestium", 0xff4997d0);
  public static var CYANIUM = new Metal("cyanium", 0xff00ffff);
  public static var FUCHSIUM = new Metal("fuchsium", 0xfff400a1);
  public static var FERRARIUM = new Metal("ferrarium", 0xffff2800);

  public static var CAFFEUM = new Metal("caffeum", 0xff6f4e37);
  public static var CREAMIUM = new Metal("creamium", 0xfffff8e7);

  public static var CUCUMBRIUM = new Metal("cucumbrium", 0xff228b22);
  public static var TOMATIUM = new Metal("tomatium", 0xffff6347);

  public static var ALL: Array<Level> = [
    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(CAFFEUM, 12)),
        new Beaker(12, new Alloy().set(CREAMIUM, 12)),
        new Beaker(2),
        new Beaker(1),
      ]),
      goal: new Goal(new Alloy().set(CAFFEUM, 1).set(CREAMIUM, 1)),
      itemIndex: 0,
      completionText: "You have created\n\nLATTEUM\n\nA delicious drink that keeps industrious alchemists working all night!",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(10, new Alloy().set(TOMATIUM, 10)),
        new Beaker(12, new Alloy().set(CUCUMBRIUM, 12)),
        new Beaker(3),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(CUCUMBRIUM, 1).set(TOMATIUM, 1)),
      itemIndex: 1,
      completionText: "You have created\n\nSALADIUM\n\nA colourful and mix full of vitamins and rich in fibre.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(CRIMSIUM, 12)),
        new Beaker(12, new Alloy().set(BYZANTIUM, 12)),
        new Beaker(12, new Alloy().set(AMBERIUM, 12)),
        new Beaker(5),
        new Beaker(3),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(CRIMSIUM, 1).set(BYZANTIUM, 1).set(AMBERIUM, 1)),
      itemIndex: 2,
      completionText: "Hello world! We can write long text here because it will be wrapped, methinks.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(CARROTIUM, 12)),
        new Beaker(12, new Alloy().set(CELESTIUM, 12)),
        new Beaker(4),
        new Beaker(2),
      ]),
      goal: new Goal(new Alloy().set(CARROTIUM, 3).set(CELESTIUM, 1)),
      itemIndex: 3,
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
