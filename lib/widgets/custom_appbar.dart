import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
          bottomLeft: Radius.circular(70),
        ),
      ),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(70),
          bottomLeft: Radius.circular(70),
        ),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/EFXSes9UCfsyRVoNeQ2ZTB-1200-80.png.webp"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      title: const Text(
        "Gallery",
        style: TextStyle(
          fontFamily: 'JacquardaBastarda9-Regular',
          fontSize: 70,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}