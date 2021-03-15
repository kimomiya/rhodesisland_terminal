import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/dtos/existence_dto.dart';
import '../dtos/item_dto.dart';

const _tableName = ItemDto.tableName;

abstract class ItemLocalDataSource {
  Future<void> saveAll(List<ItemDto> items);

  Future<List<ItemDto>> loadAll();
}

@LazySingleton(as: ItemLocalDataSource)
class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  const ItemLocalDataSourceImpl(
    this._db,
  );

  final Database _db;

  @override
  Future<void> saveAll(List<ItemDto> items) async {
    final batch = _db.batch();

    for (final item in items) {
      batch.execute(
        '''
        REPLACE INTO $_tableName (
          itemId, itemType, name, name_i18n,
          alias, pron, existence, rarity,
          addTimePoint, spriteCoord, groupId, sortId
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''',
        <dynamic>[
          item.itemId,
          item.itemType,
          item.name,
          jsonEncode(item.nameI18n),
          jsonEncode(item.alias),
          jsonEncode(item.pron),
          _transferExistence(item.existence),
          item.rarity,
          item.addTimePoint,
          jsonEncode(item.spriteCoord),
          item.groupId,
          item.sortId,
        ],
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<List<ItemDto>> loadAll() async {
    final results = await _db.query(_tableName, orderBy: 'sortId');

    final dtos = <ItemDto>[];
    for (final data in results) {
      dtos.add(ItemDto.fromQueryResult(data));
    }
    return dtos;
  }

  //* Helper Methods

  String _transferExistence(Map<String, ExistenceDto>? existence) {
    final map = <String, dynamic>{};
    existence?.forEach((key, value) => map[key] = value.toJson());
    return jsonEncode(map);
  }
}
