import 'package:graphql/client.dart';

class APIQuery {
  GraphQLClient _client;

  APIQuery()
      : _client = GraphQLClient(
          cache: InMemoryCache(),
          link: HttpLink(
            uri: 'https://rickandmortyapi.com/graphql',
          ),
        );

  Future<QueryResult> _query(String query) async =>
      await _client.query(QueryOptions(
        documentNode: gql(query),
      ));

  Future<QueryResult> getCharacters() {
    return _query("""
               query GetCharacters{
                 characters {
                   results {
                     id
                     name
                     status
                     species
                     type
                     gender
                     origin{
                       id
                       name
                     }
                     location{
                       id
                       name
                     }
                     image
                     episode{
                       id
                       name
                       air_date
                       episode
                       characters{
                         id
                         name
                         image
                       }
                       created
                     }
                     created
                   }
                 }
               }
               """);
  }
  Future<QueryResult> getEpisodes() {
    return _query("""
               query GetEpisodes{
                 episodes {
                   results {
                     id
                     name
                     air_date
                     episode
                     characters{
                       id
                       name
                       status
                       species
                       type
                       gender
                       origin{
                         id
                         name
                       }
                       location{
                         id
                         name
                       }
                       image
                       created
                     }
                     created
                   }
                 }
               }
               """);
  }
}
