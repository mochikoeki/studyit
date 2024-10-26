import 'package:cloud_firestore/cloud_firestore.dart'; 
class Tugas { 
String time; 
String teacher;
String title; 
String description; 
String gambarUrl; 
  Tugas({ 
    required this.time, 
    required this.teacher, 
    required this.title, 
    required this.description, 
    required this.gambarUrl, 
  }); 
factory Tugas.fromDocument(DocumentSnapshot doc) { 
return Tugas( 
      time: doc['time'], 
      teacher: doc['teacher'], 
      title: doc['title'], 
      description: doc['description'],
      gambarUrl: doc['gambarUrl'], 
    ); 
  } 
Map<String, dynamic> toMap() { 
return { 
'time': time, 
'teacher': teacher, 
'title': title, 
'gambarUrl': gambarUrl, 
    }; 
  } 
} 