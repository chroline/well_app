import 'package:flutter/cupertino.dart';

class Unfocuser extends StatelessWidget {
  final Widget child;

  const Unfocuser(this.child);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: child,
      );
}
