class DataArticulo {
  Articulo? articulo;

  DataArticulo({this.articulo});

  DataArticulo.fromJson(Map<String, dynamic> json) {
    articulo = json['Articulo'] != null
        ? new Articulo.fromJson(json['Articulo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articulo != null) {
      data['Articulo'] = this.articulo!.toJson();
    }
    return data;
  }
}

class Articulo {
  int? id;
  String? modelo;
  String? talla;
  String? marca;
  String? tipo;
  String? genero;
  String? edad;
  String? foto;
  String? material;
  String? color;
  int? stock;
  int? precio;
  int? vistas;
  int? deleted;
  String? createdAt;
  String? updatedAt;
  String? categoria;

  Articulo(
      {this.id,
      this.modelo,
      this.talla,
      this.marca,
      this.tipo,
      this.genero,
      this.edad,
      this.foto,
      this.material,
      this.color,
      this.stock,
      this.precio,
      this.vistas,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.categoria});

  Articulo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelo = json['modelo'];
    talla = json['talla'];
    marca = json['marca'];
    tipo = json['tipo'];
    genero = json['genero'];
    edad = json['edad'];
    foto = json['foto'];
    material = json['material'];
    color = json['color'];
    stock = json['stock'];
    precio = json['precio'];
    vistas = json['vistas'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoria = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['modelo'] = this.modelo;
    data['talla'] = this.talla;
    data['marca'] = this.marca;
    data['tipo'] = this.tipo;
    data['genero'] = this.genero;
    data['edad'] = this.edad;
    data['foto'] = this.foto;
    data['material'] = this.material;
    data['color'] = this.color;
    data['stock'] = this.stock;
    data['precio'] = this.precio;
    data['vistas'] = this.vistas;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['categoria'] = this.categoria;
    return data;
  }
}
