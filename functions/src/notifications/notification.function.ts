import { onCall, HttpsError } from "firebase-functions/v2/https";

import { NotificationService } from "./notification.service";

export const notify = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError(
      "unauthenticated",
      "Login required",
    );
  }

  const {
    uid,
    title,
    body,
    imageUrl,
    data,
    saveHistory,
  } = request.data;

  if (!uid) {
    throw new HttpsError(
      "invalid-argument",
      "uid is required",
    );
  }

  if (!title) {
    throw new HttpsError(
      "invalid-argument",
      "title is required",
    );
  }

  if (!body) {
    throw new HttpsError(
      "invalid-argument",
      "body is required",
    );
  }

  await NotificationService.instance.sendToUser({
    uid,
    title,
    body,
    imageUrl,
    data,
    saveHistory,
  });

  return {
    success: true,
    message: "Notification sent successfully.",
  };
});