import 'package:flutter/material.dart';

extension AddDirectionality on Widget {
  addDirectionality() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: this,
    );
  }
}
