import 'package:flutter/material.dart';

class CommandsContainer extends StatelessWidget {
  final String title;
  final String description;
  final Color backgroundColor;
  final Color fontColor;

  const CommandsContainer({
    Key? key,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, bottom: 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: fontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
