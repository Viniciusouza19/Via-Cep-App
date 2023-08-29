import 'package:via_cep/models/cep.dart';
import 'package:via_cep/models/cepJsonConvert.dart';
import 'package:via_cep/services/bacForApp.dart';
import 'package:via_cep/services/viaCepApi.dart';

class CepRepository {
  Future<Cep?> getCep(ViaCepApi api, String cep) async {
    BackForAppService back = BackForAppService();
    
    Map<String, dynamic>? cepMap = await api.fetchCepData(cep);
    
    if (cepMap != null && cepMap['erro'] != true) {
      bool cepExistsInBackForApp = await back.cepExist(CepJsonConverter.fromJson(cepMap));
      
      if (!cepExistsInBackForApp) {
        back.addCep(CepJsonConverter.fromJson(cepMap));
      }
      
      return CepJsonConverter.fromJson(cepMap);
    } else {
      return null;
    }
  }
}
