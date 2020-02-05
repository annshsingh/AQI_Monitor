import 'package:flutter/material.dart';

import 'bloc.dart';

///We use [BlocProvider] to inject the BloCs in the widget tree
///In simple terms A provider is a widget that stores data and well,
///“provides” it to all its children.

///Here: The generic type [T] is scoped to be an object that implements the
///[Bloc] interface. This means that the provider can only store BLoC objects.
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  ///This method allows widgets to retrieve the BlocProvider from a descendant
  ///in the widget tree with the current build context.
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  ///The only reason why the [BlocProvider] inherits from [StatefulWidget] is to get
  ///access to the [dispose] method. When this widget is removed from the tree,
  ///Flutter will call the dispose method, which will in turn, close the stream.
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
