import 'package:dartz/dartz.dart';
import 'package:kt_dart/collection.dart';

import 'entities/item.dart';
import 'item_failure.dart';

abstract class ItemRepository {
  Future<Either<ItemFailure, Unit>> fetchAndSaveItems();

  Future<Either<ItemFailure, KtList<Item>>> loadItems();
}
