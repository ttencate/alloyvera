class Levels {

  public static var CRIMSIUM = new Metal("crimsium", 0xff990000);
  public static var BYZANTIUM = new Metal("byzantium", 0xff702963);
  public static var CELESTIUM = new Metal("celestium", 0xff4997d0);

  public static var CAFFEUM = new Metal("caffeum", 0xff6f4e37);
  public static var CREAMIUM = new Metal("creamium", 0xfffff8e7);

  public static var CUCUMBRIUM = new Metal("cucumbrium", 0xff228b22);
  public static var TOMATIUM = new Metal("tomatium", 0xffff6347);

  public static var SALTPETRE = new Metal("saltpetre", 0xfff0f8ff);
  public static var SULPHUR = new Metal("sulphur", 0xffe9d66b);
  public static var CHARCOAL = new Metal("charcoal", 0xff101010);

  public static var CARROTIUM = new Metal("carrotium", 0xffed9121);
  public static var CANARIUM = new Metal("canarium", 0xffffef00);
  public static var FERRARIUM = new Metal("ferrarium", 0xffff2800);

  public static var ROTTIUM = new Metal("rottium", 0xff556b2f);
  public static var DECAYIUM = new Metal("decayium", 0xff483c32);
  public static var DECOMPOSIUM = new Metal("decomposium", 0xff560319);

  public static var LIMIUM = new Metal("limium", 0xffbfff00);
  public static var AMBERIUM = new Metal("amberium", 0xffffbf00);
  public static var CYANIUM = new Metal("cyanium", 0xff00ffff);
  public static var FUCHSIUM = new Metal("fuchsium", 0xfff400a1);

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
      completionText: "You have created\n\nLATTEUM\n\nA delicious drink that keeps industrious alchemists working all night.\n\nWith this, your career is off to a good start!",
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
      completionText: "You have created\n\nSALADIUM\n\nA colourful mix full of vitamins and rich in fibre, it keeps the inner alchemist healthy and well fed.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(12, new Alloy().set(SALTPETRE, 12)),
        new Beaker(6, new Alloy().set(SULPHUR, 6)),
        new Beaker(6, new Alloy().set(CHARCOAL, 6)),
        new Beaker(5),
        new Beaker(3),
      ]),
      goal: new Goal(new Alloy().set(SALTPETRE, 3).set(CHARCOAL, 1).set(SULPHUR, 1)),
      itemIndex: 2,
      completionText: "You have created\n\nGUNPOWDER\n\nand are starting to feel like a real alchemist, rather than a cook.\n\nYou try not to worry too much about what this invention will mean for world peace.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(10, new Alloy().set(FERRARIUM, 10)),
        new Beaker(12, new Alloy().set(CARROTIUM, 12)),
        new Beaker(9, new Alloy().set(CANARIUM, 9)),
        new Beaker(7),
        new Beaker(3),
      ]),
      goal: new Goal(new Alloy().set(FERRARIUM, 3).set(CARROTIUM, 2).set(CANARIUM, 1)),
      itemIndex: 3,
      completionText: "You have created\n\nNONSENSICUM\n\nalthough you are not sure why.\n\nWith these kinds of experiments, one can never tell what good they will bring.",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(10, new Alloy().set(ROTTIUM, 10)),
        new Beaker(9, new Alloy().set(DECAYIUM, 9)),
        new Beaker(9, new Alloy().set(DECOMPOSIUM, 9)),
        new Beaker(5),
        new Beaker(4),
        new Beaker(4),
      ]),
      goal: new Goal(new Alloy().set(ROTTIUM, 2).set(DECAYIUM, 2).set(DECOMPOSIUM, 1)),
      itemIndex: 4,
      completionText: "You have created\n\nMIASMA\n\nIt smells terrible, but allegedly it helps to keep dwarves away. Who'd have thought?",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(10, new Alloy().set(LIMIUM, 10)),
        new Beaker(10, new Alloy().set(AMBERIUM, 10)),
        new Beaker(10, new Alloy().set(CYANIUM, 10)),
        new Beaker(10, new Alloy().set(FUCHSIUM, 10)),
        new Beaker(8),
        new Beaker(4),
        new Beaker(3),
      ]),
      goal: new Goal(new Alloy().set(LIMIUM, 3).set(AMBERIUM, 2).set(CYANIUM, 2).set(FUCHSIUM, 1)),
      itemIndex: 5,
      completionText: "You have created\n\nPALETTIUM\n\nIt hurts your eyes, but once painters get their hands on this stuff, it's going to change the world!",
    },

    {
      instructions: null,
      startState: new State([
        new Beaker(9, new Alloy().set(BYZANTIUM, 9)),
        new Beaker(9, new Alloy().set(CELESTIUM, 9)),
        new Beaker(4, new Alloy().set(CRIMSIUM, 4)),
        new Beaker(5),
        new Beaker(5),
        new Beaker(3),
      ]),
      goal: new Goal(new Alloy().set(BYZANTIUM, 6).set(CELESTIUM, 2).set(CRIMSIUM, 1)),
      itemIndex: 15,
      completionText: "You have created\n\nCOMPLETIUM,\n\nevery alchemist's ultimate dream. You have achieved world fame and riches beyond imagination!",
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
