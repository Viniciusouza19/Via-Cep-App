import 'cep.dart';

class CepJsonConverter {
  static Cep fromJson(Map<String, dynamic> json) {
    return Cep(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],
    );
  }

  static Map<String, dynamic> toJson(Cep cep) {
    return {
      'cep': cep.cep,
      'logradouro': cep.logradouro,
      'complemento': cep.complemento,
      'bairro': cep.bairro,
      'localidade': cep.localidade,
      'uf': cep.uf,
      'ibge': cep.ibge,
      'gia': cep.gia,
      'ddd': cep.ddd,
      'siafi': cep.siafi,
    };
  }
}