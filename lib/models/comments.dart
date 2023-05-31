class Comments {
  int? id;
  int? userId;
  String? username;
  int? articuloId;
  String? comentario;
  int? puntuacion;
  String? createdAt;
  String? updatedAt;

  Comments(
      {this.id,
      this.userId,
      this.username,
      this.articuloId,
      this.comentario,
      this.puntuacion,
      this.createdAt,
      this.updatedAt});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['user_name'];
    articuloId = json['articulo_id'];
    comentario = json['comentario'];
    puntuacion = json['puntuacion'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.username;
    data['articulo_id'] = this.articuloId;
    data['comentario'] = this.comentario;
    data['puntuacion'] = this.puntuacion;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
