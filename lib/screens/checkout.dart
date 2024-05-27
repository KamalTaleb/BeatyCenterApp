import 'package:beauty_center/billing_address_section.dart';
import 'package:beauty_center/billing_amount_section.dart';
import 'package:beauty_center/billing_payment_section.dart';
import 'package:beauty_center/coupon_widget.dart';
import 'package:beauty_center/custom/appBar/appbar.dart';
import 'package:beauty_center/custom/common/services/cart/cart_Items.dart';
import 'package:beauty_center/helper_functions.dart';
import 'package:beauty_center/rounded_container.dart';
import 'package:beauty_center/screens/cart.dart';
import 'package:flutter/material.dart';

class SCheckoutScreen extends StatelessWidget {
  const SCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: SAppbar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SCartScreen()),
          );
        },
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: 32.0,
              ),
              const SCoupon(),
              const SizedBox(
                height: 32.0,
              ),
              SRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(8.0),
                backgroundColor: dark ? Colors.black : Colors.white,
                child: const Column(
                  children: [
                    SBillingAmountSection(),
                    SizedBox(
                      height: 16.0,
                    ),
                    Divider(),
                    SizedBox(
                      height: 16.0,
                    ),
                    SBillingPaymentSection(),
                    SizedBox(
                      height: 16.0,
                    ),
                    SBillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
