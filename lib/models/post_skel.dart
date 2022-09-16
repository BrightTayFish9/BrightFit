///Stripped-down version of the WP Post
class PostSkel {
  int id;
  String title;
  String imageURL;
  String link;
  int categoryID;
  String categoryName;

  PostSkel(
      {this.id,
      this.title,
      this.imageURL,
      this.link,
      this.categoryID,
      this.categoryName});

  factory PostSkel.fromJson(Map<String, dynamic> json) {
    String image;

    ///If no featured image provided, show a gray picture
    if (json['featured_image'] is bool) {
      image =
          'https://www.solidbackgrounds.com/images/2560x1600/2560x1600-dark-gray-solid-color-background.jpg';
    } else {
      image = json['featured_image'];
    }

    return PostSkel(
        id: int.tryParse(json['id'].toString()),
        title: json['title'],
        imageURL: image,
        link: json['link'],
        categoryID: int.tryParse(json['categoryID'].toString()),
        categoryName: json['categoryName']);
  }
}
