import 'package:ecotrack_reto/datos/consumo_repository.dart';
import 'package:ecotrack_reto/datos/consumo_service.dart';
import 'package:ecotrack_reto/dominio/consumo.dart';

class NubeConsumoRepository implements ConsumoRepository {
  NubeConsumoRepository(this._service);

  final ConsumoService _service;

  @override
  Future<void> guardar(Consumo consumo) {
    return _service.post({
      'laboratorio': consumo.laboratorio,
      'litros': consumo.litros,
      'fecha': consumo.fecha.toIso8601String(),
    });
  }

  @override
  Future<List<Consumo>> listarPorLaboratorio(String laboratorio) async {
    final filas = await _service.get(laboratorio);
    return filas
        .map(
          (j) => Consumo(
            laboratorio: j['laboratorio']! as String,
            litros: (j['litros']! as num).toDouble(),
            fecha: DateTime.parse(j['fecha']! as String),
          ),
        )
        .toList();
  }
}
