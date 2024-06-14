
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';


class ShowSearchDialog extends StatefulWidget {
  ShowSearchDialog({Key? key}) : super(key: key);
  @override
  State<ShowSearchDialog> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<ShowSearchDialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
            content:  Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context)*0.5,
              child: Column(
                children: [
                   TextFormField(
                           // controller:  context.read<PriceListController>().mycontroller[0],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required *";
                              }
                              return null;
                            },
                             onChanged: (v) {
                                setState(() {
                      // context.read<NewEnqController>().filterListcatagoryData(v);
                                });
                              },
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(),
                              suffixIcon:
                               InkWell(
                                 onTap: (){
                                 
                                 },
                                 child: Icon(Icons.search,color: theme.primaryColor))
                            )),

                  // Expanded(child: ListView.builder(
                  //   itemCount:context.watch<NewEnqController>().filtercatagorydata.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return InkWell(
                  //       onTap: (){
                  //          context.read<NewEnqController>().iscateSeleted(context,
                  //          context.read<NewEnqController>().filtercatagorydata[index]
                  //          );  
                  //       },
                  //       child: Container(
                  //         width: Screens.width(context),
                  //         padding: EdgeInsets.all(5),
                  //         child: Container(
                  //           alignment: Alignment.centerLeft,
                  //         width: Screens.width(context),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 context.watch<NewEnqController>().filtercatagorydata[index]
                  //               ),
                  //               Divider()
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),)
                ],
              ),
            )
              ,
     );
  }
}