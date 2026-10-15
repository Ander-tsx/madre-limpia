import 'package:ecotrack_reto/datos/consumo_repository.dart';
import 'package:ecotrack_reto/dominio/consumo.dart';
import 'package:ecotrack_reto/dominio/regla_consumo.dart';
import 'package:flutter/foundation.dart';

class RegistroViewModel extends ChangeNotifier {
  RegistroViewModel(this._repositorio, {DateTime Function()? reloj})
      : _reloj = reloj ?? DateTime.now;

  final ConsumoRepository _repositorio;
  final DateTime Function() _reloj;

  String laboratorio = laboratoriosUtez.first;
  bool cargando = false;
  String? error;
  List<Consumo> historial = [];

  double get totalLitros =>
      historial.fold<double>(0, (suma, c) => suma + c.litros);

  Future<void> cambiarLaboratorio(String nuevo) async {
    laboratorio = nuevo;
    error = null;
    notifyListeners();
    await _recargarHistorial();
  }

  /// Devuelve true si el consumo se guardó.
  Future<bool> guardar(String litrosTexto) async {
    final litros = double.tryParse(litrosTexto.trim().replaceAll(',', '.'));
    if (litros == null) {
      error = 'Escribe los litros con número';
      notifyListeners();
      return false;
    }

    final fecha = _reloj();
    final consumo = Consumo(
      laboratorio: laboratorio,
      litros: litros,
      fecha: fecha,
    );

    final motivo = ReglaConsumo.validar(consumo, hoy: fecha);
    if (motivo != null) {
      error = motivo;
      notifyListeners();
      return false;
    }

    cargando = true;
    error = null;
    notifyListeners();

    await _repositorio.guardar(consumo);
    await _recargarHistorial();
    return true;
  }

  Future<void> _recargarHistorial() async {
    cargando = true;
    notifyListeners();

    historial = await _repositorio.listarPorLaboratorio(laboratorio);
    cargando = false;
    notifyListeners();
  }
}
