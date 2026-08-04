import { onDocumentCreated } from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import * as logger from "firebase-functions/logger";

import { NotificationService } from "../notifications/notification.service";
import { NotificationTemplates } from "../notifications/notification.templates";

export const onChatMessageCreated = onDocumentCreated(
  {
    document: "chats/{chatId}/messages/{messageId}",
    region: "asia-south1",
  },
  async (event) => {
    const snapshot = event.data;

    if (!snapshot) {
      return;
    }

    const message = snapshot.data();

    if (!message) {
      return;
    }

    const senderId = message.senderId as string;
    const receiverId = message.receiverId as string;
    const text = (message.message as string) || "Sent you a message";

    if (!senderId || !receiverId) {
      logger.warn("Missing senderId or receiverId.");
      return;
    }

    // Fetch chat document
    const chatDoc = await admin
      .firestore()
      .collection("chats")
      .doc(event.params.chatId)
      .get();

    if (!chatDoc.exists) {
      logger.warn("Chat not found.");
      return;
    }

    const chat = chatDoc.data()!;

    let senderName: string;
    if (senderId == chat["buyerId"]) {
      senderName = chat["buyerSnapshot"]["name"] ?? "Buyer";
    } else {
      senderName = chat["sellerSnapshot"]["name"] ?? "Seller";
    }

    const template = NotificationTemplates.chatMessage(
      senderName,
      text,
    );

    await NotificationService.instance.sendToUser({
      uid: receiverId,
      title: template.title,
      body: template.body,
      data: {
        type: "chat",
        chatId: event.params.chatId,
        messageId: snapshot.id,
      },
    });

    logger.info(
      `Chat notification sent to ${receiverId}`,
    );
  },
);