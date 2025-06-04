import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../utils/app_colors.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.title, required this.image,required this.isDark});
  final String title;
  final String image;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final localize = AppLocalizations.of(context);
    return  Expanded(
      child: Card(
        color: isDark?AppColors.riverBed:AppColors.azureRadiance,
        child: Column(
          children: [
            Image(image:AssetImage(image),fit: BoxFit.cover,width: 150,height: 150,),
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.alto50,
                    borderRadius: BorderRadiusDirectional.only(bottomStart: Radius.circular(12),bottomEnd: Radius.circular(12))
                ),child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(localize.translate(title),style: textTheme.titleSmall?.copyWith(color: isDark? AppColors.mirage:AppColors.white),),
            ))
          ],
        ),
      ),
    );
  }
}
