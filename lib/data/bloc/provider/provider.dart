import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, this.bloc}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static T of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.bloc;
  }
}

class BlocProvider<T> extends StatelessWidget {
  final T Function() blocSource;
  final Function(BuildContext context, T bloc) builder;

  BlocProvider({@required this.builder, @required this.blocSource});

  @override
  Widget build(BuildContext context) {
    return Provider(child: builder(context, blocSource()), bloc: blocSource());
  }
}
