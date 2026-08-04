import { Request, Response } from "express";
import admin from "firebase-admin";
import crypto from "crypto";
import { renderDeleteAccountPage } from "../templates/deleteAccount.template";
import { sendOtpEmail } from "../services/email.service";

const otpStore = new Map<
    string,
    { otp: string; expires: number }
>();
const verifiedUsers = new Set<string>();

class DeleteAccountController {

    async page(req: Request, res: Response) {

        return res.send(renderDeleteAccountPage());

    }

    async sendOtp(req: Request, res: Response) {

        try {

            const email = String(req.body.email).trim().toLowerCase();

            await admin.auth().getUserByEmail(email);

            const otp = crypto.randomInt(100000, 999999).toString();

            otpStore.set(email, {
                otp,
                expires: Date.now() + 5 * 60 * 1000
            });

            await sendOtpEmail(email, otp);

            return res.send(`
            <h2>OTP Sent</h2>

            <form method="POST" action="/delete-account/verify-otp">

                <input type="hidden" name="email" value="${email}">

                <input
                    name="otp"
                    placeholder="Enter OTP"
                    required>

                <button>Verify OTP</button>

            </form>
            `);

       } catch (e: any) {

           console.error(e);

           return res.status(500).send(e.message);

       }

    }

    async verifyOtp(req: Request, res: Response) {

        const email = String(req.body.email).trim().toLowerCase();

        const otp = String(req.body.otp);

        const data = otpStore.get(email);

        if (
            !data ||
            data.otp !== otp ||
            data.expires < Date.now()
        ) {

            return res.status(400).send("Invalid or Expired OTP");

        }

        otpStore.delete(email);

        verifiedUsers.add(email);

        return res.send(`

    <!DOCTYPE html>

    <html>

    <body style="
    font-family:Arial;
    background:#f5f5f5;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    ">

    <div style="
    width:380px;
    background:white;
    padding:25px;
    border-radius:12px;
    ">

    <h2>Delete Account</h2>

    <p style="color:#DC2626">

    This action is permanent.<br><br>

    • All products will be deleted.<br>
    • Chats will be deleted.<br>
    • Orders may become inaccessible.<br>
    • This cannot be undone.

    </p>

    <form method="POST" action="/delete-account/delete">

    <input
    type="hidden"
    name="email"
    value="${email}">

    <button
    style="
    width:100%;
    padding:12px;
    background:#DC2626;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    ">

    Delete My Account

    </button>

    </form>

    </div>

    </body>

    </html>

    `);

    }

    async deleteAccount(req: Request, res: Response) {

        try {

            const email = String(req.body.email).trim().toLowerCase();

            if (!verifiedUsers.has(email)) {

                return res.status(403).send("OTP verification required");

            }

            verifiedUsers.delete(email);

            const user = await admin.auth().getUserByEmail(email);

            const db = admin.firestore();

            await db.collection("users").doc(user.uid).delete();

            // Delete your other collections here
            // products
            // chats
            // orders
            // favourites
            // notifications
            // storage files

            await admin.auth().deleteUser(user.uid);

            return res.send(`

    <!DOCTYPE html>

    <html>

    <body style="
    font-family:Arial;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    background:#f5f5f5;
    ">

    <div style="
    background:white;
    padding:35px;
    border-radius:12px;
    text-align:center;
    ">

    <h2 style="color:#16A34A">

    Account Deleted

    </h2>

    <p>

    Your account has been permanently deleted.

    </p>

    </div>

    </body>

    </html>

    `);

        } catch (e) {

            console.error(e);

            return res.status(500).send("Failed to delete account");

        }

    }

}

export default new DeleteAccountController();