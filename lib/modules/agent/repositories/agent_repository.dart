import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app/constants/firebase_constants.dart';
import '../models/agent_model.dart';

class AgentRepository {
  AgentRepository._();

  static final AgentRepository instance = AgentRepository._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _users => _firestore.collection(FirebaseConstants.agents);

  Future<AgentModel?> getAgentDetails() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) return null;

    final doc = await _users.doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return AgentModel.fromMap(doc.data()!, uid);
  }

  Future<void> registerAgent({
    required AgentModel agent,
  }) async {
    final uid = _auth.currentUser!.uid;

    await _users.doc(uid).set(
      agent.toMap(),
      SetOptions(merge: true),
    );
  }

  Future<void> updateAgent({
    required AgentModel agent,
  }) async {
    final uid = _auth.currentUser!.uid;

    await _users.doc(uid).update(
      agent.toMap(),
    );
  }

  Future<String> uploadProfileImage(
      File imageFile,
      ) async {
    final uid = _auth.currentUser!.uid;

    final ref = _storage
        .ref()
        .child('agents')
        .child(uid)
        .child('profile')
        .child('profile.jpg');

    await ref.putFile(imageFile);

    return await ref.getDownloadURL();
  }

  Future<void> deleteProfileImage() async {
    final uid = _auth.currentUser!.uid;

    final ref = _storage
        .ref()
        .child('agents')
        .child(uid)
        .child('profile.jpg');

    try {
      await ref.delete();
    } catch (_) {}
  }

  Future<void> saveAgent({
    required AgentModel agent,
    File? imageFile,
    File? verificationFile,
  }) async {
    String imageUrl = agent.profileImage;
    String? verificationUrl = agent.verificationFileUrl;

    if (imageFile != null) {
      imageUrl = await uploadProfileImage(imageFile);
    }

    if (verificationFile != null) {
      verificationUrl = await uploadVerificationDocument(verificationFile);
    }

    final updated = agent.copyWith(
      uid: _auth.currentUser!.uid,
      isAgent: true,
      agentStatus: "pending",
      profileImage: imageUrl,
      verificationFileUrl: verificationUrl,
    );

    final doc = await _users.doc(_auth.currentUser!.uid).get();

    if (doc.exists && (doc.data()?['isAgent'] ?? false)) {
      await updateAgent(agent: updated);
    } else {
      await registerAgent(agent: updated);
    }
  }

  Future<String> uploadVerificationDocument(
      File file,
      ) async {
    final uid = _auth.currentUser!.uid;

    final extension = file.path.split('.').last.toLowerCase();

    final ref = _storage
        .ref()
        .child("agents")
        .child(uid)
        .child("documents")
        .child("verification.$extension");

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }
}