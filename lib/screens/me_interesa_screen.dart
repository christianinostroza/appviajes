import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/lugares.dart';
import '../models/lugar.dart';
import 'detalle_lugar_screen.dart';

class MeInteresaScreen extends StatelessWidget {
  final List<int> meInteresaItems;

  const MeInteresaScreen(this.meInteresaItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me Interesa'),
      ),
      body: FutureBuilder<List<Lugar>>(
        future: loadLugaresFromAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available.');
          } else {
            final lugares = snapshot.data!;
            return MeInteresaList(meInteresaItems, lugares);
          }
        },
      ),
    );
  }
}

class MeInteresaList extends StatefulWidget {
  final List<int> meInteresaItems;
  final List<Lugar> lugares;

  const MeInteresaList(this.meInteresaItems, this.lugares, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MeInteresaListState createState() => _MeInteresaListState();
}

class _MeInteresaListState extends State<MeInteresaList> {
  List<bool> isInterestedList = [];

  @override
  void initState() {
    super.initState();
    isInterestedList = List.generate(widget.lugares.length, (_) => false);
  }

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

  @override
  Widget build(BuildContext context) {
    final filteredLugares = widget.lugares.where((lugar) => widget.meInteresaItems.contains(lugar.id)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLugares.length,
              itemBuilder: (ctx, index) {
                final lugar = filteredLugares[index];
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
                             backgroundImage: AssetImage(lugar.imagenUrl), // Assuming .jpg extension, adjust as needed
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
