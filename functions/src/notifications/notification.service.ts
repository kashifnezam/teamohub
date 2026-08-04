import * as admin from "firebase-admin";

import {
  USERS_COLLECTION,
  USER_FCM_TOKEN,
  USER_NOTIFICATION_COLLECTION,
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

  /* -------------------------------------------------------------------------- */
  /*                               USER TOKEN                                   */
  /* -------------------------------------------------------------------------- */

  async getUserToken(uid: string): Promise<string | null> {
    const doc = await this.firestore
      .collection(USERS_COLLECTION)
      .doc(uid)
      .get();

    if (!doc.exists) {
      return null;
    }

    return doc.get(USER_FCM_TOKEN) ?? null;
  }

  /* -------------------------------------------------------------------------- */
  /*                            SEND TO SINGLE USER                             */
  /* -------------------------------------------------------------------------- */

  async sendToUser(payload: NotificationPayload): Promise<void> {
    let token: string | undefined;

    if (payload.token) {
      token = payload.token;
    }
    if (!token) {
      if (!payload.uid) return;

        const userToken = await this.getUserToken(payload.uid);

        if (!userToken) {
          return;
        }

        token = userToken;
        if (!token) return;
    }

    try {
      await this.messaging.send({
        token,

        notification: {
          title: payload.title,
          body: payload.body,
        },

        data: payload.data ?? {},

        android: {
          priority: "high",
          notification: {
            imageUrl: payload.imageUrl,
          },
        },

        apns: {
          payload: {
            aps: {
              sound: "default",
            },
          },
          fcmOptions: {
            imageUrl: payload.imageUrl,
          },
        },

        webpush: {
          notification: {
            icon: payload.imageUrl,
          },
        },
      });

      if (payload.uid && payload.saveHistory !== false) {
        await this.saveNotification(
          payload.uid,
          payload.title,
          payload.body,
          payload.imageUrl,
          payload.data,
        );
      }
    } catch (e: any) {
      console.error(e);

      if (
        e.code === "messaging/registration-token-not-registered" ||
        e.code === "messaging/invalid-registration-token"
      ) {
        await this.removeToken(token);
      }
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                             SEND TO MULTIPLE                               */
  /* -------------------------------------------------------------------------- */

  async sendToUsers(
    uids: string[],
    title: string,
    body: string,
    data?: Record<string, string>,
  ): Promise<void> {
    const tokens = (
      await Promise.all(
        uids.map((uid) => this.getUserToken(uid)),
      )
    ).filter(Boolean) as string[];

    if (!tokens.length) {
      return;
    }

    await this.messaging.sendEachForMulticast({
      tokens,

      notification: {
        title,
        body,
      },

      data: data ?? {},

      android: {
        priority: "high",
      },
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                          SAVE NOTIFICATION                                 */
  /* -------------------------------------------------------------------------- */

  async saveNotification(
    uid: string,
    title: string,
    body: string,
    imageUrl?: string,
    data?: Record<string, string>,
  ): Promise<void> {
    await this.firestore
      .collection(USERS_COLLECTION)
      .doc(uid)
      .collection(USER_NOTIFICATION_COLLECTION)
      .add({
        title,
        body,
        imageUrl: imageUrl ?? null,
        data: data ?? {},
        read: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
  }

  /* -------------------------------------------------------------------------- */
  /*                          REMOVE INVALID TOKEN                              */
  /* -------------------------------------------------------------------------- */

  private async removeToken(token: string): Promise<void> {
    const snapshot = await this.firestore
      .collection(USERS_COLLECTION)
      .where(USER_FCM_TOKEN, "==", token)
      .get();

    if (snapshot.empty) {
      return;
    }

    const batch = this.firestore.batch();

    snapshot.docs.forEach((doc) => {
      batch.update(doc.ref, {
        [USER_FCM_TOKEN]:
          admin.firestore.FieldValue.delete(),
      });
    });

    await batch.commit();
  }
}