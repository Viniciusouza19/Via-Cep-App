import 'package:via_cep/models/cep.dart';
import 'package:via_cep/services/bacForApp.dart';
import 'package:via_cep/services/viaCepApi.dart';

class CepRepository {
  Future<Cep?> getCep(ViaCepApi api, String cep) async {
    BackForAppService back = BackForAppService();
    
    Map<String, dynamic>? cepMap = await api.fetchCepData(cep);
    
    if (cepMap != null && cepMap['erro'] != true) {
      bool cepExistsInBackForApp = await back.cepExist(Cep.fromJson(cepMap));
      
      if (!cepExistsInBackForApp) {
        back.addCep(Cep.fromJson(cepMap));
      }
      
      return Cep.fromJson(cepMap);
    } else {
      return null;
    }
  }
}
