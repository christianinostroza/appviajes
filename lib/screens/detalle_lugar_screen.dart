import 'package:flutter/material.dart';
import '../models/lugar.dart';
import 'package:intl/intl.dart';

class DetalleLugarScreen extends StatelessWidget {
  final Lugar lugar;

  String metersToKilometers(int meters) {
    final kilometers = meters / 1000;
    return kilometers.toStringAsFixed(0);
  }

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DetalleLugarScreen(this.lugar);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Lugar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: lugar.nombre,
              child: Image.asset(
                lugar.imagenUrl,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lugar.nombre,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lugar.descripcion,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Valor mínimo Costo del Viaje: ${NumberFormat.currency(locale: 'es_CL', symbol: 'CLP', decimalDigits: 0).format(lugar.valor)}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Distancia: ${metersToKilometers(lugar.distanciaMetros)} km', 
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Recomendado : ${lugar.tipos.join(", ")}', 
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
