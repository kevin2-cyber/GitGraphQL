import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
          description
        }
      }
    }
  }
""";

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(readRepositories),
          variables: const {
            'nRepositories': 50,
          },
          pollInterval: const Duration(seconds: 10),
        ),
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
          if(result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading');
          }

          List? repositories = result.data?['viewer']?['repositories']?['nodes'];

          if (repositories == null) {
            return const Text('No repositories');
          }

          return SafeArea(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast
              ),
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                final repository = repositories[index];
            
                return Card.outlined(
                  child: ListTile(
                      title: Text(
                      repository['name'] ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                    subtitle: Text(
                      repository['description'] ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
