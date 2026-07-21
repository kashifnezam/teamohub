import { productSeo } from "./product.seo";
import { productScripts } from "./product.scripts";
import { productStyles } from "./product.styles";

export function renderProductPage(
  product: any,
  relatedProducts: any[] = [],
  seller?: any,
): string {

  const image =
    product.images && product.images.length > 0
      ? product.images[0]
      : "https://teamomart.web.app/assets/images/product-placeholder.webp";

  const url = `https://teamomart.web.app/p/${product.id}`;

  const price = new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 0,
  }).format(product.price || 0);

  const location = [product.city, product.state]
    .filter(Boolean)
    .join(", ");

  const postedDate =
    product.createdAt &&
    typeof product.createdAt?.toDate === "function"
      ? product.createdAt.toDate().toLocaleDateString("en-IN", {
          day: "numeric",
          month: "long",
          year: "numeric",
        })
      : "";

  const memberSince = seller?.createdAt
    ? (
        typeof seller.createdAt?.toDate === "function"
          ? seller.createdAt.toDate()
          : new Date(seller.createdAt)
      ).getFullYear()
    : "-";

return `

<!DOCTYPE html>

<html lang="en">

<head>

${productSeo({
  product,
  image,
  url,
  price,
  location,
})}

${productStyles()}

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="preconnect"
href="https://fonts.googleapis.com">

<link
rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link
href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body>

<!-- HTML FROM PART 1 -->

<!-- HTML FROM PART 2 -->

<!-- HTML FROM PART 3 -->

${productScripts(product)}

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>

`;
}

}