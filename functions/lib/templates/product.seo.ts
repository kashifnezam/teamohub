export function productSeo({
  product,
  image,
  url,
  price,
  location,
}: {
  product: any;
  image: string;
  url: string;
  price: string;
  location: string;
}): string {
  const description = (product.description || "")
    .replace(/"/g, '\\"')
    .substring(0, 160);

  const title = `${product.title} | TeamoMart`;

  const availability =
    product.status === "sold"
      ? "https://schema.org/OutOfStock"
      : "https://schema.org/InStock";

  const publishedDate =
    product.createdAt &&
    typeof product.createdAt.toDate === "function"
      ? product.createdAt.toDate().toISOString()
      : "";

  return `
<meta charset="UTF-8">

<meta
name="viewport"
content="width=device-width, initial-scale=1">

<title>${title}</title>

<meta
name="description"
content="${description}">

<meta
name="robots"
content="index,follow">

<link
rel="canonical"
href="${url}">

<!-- Open Graph -->

<meta
property="og:type"
content="product">

<meta
property="og:site_name"
content="TeamoMart">

<meta
property="og:title"
content="${product.title}">

<meta
property="og:description"
content="${price} • ${location}">

<meta
property="og:image"
content="${image}">

<meta
property="og:url"
content="${url}">

<!-- Twitter -->

<meta
name="twitter:card"
content="summary_large_image">

<meta
name="twitter:title"
content="${product.title}">

<meta
name="twitter:description"
content="${price} • ${location}">

<meta
name="twitter:image"
content="${image}">

<meta
name="theme-color"
content="#4F46E5">

<script type="application/ld+json">
{
  "@context":"https://schema.org",
  "@type":"Product",

  "name":"${product.title}",

  "description":"${description}",

  "image":[
    "${image}"
  ],

  "sku":"${product.id}",

  "category":"${product.categoryId || ""}",

  "brand":{
    "@type":"Brand",
    "name":"${product.brand || "Unknown"}"
  },

  "offers":{
    "@type":"Offer",
    "price":"${product.price}",
    "priceCurrency":"INR",
    "availability":"${availability}",
    "url":"${url}"
  },

  "seller":{
    "@type":"Organization",
    "name":"TeamoMart"
  },

  "datePublished":"${publishedDate}"
}
</script>
`;
}