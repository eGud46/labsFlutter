import 'package:flutter/material.dart';

PreferredSizeWidget MyAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 2,
      toolbarHeight: 72,
      leading: Image(
        image: AssetImage('assets/Images/menu.jpg'),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: Image(
                image: AssetImage('assets/Images/mobile.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Image(
                image: AssetImage('assets/Images/Avatar.png'),
              ),
            )
          ],
        )
      ]
    );
}

