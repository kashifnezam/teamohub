export function productStyles(): string {
  return `
<style>

:root{
  --primary:#4F46E5;
  --success:#059669;
  --background:#F8FAFC;
  --surface:#FFFFFF;
  --text:#111827;
  --muted:#6B7280;
  --border:#E5E7EB;
}

*{
  box-sizing:border-box;
}

html{
  scroll-behavior:smooth;
}

body{
  margin:0;
  background:var(--background);
  color:var(--text);
  font-family:Inter,system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,sans-serif;
  -webkit-font-smoothing:antialiased;
  text-rendering:optimizeLegibility;
}

a{
  text-decoration:none;
}

img{
  max-width:100%;
  display:block;
}

.product-page{
  padding:48px 0;
}

.page-container{
  max-width:980px;
}

.product-card{
  background:var(--surface);
  border:1px solid var(--border);
  border-radius:16px;
  overflow:hidden;
  box-shadow:0 .125rem .5rem rgba(15,23,42,.04);
}

.product-image{
  width:100%;
  aspect-ratio:1/1;
  object-fit:cover;
  border-radius:16px;
}

.thumbnail-list{
  display:flex;
  gap:10px;
  margin-top:16px;
  overflow-x:auto;
  padding-bottom:4px;
}

.thumbnail{
  width:72px;
  height:72px;
  border-radius:12px;
  overflow:hidden;
  border:2px solid transparent;
  cursor:pointer;
  flex:none;
  transition:border-color .2s;
}

.thumbnail.active{
  border-color:var(--primary);
}

.thumbnail img{
  width:100%;
  height:100%;
  object-fit:cover;
}

.product-title{
  font-size:2rem;
  font-weight:700;
  line-height:1.25;
  margin-bottom:12px;
}

.product-price{
  font-size:2rem;
  font-weight:600;
  color:var(--success);
  margin-bottom:18px;
}

.product-meta{
  display:flex;
  flex-wrap:wrap;
  gap:16px;
  color:var(--muted);
  font-size:.95rem;
  margin-bottom:18px;
}

.product-meta span{
  display:flex;
  align-items:center;
  gap:6px;
}

.condition-badge{
  display:inline-flex;
  align-items:center;
  padding:.45rem .85rem;
  border-radius:999px;
  background:#EEF2FF;
  color:var(--primary);
  font-weight:600;
  font-size:.875rem;
}

.section-card{
  background:var(--surface);
  border:1px solid var(--border);
  border-radius:16px;
  padding:24px;
  box-shadow:0 .125rem .5rem rgba(15,23,42,.04);
}

.section-title{
  font-size:1.2rem;
  font-weight:700;
  margin-bottom:18px;
}

.description{
  color:#374151;
  line-height:1.8;
  white-space:pre-wrap;
}

.info-grid{
  display:grid;
  grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
  gap:16px;
}

.info-item{
  border:1px solid var(--border);
  border-radius:12px;
  padding:16px;
}

.info-label{
  display:block;
  color:var(--muted);
  font-size:.82rem;
  margin-bottom:6px;
}

.info-value{
  font-weight:600;
  color:var(--text);
}

.seller{
  display:flex;
  align-items:center;
  gap:16px;
}

.seller-avatar{
  width:64px;
  height:64px;
  border-radius:50%;
  object-fit:cover;
  background:#F1F5F9;
}

.seller-name{
  font-weight:700;
  margin-bottom:4px;
}

.seller-meta{
  color:var(--muted);
  font-size:.9rem;
}

.open-app-btn{
  width:100%;
  padding:.9rem;
  font-weight:600;
  border-radius:12px;
}

.helper-text{
  margin-top:10px;
  text-align:center;
  font-size:.875rem;
  color:var(--muted);
}

.footer{
  margin-top:56px;
  padding:24px 0;
  border-top:1px solid var(--border);
  text-align:center;
  color:var(--muted);
  font-size:.9rem;
}

.footer a{
  color:var(--muted);
  margin:0 10px;
}

.footer a:hover{
  color:var(--primary);
}

@media (max-width:991.98px){

  .product-page{
    padding:24px 0;
  }

  .product-title{
    margin-top:24px;
    font-size:1.75rem;
  }

}

@media (max-width:575.98px){

  .product-title{
    font-size:1.5rem;
  }

  .product-price{
    font-size:1.75rem;
  }

  .section-card{
    padding:18px;
  }

}

</style>
`;
}