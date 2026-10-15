/// Finge una API remota: solo habla mapas JSON.
class ConsumoService {
  final List<Map<String, Object>> _servidor = [];

  Future<void> post(Map<String, Object> json) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    _servidor.add(json);
  }

  Future<List<Map<String, Object>>> get(String laboratorio) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _servidor.where((j) => j['laboratorio'] == laboratorio).toList();
  }
}
