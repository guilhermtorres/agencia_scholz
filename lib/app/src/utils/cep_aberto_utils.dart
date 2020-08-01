import 'dart:io';

import 'package:agencia_scholz/app/src/models/cep_aberto_address_model.dart';
import 'package:dio/dio.dart';

const token = '84b5ce3dbf6d29e837e51617dc9edce9';

class CepAbertoUtils {
  Future<CepAbertoAddress> getAdressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }
      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);
      return address;
      // ignore: unused_catch_clause
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
