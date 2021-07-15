class FoodModel {
  final String imageUrl, title;
  final double price;

  FoodModel({required this.imageUrl, required this.title, required this.price});
  static List<FoodModel> trendinFoodList = [
    FoodModel(
        imageUrl:
            'https://cdn.tasteatlas.com/images/toplistarticles/08c818739e4b48ce96d319c16f4cc0ca.jpg?w=375&h=280',
        title: 'American Burger',
        price: 11.00),
    FoodModel(
        imageUrl:
            'https://seoimgak.mmtcdn.com/blog/sites/default/files/styles/mobile_cover_images/public/feature-image-famous-dishes-of-delhi.jpg?itok=XNFMMjcZ',
        title: 'Bangladeshi jilapi',
        price: 15.00),
    FoodModel(
        imageUrl:
            'https://i0.wp.com/www.eatthis.com/wp-content/uploads/2018/02/french-fries-side-ketchup.jpg?w=640&ssl=1',
        title: 'Potato fries',
        price: 8.00),
    FoodModel(
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRd2OiT96GY8mipyP0fjgzquomUoGM1YX4IfA&usqp=CAU',
        title: 'Nuddls',
        price: 9.30),
  ];
  static List<FoodModel> extraFoodList = [
    FoodModel(
        imageUrl:
            'https://i.ndtvimg.com/mt/cooks/2014-11/mozzarella-cheese.jpg',
        title: 'Mozzarella',
        price: 1.0),
    FoodModel(
        imageUrl:
            'https://media.healthyfood.com/wp-content/uploads/2017/03/How-to-choose-salad-and-cooking-oils-500x499.jpg',
        title: 'Vesitable oil',
        price: 2.0),
    FoodModel(
        imageUrl:
            'https://chaldn.com/_mpimage/pran-hot-tomato-sauce-mini-10-pcs?src=https%3A%2F%2Feggyolk.chaldal.com%2Fapi%2FPicture%2FRaw%3FpictureId%3D47537&q=low&v=1',
        title: 'Hot tomato souce',
        price: 3.0)
  ];
}
