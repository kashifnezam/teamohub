import { db } from "../config/firebase";
import { ProductModel } from "../models/product.model";
import { UserModel } from "../models/user.model";

class FirestoreService {

    async getProduct(productId: string): Promise<ProductModel | null> {

        const doc = await db.collection("products").doc(productId).get();

        if (!doc.exists) {
            return null;
        }

        return {
            id: doc.id,
            ...(doc.data() as Omit<ProductModel, "id">)
        };
    }

    async getRelatedProducts(product: ProductModel): Promise<ProductModel[]> {

        const snapshot = await db
            .collection("products")
            .where("categoryId", "==", product.categoryId)
            .where("status", "==", "active")
            .limit(8)
            .get();

        const products: ProductModel[] = [];

        snapshot.forEach(doc => {

            if (doc.id === product.id) {
                return;
            }

            const data = doc.data() as Omit<ProductModel, "id">;

            if (data.isDeleted) {
                return;
            }

            products.push({
                id: doc.id,
                ...data
            });

        });

        return products;

    }

    async getSeller(sellerId: string): Promise<UserModel | null> {

        const doc = await db
            .collection("users")
            .doc(sellerId)
            .get();

        if (!doc.exists) {
            return null;
        }

        return {
            id: doc.id,
            ...(doc.data() as Omit<UserModel, "id">)
        };

    }

}

export default new FirestoreService();