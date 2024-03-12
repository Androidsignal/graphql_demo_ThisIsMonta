import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  final HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql',
  );

  GraphQLClient clientToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}


