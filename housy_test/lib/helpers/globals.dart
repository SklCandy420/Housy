import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final curruser = FirebaseAuth.instance.currentUser;
final firestore = FirebaseFirestore.instance;

class Category {
  String title;
  String img;

  Category({this.title, this.img});
}

List<Category> catList = [
  Category(title: "House Cleaning", img: "assets/houseclean.jpg"),
  Category(title: "Electrician", img: "assets/elec.jpg"),
  Category(title: "Tiffin Service", img: "assets/tiffin.jpg"),
  Category(title: "Massage Service", img: "assets/massage.jpg")
];

class Professionals {
  String title;
  String img;

  Professionals({this.title, this.img});
}

List<Professionals> proList = [
  Professionals(title: "Pro. 1", img: "assets/user.png"),
  Professionals(title: "Pro. 2", img: "assets/user.png"),
  Professionals(title: "Pro. 3", img: "assets/user.png"),
  Professionals(title: "Pro. 4", img: "assets/user.png"),
  Professionals(title: "Pro. 5", img: "assets/user.png"),
  Professionals(title: "Pro. 6", img: "assets/user.png"),
  Professionals(title: "Pro. 7", img: "assets/user.png")
];
