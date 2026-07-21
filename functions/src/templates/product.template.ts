"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.renderProductPage = renderProductPage;

export function renderProductPage(
  product: any,
  relatedProducts: any[],
  seller: any
) {
    const image = product.images && product.images.length > 0
        ? product.images[0]
        : "https://teamomart.web.app/assets/images/product-placeholder.webp";
    const url = `https://teamomart.web.app/p/${product.id}`;
    const price = new Intl.NumberFormat("en-IN", {
        style: "currency",
        currency: "INR",
        maximumFractionDigits: 0,
    }).format(product.price);
    const location = [product.city, product.state]
        .filter(Boolean)
        .join(", ");
    const postedDate = product.createdAt && typeof product.createdAt.toDate === "function"
        ? product.createdAt.toDate().toLocaleDateString("en-IN", {
            day: "numeric",
            month: "long",
            year: "numeric",
        })
        : "";
    return `
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width,initial-scale=1">

<title>${product.title} | TeamoMart</title>

<meta name="description"
content="${product.description.substring(0, 160)}">

<meta name="robots"
content="index,follow">

<link rel="canonical"
href="${url}">

<meta property="og:type"
content="product">

<meta property="og:site_name"
content="TeamoMart">

<meta property="og:title"
content="${product.title}">

<meta property="og:description"
content="${price} • ${location}">

<meta property="og:image"
content="${image}">

<meta property="og:url"
content="${url}">

<meta name="twitter:card"
content="summary_large_image">

<meta name="twitter:title"
content="${product.title}">

<meta name="twitter:description"
content="${price} • ${location}">

<meta name="twitter:image"
content="${image}">

<script type="application/ld+json">
{
 "@context":"https://schema.org",
 "@type":"Product",
 "name":"${product.title}",
 "description":"${product.description.replace(/"/g, '\\"')}",
 "image":"${image}",
 "category":"${product.categoryId}",
 "offers":{
    "@type":"Offer",
    "price":"${product.price}",
    "priceCurrency":"INR",
    "availability":"https://schema.org/${product.status === "sold"
        ? "OutOfStock"
        : "InStock"}",
    "url":"${url}"
 }
}
</script>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,Helvetica,sans-serif;
}

body{
background:#f5f7fb;
color:#222;
}

a{
text-decoration:none;
color:inherit;
}

img{
display:block;
width:100%;
}

.container{
max-width:1400px;
margin:auto;
padding:20px;
}



body{
    margin:0;
    background:#F6F7FB;
    font-family:Inter,Arial,sans-serif;
    color:#222;
}

.tm-header{

    position:sticky;
    top:0;
    z-index:1000;

    background:#fff;

    border-bottom:1px solid #E5E7EB;

}

.header-container{

    max-width:1400px;

    margin:auto;

    height:72px;

    display:flex;

    align-items:center;

    justify-content:space-between;

    padding:0 24px;

}

.logo{

    display:flex;

    align-items:center;

    gap:10px;

    text-decoration:none;

    color:#4F46E5;

    font-size:28px;

    font-weight:700;

}

.logo-icon{

    font-size:30px;

}

.header-actions{

    display:flex;

    gap:12px;

}

.header-btn{

    background:#4F46E5;

    color:white;

    padding:12px 22px;

    border-radius:10px;

    font-weight:600;

}

.header-icon{

    border:none;

    background:white;

    border:1px solid #ddd;

    padding:12px 20px;

    border-radius:10px;

    cursor:pointer;

}

.container{

    max-width:1400px;

    margin:auto;

    padding:30px 20px;

}

.breadcrumb{

    display:flex;

    align-items:center;

    gap:10px;

    color:#777;

    font-size:14px;

    margin-bottom:25px;

}

.product-wrapper{

    display:grid;

    grid-template-columns:520px 1fr;

    gap:40px;

    align-items:start;

}

.gallery-column{

    min-height:600px;

}

.info-column{

    min-height:600px;

}

.description-section,

.seller-section,

.related-section{

    margin-top:40px;

}
.gallery-layout{

    display:grid;

    grid-template-columns:90px 1fr;

    gap:18px;

}

.thumbnail-column{

    display:flex;

    flex-direction:column;

    gap:12px;

}

.thumb{

    width:90px;

    height:90px;

    border-radius:12px;

    overflow:hidden;

    cursor:pointer;

    border:2px solid transparent;

    background:white;

    transition:.25s;

    box-shadow:0 2px 8px rgba(0,0,0,.05);

}

.thumb:hover{

    border-color:#4F46E5;

}

.thumb.active{

    border-color:#4F46E5;

}

.thumb img{

    width:100%;

    height:100%;

    object-fit:cover;

}

.main-image-column{

    width:100%;

}

.image-card{

    position:relative;

    background:white;

    border-radius:18px;

    padding:20px;

    box-shadow:0 10px 35px rgba(0,0,0,.06);

}

.image-card img{

    width:100%;

    height:520px;

    object-fit:contain;

}

.sold-badge{

    position:absolute;

    top:20px;

    left:20px;

    background:#DC2626;

    color:white;

    padding:8px 18px;

    border-radius:50px;

    font-size:13px;

    font-weight:700;

    z-index:10;

}
.product-info-card{

    position:sticky;

    top:95px;

    background:#fff;

    border-radius:18px;

    padding:32px;

    box-shadow:0 10px 35px rgba(0,0,0,.06);

}

.verified-row{

    display:flex;

    justify-content:space-between;

    align-items:center;

    margin-bottom:18px;

}

.verified-badge{

    background:#EEF4FF;

    color:#4F46E5;

    padding:8px 16px;

    border-radius:50px;

    font-size:13px;

    font-weight:600;

}

.product-status{

    padding:8px 16px;

    border-radius:50px;

    font-size:13px;

    font-weight:600;

    text-transform:capitalize;

}

.product-status.active{

    background:#ECFDF5;

    color:#059669;

}

.product-status.sold{

    background:#FEE2E2;

    color:#DC2626;

}

.product-title{

    font-size:34px;

    font-weight:700;

    line-height:1.4;

    margin-bottom:24px;

}

.price-row{

    margin-bottom:24px;

}

.price{

    font-size:42px;

    font-weight:700;

    color:#111827;

}

.price-subtitle{

    margin-top:8px;

    color:#6B7280;

    font-size:14px;

}

.location-row{

    display:flex;

    justify-content:space-between;

    flex-wrap:wrap;

    gap:10px;

    color:#6B7280;

    font-size:15px;

    margin:24px 0;

}

.seller-preview{

    display:flex;

    align-items:center;

    gap:16px;

    margin:28px 0;

}

.seller-avatar{

    width:60px;

    height:60px;

    border-radius:50%;

    object-fit:cover;

}

.seller-name{

    font-size:18px;

    font-weight:700;

}

.seller-meta{

    margin-top:4px;

    color:#6B7280;

    font-size:14px;

}

.action-buttons{

    display:flex;

    flex-direction:column;

    gap:14px;

    margin-top:30px;

}

.btn{

    height:54px;

    display:flex;

    justify-content:center;

    align-items:center;

    border-radius:12px;

    font-size:16px;

    font-weight:600;

    cursor:pointer;

    transition:.25s;

}

.btn:hover{

    transform:translateY(-2px);

}

.btn-primary{

    background:#4F46E5;

    color:#fff;

}

.btn-outline{

    background:#fff;

    color:#111827;

    border:1px solid #D1D5DB;

}

.highlights-card{

    margin:30px 0;

}

.section-title{

    font-size:18px;

    font-weight:700;

    margin-bottom:18px;

}

.highlight-grid{

    display:grid;

    grid-template-columns:repeat(2,1fr);

    gap:14px;

}

.highlight-item{

    background:#F8FAFC;

    border:1px solid #E5E7EB;

    border-radius:14px;

    padding:18px;

    transition:.25s;

}

.highlight-item:hover{

    border-color:#4F46E5;

    transform:translateY(-2px);

}

.highlight-label{

    font-size:13px;

    color:#6B7280;

    margin-bottom:8px;

}

.highlight-value{

    font-size:16px;

    font-weight:700;

    color:#111827;

}
.logo {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
}

.logo-icon {
    width: 36px;
    height: 36px;
    object-fit: contain;
    display: block;
}

.logo-text {
    font-size: 1.5rem;
    font-weight: 700;
}

@media(max-width:1000px){

.product-wrapper{

grid-template-columns:1fr;
}
.gallery-layout{

    grid-template-columns:1fr;

}

.thumbnail-column{

    flex-direction:row;

    overflow:auto;

    order:2;

}

.main-image-column{

    order:1;

}

.thumb{

    min-width:75px;

    height:75px;

}

.image-card img{

    height:350px;

}
.product-info-card{

    position:static;

    margin-top:24px;

    padding:24px;

}

.product-title{

    font-size:28px;

}

.price{

    font-size:34px;

}

.location-row{

    flex-direction:column;

}
.highlight-grid{

    grid-template-columns:1fr;

}

}

</style>

</head>

<body>

<header class="tm-header">
    <div class="header-container">

        <a href="/" class="logo">
            <img
                src="https://firebasestorage.googleapis.com/v0/b/teamomart.firebasestorage.app/o/logo%2FGemini_Generated_Image_4j3ava4j3ava4j3a%20(1)%20(1).png?alt=media&token=4dcf8f25-e7cd-47da-ba40-f037592cdb9b"
                alt="TeamoMart Logo"
                class="logo-icon"
            >
            <span class="logo-text">TeamoMart</span>
        </a>

        <div class="header-actions">


            <a href="intent://#Intent;scheme=https;package=com.kashif.teamomart;S.browser_fallback_url=https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.kashif.teamomart;end" class="header-btn">
                Open App
            </a>

            <button class="header-icon" onclick="shareProduct()">
                Share
            </button>

        </div>

    </div>
</header>

<div class="container">

    <nav class="breadcrumb">

        <a href="/">Home</a>

        <span>/</span>

        <span>${product.categoryId || "Category"}</span>

        <span>/</span>

        <span>${product.title}</span>

    </nav>

    <section class="product-wrapper">

        <div class="gallery-column">

            <div class="gallery-column">

                <div class="gallery-layout">

                    <div class="thumbnail-column">

                        ${(product.images || []).map((img: string, index: number) => `

                        <div
                            class="thumb ${index === 0 ? "active" : ""}"
                            onclick="changeImage('${img}',this)">

                            <img
                                src="${img}"
                                loading="lazy"
                                alt="${product.title}">

                        </div>

                        `).join("")}

                    </div>

                    <div class="main-image-column">

                        <div class="image-card">

                            ${product.status === "sold"
        ? `<div class="sold-badge">SOLD</div>`
        : ""}

                            <img
                                id="mainImage"
                                src="${image}"
                                alt="${product.title}">

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <div class="info-column">

           <div class="info-column">

               <div class="product-info-card">

                   <div class="verified-row">

                       <span class="verified-badge">
                           ✔ Verified Listing
                       </span>

                       <span class="product-status ${product.status}">
                           ${product.status || "Available"}
                       </span>

                   </div>

                   <h1 class="product-title">
                       ${product.title}
                   </h1>

                   <div class="price-row">

                       <div class="price">
                           ${price}
                       </div>

                       <div class="price-subtitle">
                           Best Price
                       </div>

                   </div>

                   <div class="highlights-card">

                       <div class="section-title">

                           Product Highlights

                       </div>

                       <div class="highlight-grid">

                           <div class="highlight-item">

                               <div class="highlight-label">

                                   Category

                               </div>

                               <div class="highlight-value">

                                   ${product.categoryId || "-"}

                               </div>

                           </div>

                           <div class="highlight-item">

                               <div class="highlight-label">

                                   Condition

                               </div>

                               <div class="highlight-value">

                                   ${product.condition || "Used"}

                               </div>

                           </div>

                           <div class="highlight-item">

                               <div class="highlight-label">

                                   Status

                               </div>

                               <div class="highlight-value">

                                   ${product.status || "Available"}

                               </div>

                           </div>

                           <div class="highlight-item">

                               <div class="highlight-label">

                                   Location

                               </div>

                               <div class="highlight-value">

                                   ${product.city || "-"}

                               </div>

                           </div>

                       </div>

                   </div>

               </div>

           </div>

        </div>

    </section>

    <section class="description-section">

        <!-- description comes later -->

    </section>

    <section class="seller-section">

        <!-- seller comes later -->

    </section>

    <section class="related-section">

        <!-- related products come later -->

    </section>

</div>
<script>

function changeImage(image,element){

    document.getElementById("mainImage").src=image;

    document.querySelectorAll(".thumb").forEach(function(item){

        item.classList.remove("active");

    });

    element.classList.add("active");

}

async function copyLink(){

    try{

        await navigator.clipboard.writeText(window.location.href);

        alert("Product link copied.");

    }catch(e){

        prompt("Copy this link", window.location.href);

    }

}

async function shareProduct(){

    if(navigator.share){

        navigator.share({

            title:"${product.title}",

            text:"Check out this product on TeamoMart",

            url:window.location.href

        });

        return;

    }

    copyLink();

}

document.getElementById("installBtn").onclick=function(e){

    e.preventDefault();

    const ua=navigator.userAgent.toLowerCase();

    if(/android/.test(ua)){

        window.location.href="https://play.google.com/store/apps/details?id=com.teamomart.app";

        return;

    }

    if(/iphone|ipad|ipod/.test(ua)){

        window.location.href="https://apps.apple.com/app/idXXXXXXXX";

        return;

    }

    alert("Scan the QR code from your mobile to install TeamoMart.");

};

</script>

<footer>

<div class="footer">

© ${new Date().getFullYear()} TeamoMart • Buy • Sell • Discover

</div>

</footer>

<style>

.footer{

margin-top:40px;

padding:30px;

text-align:center;

font-size:14px;

color:#666;

}

</style>

</body>

</html>

`;
}
//# sourceMappingURL=product.template.js.map