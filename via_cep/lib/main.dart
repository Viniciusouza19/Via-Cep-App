import 'package:flutter/material.dart';
import 'package:via_cep/pages/home.page.dart';
import 'package:via_cep/repository/cepRepository.dart';
import 'package:via_cep/services/bacForApp.dart';
import 'package:via_cep/services/viaCepApi.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  BackForAppService.backForInit();
  CepRepository cepRepository = CepRepository();
  cepRepository.getCep(ViaCepApi(), '955522000');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      home: Scaffold(appBar: AppBar(title: Text('ASDAS'),),body: HomePage(),),
    );
  }
}