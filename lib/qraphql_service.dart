import 'package:graphql_demo/qraphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'country_model.dart';

class GraphQlService {
  static GraphQlConfig graphQlConfig = GraphQlConfig();
  GraphQLClient client = graphQlConfig.clientToQuery();

  Future<List<CountryModel>> getCountries({required String continentCode}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
          query Query(\$code: ID!) {
                  
                continent(code: \$code) {
                  countries {
                    capital
                    awsRegion
                    code
                    currencies
                    currency
                    emoji
                    emojiU
                    name
                    native
                    phone
                  }
                }
              
              }
            """),
          variables: {
            'code': continentCode,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        List? countries = result.data?['continent']['countries'];

        if (countries == null || countries.isEmpty) {
          return [];
        }

        List<CountryModel> countryList = countries.map((book) => CountryModel.fromJson(book)).toList();

        return countryList;
      }
    } catch (error) {
      print(error);
      return [];
    }
  }
}
