List<Category> categoriesFromJson(dynamic str) => List<Category>.from(
      (str).map<Category>(
        (x) => Category.fromJson(x),
      ),
    );

class Category {
  int? id;
  String? name;
  int? parent;
  String? image;
  String? description;

  Category({this.id, this.name, this.parent, this.image, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent'] = this.parent;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
