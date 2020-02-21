import 'package:mobx/mobx.dart';

part 'fav_store.g.dart';

class FavStore = _FavStore with _$FavStore;

abstract class _FavStore with Store {

  List<Object> repository;
  _FavStore(repository);


  @override
  void dispose() {}
}
