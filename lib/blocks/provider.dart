import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocks/login_Bloc.dart';

export 'package:flutter_application_1/blocks/login_Bloc.dart';

class ProviderLogin extends InheritedWidget {
  static ProviderLogin _instancia;

  factory ProviderLogin({Key key, Widget child}) {
    _instancia ??= ProviderLogin._internal(key: key, child: child);

    return _instancia;
  }

  ProviderLogin._internal({Key key, Widget child})
      : super(key: key, child: child);

  final loginBloc = LoginBloc();

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderLogin>()
        .loginBloc;
  }
}
