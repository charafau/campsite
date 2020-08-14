import 'package:campsite/features/main/data/datasource/group_remote_data_source.dart';
import 'package:campsite/features/main/data/datasource/group_rest_client.dart';
import 'package:campsite/features/main/data/repository_impl/group_repository_impl.dart';
import 'package:campsite/features/main/domain/usecase/get_group_usecase.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> injections(Dio dio) {
  final groupRestClient = GroupRestClient(dio);
  final groupRemoteDataSource = GroupRemoteDataSourceImpl(groupRestClient);
  final groupRepository =
      GroupRepositoryImpl(remoteDataSource: groupRemoteDataSource);
  final getGroupUseCase = GetGroupsUseCase(groupRepository);

  return [
    Provider.value(value: getGroupUseCase),
  ];
}
