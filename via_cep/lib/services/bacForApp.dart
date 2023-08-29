import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:via_cep/models/cep.dart';

class BackForAppService {
  static const keyApplicationId = 'WIelr53OcsZT5c8SpxWLlYY0iHEbca74KXBi0EG4';
  static const keyClientKey = '9PeyT1lOJ1rvZI43VVdfz3jlnHgdaN0SFfkyUJFP';
  static const keyParseServerUrl = 'https://parseapi.back4app.com';

  static dynamic backForInit() async {
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }

  Future<bool> addCep(Cep cep) async {
    try {
      var cepObject = ParseObject('CEP')
    ..set('cep', cep.cep)
    ..set('logradouro', cep.logradouro)
    ..set('complemento', cep.complemento)
    ..set('bairro', cep.bairro)
    ..set('localidade', cep.localidade)
    ..set('uf', cep.uf)
    ..set('ibge', cep.ibge)
    ..set('gia', cep.gia)
    ..set('ddd', cep.ddd)
    ..set('siafi', cep.siafi);

  await cepObject.save();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
        return false;
      }
    }
    return false;
  }

  Future<bool> cepExist(Cep cep) async {
  QueryBuilder<ParseObject> queryCep =
      QueryBuilder<ParseObject>(ParseObject('CEP'))..whereEqualTo('cep', cep.cep);
  
  final ParseResponse parseResponse = await queryCep.query();
  
  if (parseResponse.success && parseResponse.results != null && parseResponse.results!.isNotEmpty) {
   
    return true;
  } else {

    return false;
  }
}

}
