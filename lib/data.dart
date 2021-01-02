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
    .orderBy("pages", descending: true)
        .getDocuments();
  }


  for(DocumentSnapshot item in querySnapshot.documents){
    var dados = item.data;
    Book book =  Book(dados["title"], dados["writer"], dados["price"], dados["image"], dados["rating"], dados["pages"], dados["description"]);
    booksData.add(book);
  }
  return booksData;
}

salvarSugestoes(String titulo, String nome){
  Firestore db = Firestore.instance;

  Map<String, dynamic> dadosSugestao = {
      "titulo" : titulo,
      "nome": nome

    };

  db.collection("sugestoes")
  .add(dadosSugestao);


}