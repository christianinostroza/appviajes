class Lugar {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final int valor;
  final int distanciaMetros;
  final List<String> tipos;

  Lugar({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.valor,
    required this.distanciaMetros,
    required this.tipos,
  });
}