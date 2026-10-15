import 'package:ecotrack_reto/datos/consumo_repository.dart';
import 'package:ecotrack_reto/datos/consumo_service.dart';
import 'package:ecotrack_reto/datos/memoria_consumo_repository.dart';
import 'package:ecotrack_reto/datos/nube_consumo_repository.dart';
import 'package:ecotrack_reto/presentacion/registro_page.dart';
import 'package:ecotrack_reto/presentacion/registro_view_model.dart';
import 'package:flutter/material.dart';

const usarNube = false;

void main() {
  final ConsumoRepository repositorio = usarNube
      ? NubeConsumoRepository(ConsumoService())
      : MemoriaConsumoRepository();

  runApp(EcoTrackApp(repositorio: repositorio));
}

class EcoTrackApp extends StatelessWidget {
  const EcoTrackApp({super.key, required this.repositorio});

  final ConsumoRepository repositorio;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoTrack',
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: RegistroPage(viewModel: RegistroViewModel(repositorio)),
    );
  }
}
