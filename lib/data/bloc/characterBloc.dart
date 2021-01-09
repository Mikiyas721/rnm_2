import 'package:get_it/get_it.dart';
import 'package:rnm/utils/apiQuery.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/disposable.dart';

class CharacterBloc extends Disposable {
  BehaviorSubject<List> _character =
      GetIt.instance.get(instanceName: 'Characters');
  BehaviorSubject<List> _recentCharacters =
      GetIt.instance.get(instanceName: 'RecentCharacters');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');

  Stream<List> get characterStream => _character.map((event) => event);

  Stream<List> get recentCharacterStream =>
      _recentCharacters.map((event) => event);

  void loadCharacters() async {
    _character.add((await _api.getCharacters()).data['characters']['results']);
  }

  @override
  void dispose() {
    _character.close();
    _recentCharacters.close();
  }
}
