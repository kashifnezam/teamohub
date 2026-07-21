export interface UserModel {
  id: string;
  name: string;
  photoUrl?: string;
  createdAt?: FirebaseFirestore.Timestamp;
}