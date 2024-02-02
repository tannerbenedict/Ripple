import 'dart:collection';
import 'dart:core';
import 'package:ripple/app/router.dart';
import 'package:ripple/models/database_models/card.dart';
import 'package:ripple/models/user.dart';
import 'package:ripple/providers/database_provider.dart';
import 'package:ripple/models/database_models/game_model.dart';
import 'package:ripple/providers/login_info_provider.dart';
import 'package:ripple/ui/components/auto_hiding_app_bar.dart';
import 'package:ripple/ui/games/solitaire/move.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:ripple/ui/home/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'column_pile.dart';
import 'draw_pile.dart';
import 'flipped_pile.dart';
import 'set_pile.dart';
import 'solitaire_logic.dart';

class Solitaire extends ConsumerStatefulWidget {
  static const soloRouteName = "solitaire";

  const Solitaire({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ConsumerState<Solitaire> createState() => _SolitaireState();
}

class _SolitaireState extends ConsumerState<Solitaire> {
  bool roundEnd = false;
  bool giveup = false;
  List<List<Card>> drawPile = [];
  List<List<Card>> flipped = [];
  List<List<Card>> column1 = [];
  List<List<Card>> column2 = [];
  List<List<Card>> column3 = [];
  List<List<Card>> column4 = [];
  List<List<Card>> column5 = [];
  List<List<Card>> column6 = [];
  List<List<Card>> column7 = [];
  List<Card> set1 = [];
  List<Card> set2 = [];
  List<Card> set3 = [];
  List<Card> set4 = [];
  List<bool> full = [];
  List<Suit> possibleSuits = [];
  int biggestListLength = 0;
  Queue<Move> moves = Queue();
  Queue<Move> undoneMoves = Queue();
  Queue<Move> autoMoves = Queue();
  int numMoves = 0;

  @override
  void initState() {
    super.initState();
    column1 = [[]];
    column2 = [[], []];
    column3 = [[], [], []];
    column4 = [[], [], [], []];
    column5 = [[], [], [], [], []];
    column6 = [[], [], [], [], [], []];
    column7 = [[], [], [], [], [], [], []];
    drawPile = [
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      [],
      []
    ];
    full = [false, false, false, false];
    SolitaireLogic.shuffleAndDealCards(column1, column2, column3, column4,
        column5, column6, column7, drawPile);
    biggestListLength = 1;
    possibleSuits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades];
  }

  Future<void> _runsAfterBuild(Move move) async {
    await Future.delayed(Duration(milliseconds: 200));
    makeMove(move);
  }

  @override
  Widget build(BuildContext context) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var sets = [set1, set2, set3, set4];
    biggestListLength = 0;
    for (var column in columns) {
      if (column.isNotEmpty) {
        var newLength = column.last.length + column.length - 1;
        if (newLength > biggestListLength) {
          biggestListLength = newLength;
        }
      }
    }

    if (columns.every((element) => element.length <= 1) &&
        drawPile.isEmpty &&
        flipped.isEmpty &&
        !roundEnd) {
      var moves = autoComplete(columns, sets);
      if (moves.isNotEmpty) {
        _runsAfterBuild(moves[0]);
      } else {
        roundEnd = true;
      }
    }

    if (roundEnd) _showWinnerBox(context, ref);

    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AutoHidingAppBar(
            title: const Text("Solitaire"),
            actions: [
              Text(
                  style: Theme.of(context).textTheme.labelLarge,
                  "Number of Moves: $numMoves"),
              _buildGiveUp(context),
              _buildUndo(context),
              _buildRedo(context),
              _buildHelpButton(context)
            ],
            alwaysVisible: true,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Image.asset("./images/oak_background.jpg").image
                      : Image.asset("./images/dark_background.jpg").image,
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: playCardGame(),
            ),
          ),
        ));
  }

  Widget playCardGame() => Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getCardSet(context, 1, Suit.clubs),
                      getCardSet(context, 2, Suit.diamonds),
                      getCardSet(context, 3, Suit.hearts),
                      getCardSet(context, 4, Suit.spades),
                      Text(""), // placeholder
                      FlippedPile(
                          flipped.isEmpty ? null : flipped.last,
                          flipped.length < 2
                              ? null
                              : flipped.elementAt(flipped.length - 2),
                          _autoAddFlipped),
                      DrawPile(
                          drawPile.isEmpty
                              ? (flipped.isEmpty ? null : flipped.first)
                              : drawPile.last,
                          drawPile.isEmpty,
                          flipped.isEmpty,
                          _createHandleDrawPileDraw()),
                    ]),
              ),
              Flexible(
                flex: 2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getCardColumn(context, 1),
                      getCardColumn(context, 2),
                      getCardColumn(context, 3),
                      getCardColumn(context, 4),
                      getCardColumn(context, 5),
                      getCardColumn(context, 6),
                      getCardColumn(context, 7)
                    ]),
              ),
            ],
          ),
        ],
      );

  List<Move> autoComplete(
      List<List<List<Card>>> oldColumns, List<List<Card>> oldSets) {
    List<List<List<Card>>> columns = [];
    for (var column in oldColumns) {
      List<List<Card>> newList = [];
      for (var list in column) {
        newList.add([...list]);
      }
      columns.add(newList);
    }

    List<List<Card>> sets = [];
    for (var set in oldSets) {
      sets.add([...set]);
    }
    var suits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades];

    List<Move> newMoves = [];

    while (columns.any((element) => element.isNotEmpty)) {
      for (int j = 0; j < columns.length; j++) {
        if (columns[j].isEmpty || columns[j].last.isEmpty) {
          continue;
        }
        var cards = [columns[j].last.last];

        for (int i = 0; i < sets.length; i++) {
          bool canAdd = SolitaireLogic.canAddSet(sets[i], cards, [suits[i]]);
          if (canAdd) {
            var newMove = Move("col", j, "set", i, cards, -1);
            sets[i].add(cards.last);
            columns[j].last.removeWhere((element) => cards.contains(element));
            if (columns[j].last.isEmpty) {
              columns[j].removeLast();
              newMove.colHiddenRevealed = columns.indexOf(columns[j]);
            }
            newMoves.add(newMove);
            // numMoves++;
            // undoneMoves.clear();
            // if (sets[i].length == 13) {
            //   full[i] = true;
            // }
            // if (full.every((isFull) => isFull)) {
            //   roundEnd = true;
            // }
            //return gameState;
          }
        }
      }
    }
    return newMoves;
  }

  void _addColumn(List<Card> cards, int col) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];

    List<Card> cols = [];
    if (columns[col - 1].isNotEmpty) {
      cols = columns[col - 1].last;
    }
    bool canAdd = SolitaireLogic.canAddColumn(cols, cards);
    if (canAdd) {
      if (cols.isNotEmpty) {
        var index = cards
            .indexWhere((card) => card.faceValue == cols.last.faceValue - 1);
        cards = cards.sublist(index, cards.length);
      }
      setState(() {
        var move = Move("", 0, "col", col - 1, [...cards], -1);
        if (columns[col - 1].isNotEmpty) {
          columns[col - 1].last =
              SolitaireLogic.addCards(columns[col - 1].last, [...cards]);
        } else {
          columns[col - 1].add([...cards]);
        }
        for (var column
            in columns.where((x) => columns.indexOf(x) != col - 1)) {
          if (column.any((element) => Set.of(element).containsAll(cards))) {
            move.from = "col";
            move.fromIndex = columns.indexOf(column);
            column.last.removeWhere((element) => cards.contains(element));
            if (column.last.isEmpty) {
              column.removeLast();
              move.colHiddenRevealed = columns.indexOf(column);
            }

            moves.add(move);
            numMoves++;
            undoneMoves.clear();
            return;
          }
        }

        if (flipped.any((element) => Set.of(element).containsAll(cards))) {
          move.from = "flipped";
          flipped.last.removeWhere((element) => cards.contains(element));
          if (flipped.last.isEmpty) flipped.removeLast();

          moves.add(move);
          numMoves++;
          undoneMoves.clear();
          return;
        }

        int setNum = removeFromSet(cards);

        if (setNum != -1) {
          move.from = "set";
          move.fromIndex = setNum;
        }

        moves.add(move);
        numMoves++;
        undoneMoves.clear();
      });
    }
  }

  void _autoAddFlipped(List<Card> cards) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var sets = [set1, set2, set3, set4];
    var suits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades];

    for (int i = 0; i < sets.length; i++) {
      bool canAdd = SolitaireLogic.canAddSet(sets[i], cards, [suits[i]]);
      if (canAdd) {
        var move = Move("flipped", 0, "set", i, cards, -1);
        setState(() {
          sets[i].add(cards.last);
          flipped.removeLast();
          moves.add(move);
          numMoves++;
          undoneMoves.clear();
          if (sets[i].length == 13) {
            full[i] = true;
          }
          if (full.every((isFull) => isFull)) {
            roundEnd = true;
          }
        });

        return;
      }
    }

    for (int i = 0; i < columns.length; i++) {
      List<Card> cols = [];
      if (columns[i].isNotEmpty) {
        cols = columns[i].last;
      }
      bool canAdd = SolitaireLogic.canAddColumn(cols, cards);
      if (canAdd) {
        if (cols.isNotEmpty) {
          var index = cards
              .indexWhere((card) => card.faceValue == cols.last.faceValue - 1);
          cards = cards.sublist(index, cards.length);
        }
        setState(() {
          var move = Move("flipped", 0, "col", i, [...cards], -1);
          if (columns[i].isNotEmpty) {
            columns[i].last =
                SolitaireLogic.addCards(columns[i].last, [...cards]);
          } else {
            columns[i].add([...cards]);
          }
          move.from = "flipped";
          flipped.last.removeWhere((element) => cards.contains(element));
          if (flipped.last.isEmpty) flipped.removeLast();

          moves.add(move);
          numMoves++;
          undoneMoves.clear();
        });

        return;
      }
    }
  }

  void _autoAddCol(List<Card> cards, int col) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var sets = [set1, set2, set3, set4];
    var suits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades];
    col--;

    for (int i = 0; i < sets.length; i++) {
      bool canAdd = SolitaireLogic.canAddSet(sets[i], cards, [suits[i]]);
      if (canAdd) {
        var move = Move("col", col, "set", i, cards, -1);
        setState(() {
          sets[i].add(cards.last);
          columns[col].last.removeWhere((element) => cards.contains(element));
          if (columns[col].last.isEmpty) {
            columns[col].removeLast();
            move.colHiddenRevealed = columns.indexOf(columns[col]);
          }
          moves.add(move);
          numMoves++;
          undoneMoves.clear();
          if (sets[i].length == 13) {
            full[i] = true;
          }
          if (full.every((isFull) => isFull)) {
            roundEnd = true;
          }
        });

        return;
      }
    }

    for (int i = 0; i < columns.length; i++) {
      List<Card> cols = [];
      if (columns[i].isNotEmpty) {
        cols = columns[i].last;
      }
      bool canAdd = SolitaireLogic.canAddColumn(cols, cards);
      if (canAdd) {
        if (cols.isNotEmpty) {
          var index = cards
              .indexWhere((card) => card.faceValue == cols.last.faceValue - 1);
          cards = cards.sublist(index, cards.length);
        }
        setState(() {
          var move = Move("col", col, "col", i, cards, -1);
          if (columns[i].isNotEmpty) {
            columns[i].last =
                SolitaireLogic.addCards(columns[i].last, [...cards]);
          } else {
            columns[i].add([...cards]);
          }
          columns[col].last.removeWhere((element) => cards.contains(element));
          if (columns[col].last.isEmpty) {
            columns[col].removeLast();
            move.colHiddenRevealed = columns.indexOf(columns[col]);
          }

          moves.add(move);
          numMoves++;
          undoneMoves.clear();
        });

        return;
      }
    }
  }

  void _autoAddSet(List<Card> cards, int set) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var sets = [set1, set2, set3, set4];
    set--;

    for (int i = 0; i < columns.length; i++) {
      List<Card> cols = [];
      if (columns[i].isNotEmpty) {
        cols = columns[i].last;
      }
      bool canAdd = SolitaireLogic.canAddColumn(cols, cards);
      if (canAdd) {
        if (cols.isNotEmpty) {
          var index = cards
              .indexWhere((card) => card.faceValue == cols.last.faceValue - 1);
          cards = cards.sublist(index, cards.length);
        }
        setState(() {
          var move = Move("set", set, "col", i, cards, -1);
          if (columns[i].isNotEmpty) {
            columns[i].last =
                SolitaireLogic.addCards(columns[i].last, [...cards]);
          } else {
            columns[i].add([...cards]);
          }
          sets[set].removeLast();

          moves.add(move);
          numMoves++;
          undoneMoves.clear();
        });

        return;
      }
    }
  }

  Widget getCardColumn(BuildContext context, int num) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var column = columns[num - 1];
    var numHiddenCards = column.length - 1;
    var height = MediaQuery.of(context).size.height / 2 -
        (MediaQuery.of(context).padding.bottom +
            MediaQuery.of(context).padding.top);
    var width = MediaQuery.of(context).size.width / 7 -
        (MediaQuery.of(context).padding.left +
            MediaQuery.of(context).padding.right);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      height = (MediaQuery.of(context).size.height / 3) * 2 - 20;
      width = MediaQuery.of(context).size.width / 8;
    }
    return Flexible(
        child: ColumnPile(
            column.isEmpty ? null : column.last,
            null,
            num,
            _addColumn,
            _autoAddCol,
            width,
            height,
            biggestListLength,
            numHiddenCards,
            columns.every((element) => element.length <= 1) &&
                drawPile.isEmpty &&
                flipped.isEmpty));
  }

  int removeFromSet(List<Card> cards) {
    var sets = [set1, set2, set3, set4];
    for (var set in sets) {
      if (Set.of(set).containsAll(cards)) {
        set.removeLast();
        return sets.indexOf(set);
      }
    }

    return -1;
  }

  Widget getCardSet(BuildContext context, int setNum, Suit suit) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    var sets = [set1, set2, set3, set4];
    var set = sets[setNum - 1];
    return SetPile(
        suit,
        set.isEmpty ? null : set.last,
        set.length < 2 ? null : set.elementAt(set.length - 2),
        setNum,
        _addSet,
        _autoAddSet,
        columns.every((element) => element.length <= 1) &&
            drawPile.isEmpty &&
            flipped.isEmpty);
  }

  void _addSet(List<Card> cards, int setNum) {
    var sets = [set1, set2, set3, set4];
    var set = sets[setNum - 1];
    var suits = [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades];

    bool canAdd = SolitaireLogic.canAddSet(set, cards, [suits[setNum - 1]]);
    if (canAdd) {
      var move = Move("", 0, "set", setNum - 1, cards, -1);
      setState(() {
        set.add(cards.last);
        removeCard(cards, move);
        moves.add(move);
        numMoves++;
        undoneMoves.clear();
      });
    }
    if (set.length == 13) {
      setState(() {
        full[setNum - 1] = true;
      });
    }
    if (full.every((isFull) => isFull)) {
      setState(() {
        roundEnd = true;
      });
    }
  }

  void removeCard(List<Card> cards, Move move) {
    var list = [column1, column2, column3, column4, column5, column6, column7];

    for (var column in list) {
      if (column.isNotEmpty && cards.isNotEmpty) {
        if (column.last.contains(cards.last)) {
          move.from = "col";
          move.fromIndex = list.indexOf(column);
          if (column.last.length > 1) {
            column.last.remove(cards.last);
          } else {
            move.colHiddenRevealed = list.indexOf(column);
            column.remove(column.last);
          }
          break;
        }
      }
    }

    if (flipped.contains(cards)) {
      move.from = "flipped";
      flipped.remove(cards);
    }
  }

  Widget _buildGiveUp(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            _showLoserBox(context, ref);
          });
        },
        icon: Icon(Icons.close));
  }

  void _addToFlipped(List<Card> cards) {
    if (drawPile.isNotEmpty) {
      setState(() {
        var move = Move("draw", 0, "flipped", 0, drawPile.elementAt(0), -1);
        flipped.add(drawPile.removeAt(0));
        moves.add(move);
        numMoves++;
        undoneMoves.clear();
      });
    } else {
      setState(() {
        var move = Move("flipped", 0, "draw", 0, cards, -1);
        drawPile = flipped;
        flipped = [];
        moves.add(move);
        numMoves++;
        undoneMoves.clear();
      });
    }
  }

  void Function(List<Card>)? _createHandleDrawPileDraw() {
    return _addToFlipped;
  }

  void _showWinnerBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .winSolitare(User.fromFirebaseUser(user), numMoves);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have earned 1 coin!"),
      ));
    }
    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You Win'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to play again or return home?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Play Again',
              ),
              onPressed: () {
                roundEnd = false;
                giveup = false;
                drawPile = [];
                flipped = [];
                column1 = [];
                column2 = [];
                column3 = [];
                column4 = [];
                column5 = [];
                column6 = [];
                column7 = [];
                set1 = [];
                set2 = [];
                set3 = [];
                set4 = [];
                numMoves = 0;
                moves.clear();
                undoneMoves.clear();
                autoMoves.clear();
                biggestListLength = 0;
                full = full.map<bool>((v) => false).toList();
                possibleSuits = [];
                context.goNamed(GameType.solitaire.soloPath);
                context.pop();
                setState(() {
                  column1 = [[]];
                  column2 = [[], []];
                  column3 = [[], [], []];
                  column4 = [[], [], [], []];
                  column5 = [[], [], [], [], []];
                  column6 = [[], [], [], [], [], []];
                  column7 = [[], [], [], [], [], [], []];
                  drawPile = [
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []
                  ];
                  SolitaireLogic.shuffleAndDealCards(column1, column2, column3,
                      column4, column5, column6, column7, drawPile);
                  possibleSuits = [
                    Suit.clubs,
                    Suit.diamonds,
                    Suit.hearts,
                    Suit.spades
                  ];
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                context.goNamed(HomePage.routeName);
              },
            )
          ],
        ),
      );
    });
  }

  Widget _buildHelpButton(BuildContext context) => IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      },
      icon: Icon(Icons.question_mark_outlined));

  Widget _buildUndo(BuildContext context) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    return IconButton(
        onPressed: moves.isNotEmpty &&
                !(columns.every((element) => element.length <= 1) &&
                    drawPile.isEmpty &&
                    flipped.isEmpty)
            ? () {
                undo();
              }
            : null,
        icon: Icon(Icons.undo_rounded));
  }

  Widget _buildRedo(BuildContext context) {
    var columns = [
      column1,
      column2,
      column3,
      column4,
      column5,
      column6,
      column7
    ];
    return IconButton(
        onPressed: undoneMoves.isNotEmpty &&
                !(columns.every((element) => element.length <= 1) &&
                    drawPile.isEmpty &&
                    flipped.isEmpty)
            ? () {
                redo();
              }
            : null,
        icon: Icon(Icons.redo_rounded));
  }

  void undo() {
    setState(() {
      var sets = [set1, set2, set3, set4];
      var columns = [
        column1,
        column2,
        column3,
        column4,
        column5,
        column6,
        column7
      ];
      var move = moves.last;
      var cards = [...move.what];
      numMoves++;

      if (move.from == "draw" || move.to == "draw") {
        if (move.from == "draw") {
          drawPile.insert(0, flipped.removeLast());
        } else {
          flipped = drawPile;
          drawPile = [];
        }
      } else {
        if (move.from == "set") {
          sets[move.fromIndex].addAll(cards);
        } else if (move.from == "col") {
          if (move.colHiddenRevealed != -1) {
            columns[move.fromIndex].add(cards);
          } else {
            columns[move.fromIndex].last.addAll(cards);
          }
        } else {
          flipped.add(cards);
        }

        if (move.to == "set") {
          sets[move.toIndex].removeWhere((element) => cards.contains(element));
        } else if (move.to == "col") {
          columns[move.toIndex]
              .last
              .removeWhere((element) => cards.contains(element));

          if (columns[move.toIndex].last.isEmpty) {
            columns[move.toIndex].removeLast();
          }
        } else {
          flipped.removeLast();
        }
      }

      undoneMoves.add(moves.removeLast());
    });
  }

  void redo() {
    setState(() {
      var sets = [set1, set2, set3, set4];
      var columns = [
        column1,
        column2,
        column3,
        column4,
        column5,
        column6,
        column7
      ];
      var move = undoneMoves.last;
      var cards = [...move.what];
      numMoves++;

      if (move.from == "draw" || move.to == "draw") {
        if (move.from == "draw") {
          flipped.add(drawPile.removeAt(0));
        } else {
          drawPile = flipped;
          flipped = [];
        }
      } else {
        if (move.to == "set") {
          sets[move.toIndex].addAll(cards);
        } else if (move.to == "col") {
          if (columns[move.toIndex].isEmpty) {
            columns[move.toIndex].add(cards);
          } else {
            columns[move.toIndex].last.addAll(cards);
          }
        } else {
          flipped.add(cards);
        }

        if (move.from == "set") {
          sets[move.fromIndex]
              .removeWhere((element) => cards.contains(element));
        } else if (move.from == "col") {
          columns[move.fromIndex]
              .last
              .removeWhere((element) => cards.contains(element));
          if (move.colHiddenRevealed != -1) {
            columns[move.fromIndex].removeLast();
          }
        } else {
          flipped.removeLast();
        }
      }

      moves.add(undoneMoves.removeLast());
    });
  }

  void makeMove(Move move) {
    setState(() {
      var sets = [set1, set2, set3, set4];
      var columns = [
        column1,
        column2,
        column3,
        column4,
        column5,
        column6,
        column7
      ];
      var cards = [...move.what];
      numMoves++;

      if (move.from == "draw" || move.to == "draw") {
        if (move.from == "draw") {
          flipped.add(drawPile.removeAt(0));
        } else {
          drawPile = flipped;
          flipped = [];
        }
      } else {
        if (move.to == "set") {
          sets[move.toIndex].addAll(cards);
        } else if (move.to == "col") {
          if (columns[move.toIndex].isEmpty) {
            columns[move.toIndex].add(cards);
          } else {
            columns[move.toIndex].last.addAll(cards);
          }
        } else {
          flipped.add(cards);
        }

        if (move.from == "set") {
          sets[move.fromIndex]
              .removeWhere((element) => cards.contains(element));
        } else if (move.from == "col") {
          columns[move.fromIndex]
              .last
              .removeWhere((element) => cards.contains(element));
          if (move.colHiddenRevealed != -1) {
            columns[move.fromIndex].removeLast();
          }
        } else {
          flipped.removeLast();
        }
      }
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return Dialog(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("How to Play",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Text(
                //     "Solitaire",
                //     style: TextStyle(
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          color: Theme.of(context).colorScheme.background,
                          constraints: BoxConstraints.expand(height: 50),
                          child: TabBar(tabs: [
                            Tab(text: "Game Objective"),
                            Tab(text: "Playing the Game"),
                            Tab(text: "The Piles"),
                            Tab(text: "Controls")
                          ]),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TabBarView(children: [
                              SingleChildScrollView(
                                child: Text(
                                    "The first objective is to release and play into position certain cards to build up each foundation, in sequence and in suit, from the ace through the king. The ultimate objective is to build the whole pack onto the foundations, and if that can be done, the Solitaire game is won."),
                              ),
                              SingleChildScrollView(
                                child: Text(
                                    "The initial array may be changed by \"building\" - transferring cards among the face-up cards in the tableau. Certain cards of the tableau can be played at once, while others may not be played until certain blocking cards are removed. For example, of the seven cards facing up in the tableau, if one is a nine and another is a ten, you may transfer the nine to on top of the ten to begin building that pile in sequence. Since you have moved the nine from one of the seven piles, you have now unblocked a face down card; this card can be turned over and now is in play. \n \nAs you transfer cards in the tableau and begin building sequences, if you uncover an ace, the ace should be placed in one of the foundation piles. The foundations get built by suit and in sequence from ace to king. \n \nContinue to transfer cards on top of each other in the tableau in sequence. If you can’t move any more face up cards, you can utilize the stock pile by flipping over the first card. This card can be played in the foundations or tableau. If you cannot play the card in the tableau or the foundations piles, move the card to the waste pile and turn over another card in the stock pile. \n \nIf a vacancy in the tableau is created by the removal of cards elsewhere it is called a “space”, and it is of major importance in manipulating the tableau. If a space is created, it can only be filled in with a king. Filling a space with a king could potentially unblock one of the face down cards in another pile in the tableau. \n \nContinue to transfer cards in the tableau and bring cards into play from the stock pile until all the cards are built in suit sequences in the foundation piles to win!"),
                              ),
                              SingleChildScrollView(
                                child: Text(
                                    "There are four different types of piles in Solitaire: \n \n 1. The Tableau: Seven piles that make up the main table. \n \n 2. The Foundations: Four piles on which a whole suit or sequence must be built up. In most Solitaire games, the four aces are the bottom card or base of the foundations. The foundation piles are hearts, diamonds, spades, and clubs. \n \n 3. The Stock (or “Hand”) Pile: If the entire pack is not laid out in a tableau at the beginning of a game, the remaining cards form the stock pile from which additional cards are brought into play according to the rules. \n \n 4. The Talon (or “Waste”) Pile: Cards from the stock pile that have no place in the tableau or on foundations are laid face up in the waste pile."),
                              ),
                              SingleChildScrollView(
                                  child: Text(
                                      "There are Two ways to move cards. User can either tap/click on the card and if it can move it will automatically move to the availible space. The user can also move cards by dragging them to the available space.\n\nWhen all cards are either in the tableu and/or the foundations the game will auto complete.")),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _showLoserBox(BuildContext context, WidgetRef ref) async {
    final user = ref.read(loginInfoProvider.select((value) => value.user));
    if (user != null) {
      await ref
          .read(databaseRepositoryProvider)
          .loseSolitaire(User.fromFirebaseUser(user));
    }
    return WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('You Lose'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to play again or return home?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Play Again',
              ),
              onPressed: () {
                roundEnd = false;
                giveup = false;
                drawPile = [];
                flipped = [];
                column1 = [];
                column2 = [];
                column3 = [];
                column4 = [];
                column5 = [];
                column6 = [];
                column7 = [];
                set1 = [];
                set2 = [];
                set3 = [];
                set4 = [];
                numMoves = 0;
                moves.clear();
                undoneMoves.clear();
                autoMoves.clear();
                biggestListLength = 0;
                full = full.map<bool>((v) => false).toList();
                possibleSuits = [];
                context.goNamed(GameType.solitaire.soloPath);
                context.pop();
                setState(() {
                  column1 = [[]];
                  column2 = [[], []];
                  column3 = [[], [], []];
                  column4 = [[], [], [], []];
                  column5 = [[], [], [], [], []];
                  column6 = [[], [], [], [], [], []];
                  column7 = [[], [], [], [], [], [], []];
                  drawPile = [
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []
                  ];
                  SolitaireLogic.shuffleAndDealCards(column1, column2, column3,
                      column4, column5, column6, column7, drawPile);
                  possibleSuits = [
                    Suit.clubs,
                    Suit.diamonds,
                    Suit.hearts,
                    Suit.spades
                  ];
                });
              },
            ),
            ElevatedButton(
              child: Text(
                'Return Home',
              ),
              onPressed: () {
                context.goNamed(HomePage.routeName);
              },
            )
          ],
        ),
      );
    });
  }
}
