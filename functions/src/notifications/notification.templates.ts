export class NotificationTemplates {
  static hireRequest(name: string) {
    return {
      title: "New Hire Request",
      body: `${name} sent you a hire request.`,
    };
  }

  static promotionRequest(name: string) {
    return {
      title: "Promotion Request",
      body: `${name} wants you to promote a product.`,
    };
  }

    static chatMessage(
      senderName: string,
      message: string,
    ) {
      return {
        title: senderName,
        body: message,
      };
    }

  static review(name: string) {
    return {
      title: "New Review",
      body: `${name} left a review on your profile.`,
    };
  }

  static listingSold(title: string) {
    return {
      title: "Product Sold",
      body: `${title} has been marked as sold.`,
    };
  }
}