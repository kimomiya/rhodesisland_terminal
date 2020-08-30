import 'package:flutter/material.dart';

enum Rarity {
  one,
  two,
  three,
  four,
  five,
  six,
}

extension RarityValue on Rarity {
  static Rarity of(int value) => Rarity.values.firstWhere(
        (rarity) => rarity.value == value,
        orElse: () => Rarity.one,
      );
}

extension RarityValues on Rarity {
  int get value {
    switch (this) {
      case Rarity.one:
        return 0;

      case Rarity.two:
        return 1;

      case Rarity.three:
        return 2;

      case Rarity.four:
        return 3;

      case Rarity.five:
        return 4;

      case Rarity.six:
        return 5;

      default:
        return 1;
    }
  }

  Color get color {
    switch (this) {
      case Rarity.one:
        return Colors.blueGrey;

      case Rarity.two:
        return const Color(0xFF9D9D9D);

      case Rarity.three:
        return const Color(0xFF4D7455);

      case Rarity.four:
        return const Color(0xFF8650AC);

      case Rarity.five:
        return const Color(0xFFFF8000);

      case Rarity.six:
        return const Color(0xFFAA0000);

      default:
        return Colors.black;
    }
  }
}