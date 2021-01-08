import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/disposable.dart';

class CharacterBloc extends Disposable {
  BehaviorSubject _character = GetIt.instance.get(instanceName: 'Characters');
  BehaviorSubject _recentCharacters = GetIt.instance.get(instanceName: 'RecentCharacters');

  Stream<List> get characterStream => _character.map((event) => event);
  Stream<List> get recentCharacterStream => _recentCharacters.map((event) => event);

  @override
  void dispose() {
    _character.close();
    _recentCharacters.close();
  }
}
