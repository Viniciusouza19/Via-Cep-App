import 'package:flutter/material.dart';
import 'package:via_cep/models/cep.dart';
import 'package:via_cep/services/bacForApp.dart';
import 'package:via_cep/services/viaCepApi.dart';
import '../repository/cepRepository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ViaCepApi viaCepApi = ViaCepApi();
  final CepRepository cepRepository = CepRepository();
  final BackForAppService backForAppService = BackForAppService();

  TextEditingController cepController = TextEditingController();
  Cep? cepDetails;
  String? addedToBackForApp;
  bool isLoading = false;

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  Future<void> fetchCepDetails() async {
    setState(() {
      isLoading = true;
    });

   String cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
Cep? fetchedCep = await cepRepository.getCep(viaCepApi, cep);

bool existsInBackForApp = false;
if (fetchedCep != null) {
  existsInBackForApp = await backForAppService.cepExist(fetchedCep);
}

if (fetchedCep == null) {
  setState(() {
    cepDetails = null;
    addedToBackForApp = 'CEP não encontrado';
    isLoading = false;
  });
} else {
  setState(() {
    cepDetails = fetchedCep;
    addedToBackForApp = existsInBackForApp
        ? 'CEP já existe em backForApp'
        : 'CEP adicionado em backForApp';
    isLoading = false;
  });
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CepInfoTable(cepDetails, addedToBackForApp),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Digite o CEP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading ? null : fetchCepDetails,
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Buscar CEP'),
            ),
          ],
        ),
      ),
    );
  }
}

class CepInfoTable extends StatelessWidget {
  final Cep? cepDetails;
  final String? addedToBackForApp;

  const CepInfoTable(this.cepDetails, this.addedToBackForApp, {super.key});

  @override
  Widget build(BuildContext context) {
    return (cepDetails != null || addedToBackForApp != null)
        ? Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informações do CEP:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                if (addedToBackForApp != null)
                  Text(
                    addedToBackForApp!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                if (cepDetails != null) ...[
                  const SizedBox(height: 8.0),
                  Text('CEP: ${cepDetails!.cep}'),
                  Text('Logradouro: ${cepDetails!.logradouro}'),
                  Text('Complemento: ${cepDetails!.complemento}'),
                  Text('Bairro: ${cepDetails!.bairro}'),
                  Text('Cidade: ${cepDetails!.localidade}'),
                  Text('Estado: ${cepDetails!.uf}'),
                  Text('IBGE: ${cepDetails!.ibge}'),
                  Text('GIA: ${cepDetails!.gia}'),
                  Text('DDD: ${cepDetails!.ddd}'),
                  Text('SIAFI: ${cepDetails!.siafi}'),
                ],
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
