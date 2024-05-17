import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

import '../../../Controller/EarningController/EarningController.dart';

class MoneyWidget extends StatelessWidget {
   MoneyWidget({
    Key? key,
    required this.theme,
     required this.prdern
  }) : super(key: key);

  final ThemeData theme;
  EarningController prdern;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Screens.bodyheight(context)*0.02,
          horizontal: Screens.width(context)*0.06
        ),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(5)
        ),
        width: Screens.width(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    child: Text("Month to date", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)
         // Colors.white60
                 ),
                  ),
                  SizedBox(height: Screens.bodyheight(context)*0.01,),
                   Container(
              child: Text( "₹ ${prdern.getearningData1!.monthEarning.toString()}",
                // context.watch<EarningController>().getearningData1[0].monthEarning.toString()}",
                style: theme.textTheme.subtitle1?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
            )
                ],
              ),
            ),

  Container(
    height: Screens.bodyheight(context)*0.07 ,
  decoration:  BoxDecoration(border: Border.all(
                    color: Colors.white60)),
  ),
          //  SizedBox(width: Screens.bodyheight(context)*0.02,),
              Container(
              child: Column(
                children: [
                  Container(
                    child: Text("Today Earnings",
                     style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)
                  ),
                  ),
                  SizedBox(height: Screens.bodyheight(context)*0.01,),
                   Container(
              child: Text( "₹ ${prdern.getearningData1!.todayEarning.toString()}",  style: theme.textTheme.subtitle1?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
             ),
            )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}