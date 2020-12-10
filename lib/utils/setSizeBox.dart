import 'package:flutter/cupertino.dart';

class setSizeBox extends StatelessWidget {
  double h;

  setSizeBox(this.h);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}
