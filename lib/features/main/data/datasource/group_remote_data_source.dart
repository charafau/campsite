import 'package:campsite/features/main/data/datasource/group_rest_client.dart';
import 'package:campsite/features/main/data/dto/group_dto.dart';

abstract class GroupRemoteDataSource {
  Future<List<GroupDto>> getGroups();
}

class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final GroupRestClient restClient;

  GroupRemoteDataSourceImpl(this.restClient);

  @override
  Future<List<GroupDto>> getGroups() async {
    final List<GroupDto> response = await restClient.getGroups();
    return response;
  }
}
