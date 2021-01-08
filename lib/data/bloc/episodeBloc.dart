import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/disposable.dart';

class EpisodeBloc extends Disposable {
  BehaviorSubject _episodes = GetIt.instance.get(instanceName: 'Episodes');

  Stream<List> get episodesStream => _episodes.map((event) => event);

  @override
  void dispose() {
    _episodes.close();
  }
}
