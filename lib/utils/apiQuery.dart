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

  Future<QueryResult> getCharactersWithFilter(
      String prop, String enteredValue) {
    return _query("""
               query GetCharacters{
                 characters(filter: {$prop:"$enteredValue"}) {
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
                       episode{
                         id
                       }
                     }
                     created
                   }
                 }
               }
               """);
  }

  Future<QueryResult> getEpisodesWithFilter(String prop, String enteredValue) {
    return _query("""
               query GetEpisodes{
                 episodes(filter: {$prop:"$enteredValue"}) {
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
                       episode{
                         id
                       }
                     }
                     created
                   }
                 }
               }
               """);
  }

  Future<QueryResult> getLocations() {
    return _query("""
               query GetLocations{
                 locations {
                   results {
                     id
                     name
                     type
                     dimension
                     residents{
                       id
                       name
                       status
                       species
                       type
                       gender
                       image
                       created                  
                     }
                     created
                   }
                 }
               }
               """);
  }

  Future<QueryResult> getLocationsWithFilter(String prop, String enteredValue) {
    return _query("""
               query GetLocations{
                 locations(filter: {$prop:"$enteredValue"}) {
                   results {
                     id
                     name
                     type
                     dimension
                     residents{
                       id
                       name
                       status
                       species
                       type
                       gender
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
