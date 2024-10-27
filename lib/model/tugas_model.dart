import 'package:cloud_firestore/cloud_firestore.dart';
class Tugas { 
String time; 
String teacher;
String title; 
String description; 

  Tugas({ 
    required this.time, 
    required this.teacher, 
    required this.title, 
    required this.description, 
     
  }); 
factory Tugas.fromDocument(DocumentSnapshot doc) { 
return Tugas( 
      time: doc['time'], 
      teacher: doc['teacher'], 
      title: doc['title'], 
      description: doc['description'],
    ); 
  } 
Map<String, dynamic> toMap() { 
return { 
'time': time, 
'teacher': teacher, 
'title': title,  
    }; 
  } 
} 