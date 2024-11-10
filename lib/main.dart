import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'services/news_service.dart';

void main() async{

  runApp(const NewsApp());
  //await NewsSerivce(Dio()).getGeneralNews(); for debugging purposes
}

class NewsApp extends StatelessWidget{
  const NewsApp();




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );


  }





}