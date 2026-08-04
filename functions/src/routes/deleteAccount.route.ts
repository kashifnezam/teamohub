import { Router } from "express";
import deleteAccountController from "../controllers/deleteAccount.controller";

const router = Router();

router.get(
    "/delete-account",
    deleteAccountController.page
);

router.post(
    "/delete-account/send-otp",
    deleteAccountController.sendOtp
);

router.post(
    "/delete-account/verify-otp",
    deleteAccountController.verifyOtp
);

router.post("/delete-account/delete", deleteAccountController.deleteAccount);


export default router;