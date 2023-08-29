import 'package:dio/dio.dart';

class ViaCepApi {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> fetchCepData(String cep) async {
    try {
      final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Erro na resposta da API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro na chamada da API: $e');
      return null;
    }
  }

}
