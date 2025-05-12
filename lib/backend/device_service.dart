import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Device {
  final String userId;
  final String category;
  final String name;
  final String purchaseDate;
  final String warrantyDate;
  final String serialNumber;
  final String? warrantyExtension;
  final String? image;
  final String? invoice;
  final String? notes;
  final String? timer;

  //Geräte Konstruktor
  Device({
    required this.userId,
    required this.category,
    required this.name,
    required this.purchaseDate,
    required this.warrantyDate,
    required this.serialNumber,
    this.warrantyExtension,
    this.image,
    this.invoice,
    this.notes,
    this.timer,
  });

  // Konvertiert die Firestore-Daten in ein Gerät
  factory Device.fromMap(Map<String, dynamic> data, String id) {
    return Device(
      userId: data['userId'],
      category: data['category'],
      name: data['name'],
      purchaseDate: data['purchaseDate'],
      warrantyDate: data['warrantyDate'],
      serialNumber: data['serialNumber'],
      warrantyExtension: data['warrantyExtension'],
      image: data['image'],
      invoice: data['invoice'],
      notes: data['notes'],
      timer: data['timer'],
    );
  }

  // Konvertiert das Gerät in eine Map für Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category,
      'name': name,
      'purchaseDate': purchaseDate,
      'warrantyDate': warrantyDate,
      'serialNumber': serialNumber,
      if (warrantyExtension != null) 'warrantyExtension': warrantyExtension,
      if (image != null) 'image': image,
      if (invoice != null) 'invoice': invoice,
      if (notes != null) 'notes': notes,
      if (timer != null) 'timer': timer,
    };
  }
}

// DeviceService-Klasse für die Verwaltung von Geräten in Firebase
class DeviceService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore Instanz
  final FirebaseStorage _storage = FirebaseStorage.instance; // Storage Instanz

  // Hilfsfunktion zum Hochladen einer Datei und Abrufen der URL
  Future<String?> _uploadFile(File? file, String path) async {
    if (file == null) return null;
    try {
      final ref = _storage.ref(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Fehler beim Hochladen der Datei nach $path: $e");
      return null;
    }
  }

  // Funktion zum Hinzufügen eines neuen Geräts
  Future<void> addDevice(
    Device newDevice, {
    required String userId,
    required String category,
    required String name,
    required String purchaseDate,
    required String warrantyDate,
    required String serialNumber,
    String? warrantyExtension,
    File? imageFile,
    File? invoiceFile,
    String? notes,
    String? timer,
  }) async {
    // Überprüfen, ob der Benutzer authentifiziert ist
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.uid != userId) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        message: 'User is not authenticated or mismatch.',
      );
    }

    // Pfad für das Gerätebild
    String? imageUrl;
    if (imageFile != null) {
      // Eindeutigen Pfad generieren
      final imagePath =
          'device_images/$userId/$name/${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
      imageUrl = await _uploadFile(imageFile, imagePath);
    }

    // Pfad für die Rechnung
    String? invoiceUrl;
    if (invoiceFile != null) {
      // Eindeutigen Pfad generieren
      final invoicePath =
          'device_invoices/$userId/$name/${DateTime.now().millisecondsSinceEpoch}_${invoiceFile.path.split('/').last}';
      invoiceUrl = await _uploadFile(invoiceFile, invoicePath);
    }

    // Gerätdaten in Firestore speichern
    final device = Device(
      userId: userId,
      category: category,
      name: name,
      purchaseDate: purchaseDate,
      warrantyDate: warrantyDate,
      serialNumber: serialNumber,
      warrantyExtension: warrantyExtension,
      image: imageUrl,
      invoice: invoiceUrl,
      notes: notes,
      timer: timer,
    );

    await _firestore
        .collection('devices')
        .doc(userId)
        .collection('user_devices')
        .add(device.toMap());
  }

  // Funktion zum Abrufen aller Geräte eines Benutzers
  Future<List<Device>> getDevicesForUser(String userId) async {
    final snapshot =
        await _firestore
            .collection('devices')
            .doc(userId)
            .collection('user_devices')
            .where('userId', isEqualTo: userId)
            .get();

    return snapshot.docs
        .map((doc) => Device.fromMap(doc.data(), doc.id))
        .toList();
  }

  // Future<void> updateDevice(Device device) async {
  //   await _firestore
  //       .collection('devices')
  //       .doc(device.id)
  //       .update(device.toMap());
  // }

  // Future<void> deleteDevice(String id) async {
  //   await _firestore.collection('devices').doc(id).delete();
  // }
}
