import { onRequest } from "firebase-functions/v2/https";
import app from "./app";

export const productPage = onRequest(
  {
    region: "asia-south1",
    memory: "512MiB",
    timeoutSeconds: 30,
    concurrency: 80,
  },
  app
);

/*
|--------------------------------------------------------------------------
| Notification Triggers
|--------------------------------------------------------------------------
*/

export * from "./triggers";
export {
  generateReferralCode,
  validateReferral,
  applyReferral,
} from "./controllers/refer.controller";

export { notify } from "./notifications/notification.function";
export { onChatMessageCreated } from "./triggers/chat.trigger";