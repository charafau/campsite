import 'package:campsite/core/error/failure.dart';
import 'package:campsite/features/main/domain/model/group.dart';
import 'package:campsite/features/main/domain/repository/group_repository.dart';
import 'package:dartz/dartz.dart';

class GetGroupsUseCase {
  final GroupRepository repository;

  GetGroupsUseCase(this.repository);

  Future<Either<Failure, List<Group>>> call() async =>
      await repository.getGroups();
}

    