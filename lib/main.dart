import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gitgraph/app.dart';
import 'package:gitgraph/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  // a better error screen
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
    color: Colors.greenAccent.shade100,
    child: Center(
      child: Text(
        details.exceptionAsString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontFamily: AppConstants.fontFamily),
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  await dotenv.load(fileName: AppConstants.filePath);

  String token = dotenv.get(AppConstants.token);

  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    AppConstants.baseUrl,
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer $token'
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore())
    ),
  );
  runApp(GraphQLProvider(client: client, child: const GitGraph()));
}