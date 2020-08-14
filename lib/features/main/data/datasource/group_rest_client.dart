import 'package:campsite/features/main/data/dto/group_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'group_rest_client.g.dart';

@RestApi()
abstract class GroupRestClient {
  factory GroupRestClient(Dio dio, {String baseUrl}) = _GroupRestClient;

  @GET("")
  Future<List<GroupDto>> getGroups();
}
