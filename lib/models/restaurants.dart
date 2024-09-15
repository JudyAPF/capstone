import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChecklistItem {
  String title;
  bool isCompleted;

  ChecklistItem({required this.title, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      title: map['title'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }
}

Future<void> saveChecklistToFirestore() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userId = user.uid;

    List<ChecklistItem> checklistItems = [
      ChecklistItem(title: "Barangay Clearance"),
      ChecklistItem(title: "DTI Business Name Certificate"),
      ChecklistItem(title: "Community Tax Certificate (CEDULA)"),
      ChecklistItem(title: "Sanitary Permit"),
      ChecklistItem(title: "Contract of Lease"),
      ChecklistItem(title: "Transfer Certificate of Title (TCT)"),
      ChecklistItem(title: "Tax Declaration"),
    ];

    List<Map<String, dynamic>> checklistMap =
        checklistItems.map((item) => item.toMap()).toList();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('checklists')
        .doc('restaurant_permits_and_licenses')
        .set({'items': checklistMap});

    // ignore: avoid_print
    print("Checklist saved successfully!");
  } else {
    // ignore: avoid_print
    print("No user is signed in!");
  }
}
