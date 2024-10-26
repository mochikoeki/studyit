import 'package:studyit/model/tugas_model.dart';
import 'package:studyit/service/firebase_service.dart';

class TugasService { 
  final FirestoreService _firestoreService = FirestoreService(); 
  final String collectionPath = 'tugas'; // Ubah koleksi menjadi 'tugas'

  /// Menambahkan Tugas
  Future<void> tambahTugas(Tugas tugas) { 
    return _firestoreService.tambah( 
      collectionPath: collectionPath, 
      item: tugas.toMap(), 
    ); 
  } 

  /// Mengupdate Tugas
  Future<void> updateTugas(String id, Tugas tugas) { 
    return _firestoreService.update( 
      collectionPath: collectionPath, 
      id: id, 
      item: tugas.toMap(), 
    ); 
  } 

  /// Menghapus Tugas
  Future<void> hapusTugas(String id) { 
    return _firestoreService.hapus( 
      collectionPath: collectionPath, 
      id: id, 
    ); 
  } 

  /// Mendapatkan list Tugas
  Stream<List<Tugas>> getTugasList() { 
    return _firestoreService.getList( 
      collectionPath: collectionPath, 
      fromMap: (doc) => Tugas.fromDocument(doc), 
    ); 
  } 

  /// Mendapatkan Tugas berdasarkan ID
  Future<Tugas> getTugasById(String id) { 
    return _firestoreService.getById( 
      collectionPath: collectionPath, 
      id: id, 
      fromMap: (doc) => Tugas.fromDocument(doc), 
    ); 
  } 
} 
