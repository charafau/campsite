import 'package:campsite/core/app_config.dart';
import 'package:campsite/feature_injections.dart';
import 'package:dio/dio.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> initDependencies(AppFlavor appFlavor) async {
  final Dio dio = Dio();

  dio.interceptors.add(LogInterceptor(responseBody: true));
  dio.options.baseUrl =
      'https://haven-tech-test.s3-eu-west-1.amazonaws.com/tech+test+json.json';

  return injections(dio);
}
