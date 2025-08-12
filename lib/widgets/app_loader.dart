import 'package:flutter/material.dart';

///Common Button Loader
class AppBoxLoader extends StatelessWidget {

  final double? top;
  final double? bottom;
  const AppBoxLoader({
    super.key,
    this.top,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0),
      child:  SizedBox(
        height: 48,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color:  Theme.of(context).primaryColor
          ),
        ),
      ),
    );
  }
}
