import * as admin from "firebase-admin";

import {
  USERS_COLLECTION,
  USER_FCM_TOKEN,
} from "./notification.constants";

import { NotificationPayload } from "./notification.types";

export class NotificationService {
  private static _instance: NotificationService;

  static get instance(): NotificationService {
    this._instance ??= new NotificationService();

    return this._instance;
  }

  private constructor() {}

  private firestore = admin.firestore();

  private messaging = admin.messaging();


  async getUserToken(uid: string): Promise<string | null> {
    const doc = await this.firestore
      .collection(USERS_COLLECTION)
      .doc(uid)
      .get();

    if (!doc.exists) {
      return null;
    }

    const token = doc.get(USER_FCM_TOKEN);

    if (!token) {
      return null;
    }

    return token;
  }

  async send(payload: NotificationPayload): Promise<void> {
    try {
      await this.messaging.send({
        token: payload.token,

        notification: {
          title: payload.title,
          body: payload.body,
        },

        data: payload.data ?? {},

        android: {
          priority: "high",
        },

        apns: {
          payload: {
            aps: {
              sound: "default",
            },
          },
        },

        webpush: {
          notification: {
            icon: payload.imageUrl,
          },
        },
      });
    } catch (e: any) {
      console.error(e);

      if (
        e.code ===
          "messaging/registration-token-not-registered" ||
        e.code ===
          "messaging/invalid-registration-token"
      ) {
        console.log(
          "Removing invalid token..."
        );

        await this.removeToken(payload.token);
      }
    }
  }

  private async removeToken(
    token: string,
  ): Promise<void> {
    const snapshot = await this.firestore
      .collection(USERS_COLLECTION)
      .where(USER_FCM_TOKEN, "==", token)
      .get();

    if (snapshot.empty) {
      return;
    }

    const batch = this.firestore.batch();

for (const finalDoc of snapshot.docs){
    batch.update(finalDoc.ref, {
        [USER_FCM_TOKEN]:
            admin.firestore.FieldValue.delete(),
      });
    }

    await batch.commit();
  }
}