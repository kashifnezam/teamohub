export interface NotificationPayload {
  title: string;
  body: string;

  token: string;

  imageUrl?: string;

  data?: Record<string, string>;
}