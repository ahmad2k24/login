import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final double topLeft, topRight, bottomLeft, bottomRight;
  final VoidCallback onTap;

  const CustomTile({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
      child: Stack(
        children: [
          // The container (background)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 1, ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight),
                bottomLeft: Radius.circular(bottomLeft),
                bottomRight: Radius.circular(bottomRight),
              ),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(leading,
                        color: CupertinoColors.activeBlue), // Leading Icon
                    const SizedBox(width: 12), // Spacing between icon and title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.black,
                      ),
                    ), // Title Text
                  ],
                ),
                const Icon(
                  CupertinoIcons.chevron_forward,
                  color: CupertinoColors.systemGrey, // Trailing Icon
                ),
              ],
            ),
          ),
          // InkWell (above the container, captures taps and shows the ripple effect)
          Material(
            color: Colors
                .transparent, // Transparent background for the ripple effect
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight),
                bottomLeft: Radius.circular(bottomLeft),
                bottomRight: Radius.circular(bottomRight),
              ),
              splashColor: Colors.blue.withOpacity(0.2),
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 1,),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(topLeft),
                    topRight: Radius.circular(topRight),
                    bottomLeft: Radius.circular(bottomLeft),
                    bottomRight: Radius.circular(bottomRight),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
