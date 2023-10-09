class Item {
  final String title, price, link;

  Item({
    this.title,
    this.price,
    this.link,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      price: json['price'],
      link: json['link'],
    );
  }
}
