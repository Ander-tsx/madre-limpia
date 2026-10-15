import 'package:ecotrack_reto/dominio/consumo.dart';

abstract class ConsumoRepository {
  Future<void> guardar(Consumo consumo);
  Future<List<Consumo>> listarPorLaboratorio(String laboratorio);
}
