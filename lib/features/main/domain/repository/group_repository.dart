import 'package:campsite/core/error/failure.dart';
import 'package:campsite/features/main/domain/model/group.dart';
import 'package:dartz/dartz.dart';

abstract class GroupRepository {
  Future<Either<Failure, List<Group>>> getGroups();
}
