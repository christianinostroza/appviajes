// search_filter_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchFilterWidget extends StatelessWidget {
  final double filtroValor;
  final Function(double) onValorFilterChanged;

  const SearchFilterWidget({
    super.key,
    required this.filtroValor,
    required this.onValorFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Buscador',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Valor mínimo Costo del Viaje: ${NumberFormat.currency(locale: 'es_CL', symbol: 'CLP', decimalDigits: 0).format(filtroValor)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: filtroValor,
          min: 0.0,
          max: 1000000.0,
          divisions: 97,
          onChanged: onValorFilterChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
