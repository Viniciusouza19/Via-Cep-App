import 'package:dio/dio.dart';
import 'package:via_cep/services/ICepApi.dart';

class ViaCepApi  implements CepApi{
  final Dio _dio = Dio();

  @override
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
