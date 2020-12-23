import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String title,
      writer,
      price,
      image,
      description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id neque libero. Donec finibus sem viverra, luctus nisi ac, semper enim. Vestibulum in mi feugiat, mattis erat suscipit, fermentum quam. Mauris non urna sed odio congue rhoncus. \nAliquam a dignissim ex. Suspendisse et sem porta, consequat dui et, placerat tortor. Sed elementum nunc a blandit euismod. Cras condimentum faucibus dolor. Etiam interdum egestas sagittis. Aliquam vitae molestie eros. Cras porta felis ac eros pellentesque, sed lobortis mi eleifend. Praesent ut.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id neque libero. Donec finibus sem viverra, luctus nisi ac, semper enim. Vestibulum in mi feugiat, mattis erat suscipit, fermentum quam. Mauris non urna sed odio congue rhoncus. \nAliquam a dignissim ex. Suspendisse et sem porta, consequat dui et, placerat tortor. Sed elementum nunc a blandit euismod. Cras condimentum faucibus dolor. Etiam interdum egestas sagittis. Aliquam vitae molestie eros. Cras porta felis ac eros pellentesque, sed lobortis mi eleifend. Praesent ut.';
  String pages;
  String rating;

  Book(
      this.title, this.writer, this.price, this.image, this.rating, this.pages, this.description);
}


List<Book> booksData = new List();

/*List<Book> ListBooks() {
  List<Book> books = new List();
  books = [
    Book('Buku Pintar Drafter Untuk Pemula Hingga Mahir', 'Widada', 'Rp 55.000',
        'images/corel.jpg', '4.5', '1'),
    Book('Adobe InDesign: Seri Panduan Terlengkap', 'Jubilee Enterprise',
        'Rp 60.000', 'images/corel.jpg', '5.0', '1'),
    Book('Pemodelan Objek Dengan 3Ds Max 2014', 'Wahana Komputer', 'Rp 58.000',
        'images/corel.jpg', '3.0', '1'),
  ];
  books.add(Book('fdsfdster Series : Tdsfdsfdpat Menguasai CSS', 'Wahana Komputer',
      'Rp 54.000', 'images/corel.jpg', '3.5', '1'));


  return books;
}*/

Future<List<Book>> getFirebase(String pesquisa) async{
  booksData = new List();
  QuerySnapshot querySnapshot;
  if(pesquisa!= null){
    booksData = new List();
     querySnapshot = await Firestore.instance.collection("books")
     .where("title", isGreaterThanOrEqualTo: pesquisa)
     .where("title", isLessThanOrEqualTo: pesquisa + "\uf8ff")
        .getDocuments();
  }else{
    querySnapshot = await Firestore.instance.collection("books")
        .getDocuments();
  }


  for(DocumentSnapshot item in querySnapshot.documents){
    var dados = item.data;
    Book book =  Book(dados["title"], dados["writer"], dados["price"], dados["image"], dados["rating"], dados["pages"], dados["description"]);
    booksData.add(book);
  }
  return booksData;
}