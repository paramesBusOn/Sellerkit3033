// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

AppBar appbar(String titles,GlobalKey<ScaffoldState> key,ThemeData theme,BuildContext context){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       
      GestureDetector(
      onTap: (){
      //  print("object");
       key.currentState?.openDrawer();
      },
      child: Icon(Icons.menu,
      color: theme.primaryColor,
      )),
      
        Container(child: Text(titles,
        style:theme.textTheme.headline6?.copyWith(color: theme.primaryColor,fontWeight: FontWeight.normal),
        ),),
        Container(
          width: Screens.width(context)*0.15,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
         // color: Colors.red  
          ),
          child: Image.asset("Assets/SellerSymbol.png", fit: BoxFit.fill,),),
      ],
    ),
  );
}