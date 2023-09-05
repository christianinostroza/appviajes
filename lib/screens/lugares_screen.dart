import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/lugar.dart';
import 'detalle_lugar_screen.dart';
import '../data/lugares.dart';
import '../widget/search_filter_widget.dart';

class LugaresScreen extends StatefulWidget {
  final List<int> meInteresaItems;

  const LugaresScreen(this.meInteresaItems, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LugaresScreenState createState() => _LugaresScreenState();
}

class _LugaresScreenState extends State<LugaresScreen> {
  double filtroValor = 0.0;
  List<bool> isInterestedList =
      List.generate(0, (_) => false); 

  List<Lugar> lugares = []; 

  void toggleMeInteresa(int id) {
    setState(() {
      if (widget.meInteresaItems.contains(id)) {
        widget.meInteresaItems.remove(id);
      } else {
        widget.meInteresaItems.add(id);
      }
    });
  }

  String metersToKilometers(int meters) {
    final kilometers = meters / 1000;
    return kilometers.toStringAsFixed(0);
  }

  int getUniqueId(int index) => index;

  @override
  void initState() {
    super.initState();
    loadLugaresFromAssets().then((loadedLugares) {
      setState(() {
        lugares = loadedLugares;
        isInterestedList = List.generate(lugares.length, (index) =>
            widget.meInteresaItems.contains(lugares[index].id)); 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lugaresDisponibles =
        lugares.where((lugar) => lugar.valor >= filtroValor).toList();

    lugaresDisponibles
        .sort((a, b) => a.distanciaMetros.compareTo(b.distanciaMetros));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares'),
      ),
      body: Column(
        children: [
          SearchFilterWidget(
            filtroValor: filtroValor,
            onValorFilterChanged: (newValue) {
              setState(() {
                filtroValor = newValue;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Cantidad de Lugares Disponibles: ${lugaresDisponibles.length}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lugaresDisponibles.length,
              itemBuilder: (ctx, index) {
                final lugar = lugaresDisponibles[index];
                // final lugarId = getUniqueId(index);
                final lugarId = lugar.id;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetalleLugarScreen(lugar),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(lugar.imagenUrl),
                          ),
                          title: Text(lugar.nombre),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(lugar.descripcion),
                              Text(
                                'Valor mínimo Costo del Viaje: ${NumberFormat.currency(locale: 'es_CL', symbol: 'CLP', decimalDigits: 0).format(lugar.valor)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Distancia al Lugar: ${metersToKilometers(lugar.distanciaMetros)} km',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.directions_run,
                              color: isInterestedList[index]
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isInterestedList[index] =
                                    !isInterestedList[index];
                                toggleMeInteresa(lugarId);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
