import 'package:flutter/services.dart';
import '../models/lugar.dart';
import 'dart:convert';

Future<List<Lugar>> loadLugaresFromAssets() async {

  final jsonString = await rootBundle.loadString('assets/data.json');


  final jsonData = json.decode(jsonString) as List<dynamic>;

  final lugares = jsonData.map<Lugar>((item) {
    final tipos = (item["tipos"] as List<dynamic>?)?.cast<String>() ?? [];

    return Lugar(
      id:  (item["id"] as num?)?.toInt() ?? 0,
      nombre: item["nombre"] as String? ?? "Default Name",
      descripcion: item["Viaje"] as String? ?? "Default Description",
      imagenUrl: item["imagenUrl"] as String? ?? "Default Image URL",
      valor: (item["valor"] as num?)?.toInt() ?? 0,
      distanciaMetros: (item["distanciaMetros"] as num?)?.toInt() ?? 0,
      tipos: tipos,
    );
  }).toList();

  return lugares;
}
