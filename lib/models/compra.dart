class DataCompra {
  Compra? compra;

  DataCompra({this.compra});

  DataCompra.fromJson(Map<String, dynamic> json) {
    compra =
        json['Compra'] != null ? new Compra.fromJson(json['Compra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.compra != null) {
      data['Compra'] = this.compra!.toJson();
    }
    return data;
  }
}

class Compra {
  int? id;
  int? clienteId;
  int? articuloId;
  String? fechaCompra;
  int? cantidad;
  String? createdAt;
  String? updatedAt;

  Compra(
      {this.id,
      this.clienteId,
      this.articuloId,
      this.fechaCompra,
      this.cantidad,
      this.createdAt,
      this.updatedAt});

  Compra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clienteId = json['cliente_id'];
    articuloId = json['articulo_id'];
    fechaCompra = json['fecha_compra'];
    cantidad = json['cantidad'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cliente_id'] = this.clienteId;
    data['articulo_id'] = this.articuloId;
    data['fecha_compra'] = this.fechaCompra;
    data['cantidad'] = this.cantidad;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
