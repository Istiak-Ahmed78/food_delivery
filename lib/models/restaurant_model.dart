class RestaurentListItemModel {
  final String imageAdress, title, subTitle;
  final int rating;

  RestaurentListItemModel(
      {required this.imageAdress,
      required this.title,
      required this.subTitle,
      required this.rating});
  static List<RestaurentListItemModel> topRestaurentList = [
    RestaurentListItemModel(
        title: 'Home cooking Expertice',
        subTitle: 'Letraset sheets containing Language',
        rating: 5,
        imageAdress:
            'https://lp-cms-production.imgix.net/image_browser/Ithaa-Maldives.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850&q=75&dpr=1'),
    RestaurentListItemModel(
        imageAdress:
            'https://lp-cms-production.imgix.net/image_browser/Guy-Savoy-de-Paris.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850&q=75&dpr=1',
        title: 'Guy Savoy de Paris – Paris, France',
        subTitle:
            ' 13-course set meal (excluding drinks) will cost €478.00 per head. To fire up the appetite, example dishes include iced poached oysters, caviar with smoked',
        rating: 5),
    RestaurentListItemModel(
        imageAdress:
            'https://lp-cms-production.imgix.net/image_browser/Ultraviolet-Shanghai.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850&q=75&dpr=1',
        title: 'Ultraviolet – Shanghai, China',
        subTitle:
            'It’s notoriously difficult to get a reservation at Ultraviolet so to be one of 10 guests to dine here is an achievement in itself. Dubbed the first ‘experiential eatery’ in the world',
        rating: 4)
  ];
}
