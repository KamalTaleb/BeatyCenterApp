import 'package:beauty_center/service_title_text.dart';
import 'package:flutter/material.dart';

class SCartItem extends StatelessWidget {
  const SCartItem({
    super.key,
    required this.serviceName,
    required this.staffName,
  });

  final String serviceName;
  final String? staffName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: SServiceTitleText(
                  title: serviceName,
                  maxLines: 1,
                ),
              ),
              Text(
                'Staff: ${staffName ?? 'Not selected'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
