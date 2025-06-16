import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../Theme/theme_controller.dart';
import '../../widgets/Build_drug_type.dart';
import '../../widgets/build_Companies.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        backgroundColor: themeController.isDarkMode.value?AppColors.dark:AppColors.backgroundHome,
        //backgroundColor:AppColors.backgroundHome,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.height*0.02,
                top: MediaQuery.of(context).size.height*0.01,
              ),
              child: Text("Companies".tr, style: TextStyle(fontSize: MediaQuery.textScalerOf(context).scale(18)
                , fontWeight: FontWeight.bold,color: themeController.isDarkMode.value?AppColors.white:AppColors.black,
              )),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BuildCompanies(image:'assets/images/Tam.jpg',title:"TAMICO"),
                  BuildCompanies(image:'assets/images/alphapharma.png',title:"Alpha Pharma"),
                  BuildCompanies(image:'assets/images/dimapharma.jpeg',title:"Dima Pharma"),
                  BuildCompanies(image:'assets/images/ibnalhaytham.jpeg',title:"Ibn Al Haytham"),
                  BuildCompanies(image:'assets/images/unipharma.png',title:"Uni pharma"),
                  BuildCompanies(image:'assets/images/alradwanpharma.png',title:"Al Radwan Pharma"),
                  BuildCompanies(image:'assets/images/pharmainternational.jpeg',title:"Pharma International"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.height*0.02,
              ),
              child: Text("Drug_Types".tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: themeController.isDarkMode.value?AppColors.white:AppColors.black,)),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*0.15,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BuildDrugType(image:"assets/images/logo.jpg" , titleType:"حب"),
                  BuildDrugType(image:"assets/images/logo.jpg" , titleType:"إبر"),
                  BuildDrugType(image:"assets/images/logo.jpg" , titleType:"شراب"),
                  BuildDrugType(image:"assets/images/logo.jpg" , titleType:"مرهم"),
                  BuildDrugType(image:"assets/images/logo.jpg" , titleType:"بخاخ"),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.height*0.02,
                top: MediaQuery.of(context).size.height*0.02,
              ),
              child: Text("View_All".tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: themeController.isDarkMode.value?AppColors.white:AppColors.black,)),
            ),
            Expanded(
              //height: MediaQuery.of(context).size.height*0.423,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height*0.01,
                      bottom: MediaQuery.of(context).size.height*0.01,
                    ),
                    child: Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                        ) ,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Paracetamol",style: TextStyle(color: AppColors.black),),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("باراسيتامول",style: TextStyle(color: AppColors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Type:pill",style: TextStyle(color: AppColors.black),),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("600"),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("اسم الشركة",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("800"),
                                      )
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height*0.01,
                      bottom: MediaQuery.of(context).size.height*0.01,
                    ),
                    child: Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                        ) ,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Paracetamol",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("باراسيتامول",style: TextStyle(color: AppColors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Type:pill",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("600"),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("اسم الشركة",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("800"),
                                      )
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height*0.01,
                      bottom: MediaQuery.of(context).size.height*0.01,
                    ),
                    child: Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                        ) ,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Paracetamol",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("باراسيتامول",style: TextStyle(color: AppColors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Type:pill",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("600"),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("اسم الشركة",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("800"),
                                      )
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height*0.01,
                      bottom: MediaQuery.of(context).size.height*0.01,
                    ),
                    child: Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                        ) ,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Paracetamol",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("باراسيتامول",style: TextStyle(color: AppColors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Type:pill",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("600"),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("اسم الشركة",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("800"),
                                      )
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )

                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.height*0.01,
                      bottom: MediaQuery.of(context).size.height*0.01,
                    ),
                    child: Container(
                        decoration:BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10),
                        ) ,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Paracetamol",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("باراسيتامول",style: TextStyle(color: AppColors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("Type:pill",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("600"),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Text("اسم الشركة",style: TextStyle(color: AppColors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                                  child: Container(
                                      decoration:BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:BorderRadius.circular(10),
                                      ) ,
                                      child: Padding(
                                        padding:  EdgeInsets.only(
                                            left:MediaQuery.of(context).size.width * 0.02,
                                            right: MediaQuery.of(context).size.width * 0.02
                                        ),
                                        child: Text("800"),
                                      )
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )

                    ),
                  ),




                ],
              ),
            )
          ],
        ),
      );
    });
  }














}

