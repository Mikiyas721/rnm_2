import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/apiQuery.dart';
import '../../utils/disposable.dart';

class EpisodeBloc extends Disposable {
  BehaviorSubject _episodes = GetIt.instance.get(instanceName: 'Episodes');
  APIQuery _api = GetIt.instance.get(instanceName: 'Api');

  Stream<List> get episodesStream => _episodes.map((event) => event);

  void loadEpisodes() async {
    _episodes.add((await _api.getEpisodes()).data['episodes']['results']);
  }

  @override
  void dispose() {
    _episodes.close();
  }
}
