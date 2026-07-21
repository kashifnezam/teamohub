import { Request, Response } from "express";
import firestoreService from "../services/firestore.service";
import { renderProductPage } from "../templates/product.template";

class ProductController {
    async getProduct(
        req: Request,
        res: Response
    ) {

        try {

            const productId = String(req.params.id);

            const product = await firestoreService.getProduct(productId);

            if (!product) {

                return res.status(404).send(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Product Not Found</title>
                    <style>
                        body{
                            margin:0;
                            display:flex;
                            justify-content:center;
                            align-items:center;
                            height:100vh;
                            font-family:Arial;
                            background:#f5f5f5;
                        }

                        .card{
                            background:white;
                            padding:40px;
                            border-radius:12px;
                            box-shadow:0 5px 20px rgba(0,0,0,.1);
                            text-align:center;
                        }

                        h1{
                            color:#4F46E5;
                        }

                        a{
                            display:inline-block;
                            margin-top:20px;
                            color:white;
                            background:#4F46E5;
                            padding:12px 24px;
                            border-radius:8px;
                            text-decoration:none;
                        }

                    </style>
                </head>

                <body>

                    <div class="card">

                        <h1>404</h1>

                        <h2>Product Not Found</h2>

                        <p>This product doesn't exist.</p>

                        <a href="https://teamomart.web.app">

                            Go Home

                        </a>

                    </div>

                </body>

                </html>
                `);

            }

            if (product.isDeleted) {

                return res.status(410).send(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Product Removed</title>

                    <style>

                    body{

                        font-family:Arial;

                        display:flex;

                        justify-content:center;

                        align-items:center;

                        height:100vh;

                        background:#f5f5f5;

                    }

                    .card{

                        background:white;

                        padding:40px;

                        border-radius:12px;

                        text-align:center;

                        box-shadow:0 5px 20px rgba(0,0,0,.1);

                    }

                    h1{

                        color:#DC2626;

                    }

                    </style>

                </head>

                <body>

                <div class="card">

                    <h1>Product Removed</h1>

                    <p>This listing is no longer available.</p>

                </div>

                </body>

                </html>
                `);

            }

               const relatedProducts =
                   await firestoreService.getRelatedProducts(product);

               const seller =
                   await firestoreService.getSeller(product.sellerId);

               const html = renderProductPage(
                   product,
                   relatedProducts,
                   seller
               );
            return res.status(200).send(html);

        }

        catch (e) {

            console.error(e);

            return res.status(500).send(`
            <!DOCTYPE html>

            <html>

            <body style="font-family:Arial;text-align:center;padding:100px">

                <h1>500</h1>

                <h2>Internal Server Error</h2>

            </body>

            </html>
            `);

        }

    }

}

export default new ProductController();