import { Router } from "express";
import productController from "../controllers/product.controller";

const router = Router();

router.get("/p/:id", (req, res) => {
    productController.getProduct(req, res);
});

export default router;