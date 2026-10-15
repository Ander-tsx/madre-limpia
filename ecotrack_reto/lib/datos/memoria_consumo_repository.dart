import 'package:ecotrack_reto/datos/consumo_repository.dart';
import 'package:ecotrack_reto/dominio/consumo.dart';

class MemoriaConsumoRepository implements ConsumoRepository {
  final List<Consumo> _consumos = [];

  @override
  Future<void> guardar(Consumo consumo) async {
    _consumos.add(consumo);
  }

  @override
  Future<List<Consumo>> listarPorLaboratorio(String laboratorio) async {
    return _consumos.where((c) => c.laboratorio == laboratorio).toList();
  }
}
