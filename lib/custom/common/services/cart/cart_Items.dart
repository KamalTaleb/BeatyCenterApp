import 'package:beauty_center/custom/common/services/cart/add_remove_button.dart';
import 'package:beauty_center/custom/common/services/cart/cart_item.dart';
import 'package:beauty_center/service_price_text.dart';
import 'package:flutter/material.dart';

class SCartItems extends StatelessWidget {
  const SCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(
        height: 32.0,
      ),
      itemCount: 2,
      itemBuilder: (_, index) => Column(
        children: [
          const SCartItem(),
          if (showAddRemoveButtons)
            const SizedBox(
              height: 32.0,
            ),
          if (showAddRemoveButtons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    SServicesQuantityWithAddRemoveButton(),
                  ],
                ),
              ],
            ),
          SServicePriceText(
            price: '213',
          ),
        ],
      ),
    );
  }
}
