class TrendingFoodModel {
  final String imageUrl, title;
  final double price;
  TrendingFoodModel(
      {required this.imageUrl, required this.title, required this.price});
  static List<TrendingFoodModel> trendinFoodList = [
    TrendingFoodModel(
        imageUrl:
            'https://cdn.tasteatlas.com/images/toplistarticles/08c818739e4b48ce96d319c16f4cc0ca.jpg?w=375&h=280',
        title: 'American Burger',
        price: 11.00),
    TrendingFoodModel(
        imageUrl:
            'https://seoimgak.mmtcdn.com/blog/sites/default/files/styles/mobile_cover_images/public/feature-image-famous-dishes-of-delhi.jpg?itok=XNFMMjcZ',
        title: 'Bangladeshi jilapi',
        price: 15.00),
    TrendingFoodModel(
        imageUrl:
            'https://i0.wp.com/www.eatthis.com/wp-content/uploads/2018/02/french-fries-side-ketchup.jpg?w=640&ssl=1',
        title: 'Potato fries',
        price: 8.00),
    TrendingFoodModel(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd2OiT96GY8mipyP0fjgzquomUoGM1YX4IfA&usqp=CAU',
        title: 'Nuddls',
        price: 9.30),
  ];
}
