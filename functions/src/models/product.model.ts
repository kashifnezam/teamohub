export interface ProductModel {
  id: string;

  title: string;

  description: string;

  price: number;

  images: string[];

  sellerId: string;

  city: string;

  state: string;

  categoryId: string;

  subCategoryId: string;

  createdAt: FirebaseFirestore.Timestamp;

  status: string;

  isDeleted: boolean;
}