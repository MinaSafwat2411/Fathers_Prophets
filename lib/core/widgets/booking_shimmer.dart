import 'package:flutter/material.dart';

import 'event_shimmer_item.dart';

class BookingShimmer extends StatelessWidget {
  const BookingShimmer({super.key,required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => EventShimmerItem(isDark: isDark,),
        separatorBuilder: (context, index) => const SizedBox(height: 15,),
        itemCount: 3);
  }
}
