import 'package:flutter/material.dart';

import '../../../../constant/constant.dart';
import '../../../home/components/components.dart';

PreferredSizeWidget customAppBar(String title){
  return AppBar(
        iconTheme: const IconThemeData(
          color: textColor,
        ),
        elevation: 0,
        // shadowColor:grey,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: customText(
          title,
          textColor,
          16,
          FontWeight.w700,
        ),
      );
}