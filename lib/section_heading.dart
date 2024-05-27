import 'package:flutter/material.dart';

class SSectionHeading extends StatelessWidget {
  const SSectionHeading(
      {super.key,
      this.onPressed,
      this.textColor,
      this.buttonTitle = "View all",
      required this.title,
      this.showActivityButton = true});

  final Color? textColor;
  final bool showActivityButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActivityButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
