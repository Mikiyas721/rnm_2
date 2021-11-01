import 'package:flutter/material.dart';
import 'package:rnm/utils/disposable.dart';

class Provider<T> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, this.bloc}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.bloc;
  }
}

class BlocProvider<T extends Disposable> extends StatefulWidget {
  final T Function() blocSource;
  final T Function(T) onInit;
  final T Function(T) onDispose;
  final Function(BuildContext context, T bloc) builder;

  BlocProvider({
    @required this.blocSource,
    @required this.builder,
    this.onInit,
    this.onDispose,
  });

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Disposable> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocSource();
    widget.onInit?.call(bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(bloc: bloc, child: widget.builder(context, bloc));
  }

  @override
  void dispose() {
    //bloc.dispose();
    widget.onDispose?.call(bloc);
    super.dispose();
  }
}
