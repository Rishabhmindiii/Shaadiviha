
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'ColorConst.dart';
import 'Injection.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:   SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            spacing: 10,
            children: [

              Container(
                height: 50.sp,
                width: 100.w,
                color: DI<ColorConst>().secondColorPrimary,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.0),
                                child: Container(
                                  height: 45.sp,
                                  color:DI<ColorConst>().secondColorPrimary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 7,
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 100.w,
                                    color: DI<ColorConst>().secondColorPrimary,
                                  ),

                                  SizedBox(
                                    height:3,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(color: DI<ColorConst>().whiteColor,
                                              borderRadius: BorderRadius.only(topLeft:Radius.circular(7.0),bottomLeft: Radius.circular(7.0))),
                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),

                                        ),
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(color: DI<ColorConst>().whiteColor,
                                              borderRadius: BorderRadius.only(topRight:Radius.circular(7.0),bottomRight: Radius.circular(7.0))),
                                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),

                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:3,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 100.w,
                                    color: DI<ColorConst>().secondColorPrimary,
                                  ),
                                  SizedBox(
                                    height:3,
                                  ),
                                  Container(
                                    height: 10,
                                    width:50.w,
                                    color: DI<ColorConst>().secondColorPrimary,
                                  ),
                                ],
                              )
                          )

                        ],
                      ),
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),

                    ],
                  );
                },)

            ],
          ),
        )
    );
  }
}