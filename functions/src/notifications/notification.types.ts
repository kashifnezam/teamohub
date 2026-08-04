export interface NotificationPayload {
  uid?: string;

  token?: string;

  title: string;

  body: string;

  imageUrl?: string;

  data?: Record<string, string>;

  saveHistory?: boolean;
}