class Categoria {
  String id;
  String nombre;
  List<Categoria> hijos;
  Categoria({this.id, this.nombre}) {
    this.hijos = [];
  }

  factory Categoria.fromJson(Map<String, dynamic> parsedJson) {
    return Categoria(
      id: parsedJson['id'],
      nombre: parsedJson['nombre'],
    );
  }

  addHijo(Categoria hijo) {
    hijos.add(hijo);
  }
}
