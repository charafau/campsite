import 'package:campsite/core/error/failure.dart';
import 'package:campsite/features/main/data/datasource/group_remote_data_source.dart';
import 'package:campsite/features/main/data/dto/group_dto.dart';
import 'package:campsite/features/main/domain/model/group.dart';
import 'package:campsite/features/main/domain/repository/group_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Group>>> getGroups() async {
    try {
      final List<GroupDto> groupsDto = await remoteDataSource.getGroups();

      return Right(groupsDto.map((d) => Group.fromDto(d)).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
