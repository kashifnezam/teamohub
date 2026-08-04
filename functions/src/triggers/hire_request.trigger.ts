import { onDocumentCreated } from "firebase-functions/v2/firestore";
import * as logger from "firebase-functions/logger";

import { NotificationService } from "../notifications/notification.service";
import { NotificationTemplates } from "../notifications/notification.templates";

export const onHireRequestCreated = onDocumentCreated(
  {
    document: "agent_requests/{requestId}",
    region: "asia-south1",
  },
  async (event) => {
    const snapshot = event.data;

    if (!snapshot) {
      return;
    }

    const data = snapshot.data();

    if (!data) {
      return;
    }

    const agentId = data.agentId as string;
    const buyerName = (data.userName as string) || "Someone";

    if (!agentId) {
      logger.warn("Missing agentId.");
      return;
    }

    const template = NotificationTemplates.hireRequest(buyerName);

    await NotificationService.instance.sendToUser({
      uid: agentId,
      title: template.title,
      body: template.body,

      data: {
        type: "hire_request",
        requestId: snapshot.id,
        agentId,
      },
   });

    logger.info(
      `Hire request notification sent to ${agentId}`
    );
  }
);