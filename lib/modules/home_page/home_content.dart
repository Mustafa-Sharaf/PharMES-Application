/*
import 'package:flutter/material.dart';
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffDCE0E9),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.99,
            decoration:BoxDecoration(
              color: Colors.white,
              borderRadius:BorderRadius.circular(10),
            ) ,

          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

import '../../helpers/Build_drug_type.dart';
import '../../helpers/build_Companies.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffDCE0E9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 5,bottom: 5),
                   child: Text("Companies", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.height*0.13,
                   child: ListView(
                     scrollDirection: Axis.horizontal,
                     children: [
                       BuildCompanies(image:'assets/images/tamico.jpeg',title:"TAMICO"),
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
                   padding: const EdgeInsets.only(top: 5,bottom: 5),
                   child: Text("Drug Types", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 ),
                 SizedBox(
                   //color: Colors.cyanAccent,
                   height:MediaQuery.of(context).size.height*0.12,
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
                   padding: const EdgeInsets.only(top: 10,bottom: 5),
                   child: Text("View All", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.43,
                   child: ListView(
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: Container(
                             height:MediaQuery.of(context).size.height*0.153,
                             width: MediaQuery.of(context).size.width*0.99,
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Paracetamol"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("باراسيتامول"),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Type:pill"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.green,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("اسم الشركة"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.red,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                             child: Text("800"),
                                           )
                                       ),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   height:MediaQuery.of(context).size.height*0.026,
                                   width: MediaQuery.of(context).size.width*0.99,
                                   decoration:BoxDecoration(
                                     color: Color(0xff059FFF),
                                     borderRadius:BorderRadius.circular(10),
                                   ) ,
                                   child: Center(
                                     child: Text("البدائل"),
                                   ),
                                 )
                               ],
                             )

                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: Container(
                             height:MediaQuery.of(context).size.height*0.153,
                             width: MediaQuery.of(context).size.width*0.99,
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Paracetamol"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("باراسيتامول"),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Type:pill"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.green,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("اسم الشركة"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.red,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                             child: Text("800"),
                                           )
                                       ),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   height:MediaQuery.of(context).size.height*0.026,
                                   width: MediaQuery.of(context).size.width*0.99,
                                   decoration:BoxDecoration(
                                     color: Color(0xff00D2FF),
                                     borderRadius:BorderRadius.circular(10),
                                   ) ,
                                   child: Center(
                                     child: Text("البدائل"),
                                   ),
                                 )
                               ],
                             )

                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: Container(
                             height:MediaQuery.of(context).size.height*0.153,
                             width: MediaQuery.of(context).size.width*0.99,
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Paracetamol"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("باراسيتامول"),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Type:pill"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.green,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("اسم الشركة"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.red,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                             child: Text("800"),
                                           )
                                       ),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   height:MediaQuery.of(context).size.height*0.026,
                                   width: MediaQuery.of(context).size.width*0.99,
                                   decoration:BoxDecoration(
                                     color: Color(0xff01ECFF),
                                     borderRadius:BorderRadius.circular(10),
                                   ) ,
                                   child: Center(
                                     child: Text("البدائل"),
                                   ),
                                 )
                               ],
                             )

                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: Container(
                             height:MediaQuery.of(context).size.height*0.153,
                             width: MediaQuery.of(context).size.width*0.99,
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Paracetamol"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("باراسيتامول"),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Type:pill"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.green,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("اسم الشركة"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.red,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                             child: Text("800"),
                                           )
                                       ),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   height:MediaQuery.of(context).size.height*0.026,
                                   width: MediaQuery.of(context).size.width*0.99,
                                   decoration:BoxDecoration(
                                     color: Color(0xff7288cb),
                                     borderRadius:BorderRadius.circular(10),
                                   ) ,
                                   child: Center(
                                     child: Text("البدائل"),
                                   ),
                                 )
                               ],
                             )

                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(bottom: 5),
                         child: Container(
                             height:MediaQuery.of(context).size.height*0.153,
                             width: MediaQuery.of(context).size.width*0.99,
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Paracetamol"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("باراسيتامول"),
                                     ),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("Type:pill"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.green,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
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
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text("اسم الشركة"),
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           decoration:BoxDecoration(
                                             color: Colors.red,
                                             borderRadius:BorderRadius.circular(10),
                                           ) ,
                                           child: Padding(
                                             padding: const EdgeInsets.only(left: 8,right: 8),
                                             child: Text("800"),
                                           )
                                       ),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   height:MediaQuery.of(context).size.height*0.026,
                                   width: MediaQuery.of(context).size.width*0.99,
                                   decoration:BoxDecoration(
                                     color: Color(0xff7288cb),
                                     borderRadius:BorderRadius.circular(10),
                                   ) ,
                                   child: Center(
                                     child: Text("البدائل"),
                                   ),
                                 )
                               ],
                             )

                         ),
                       ),

                     ],
                   ),
                 )

              ],
            ),
          ),
        ),
      ),
    );
  }














}

