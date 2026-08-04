import nodemailer from "nodemailer";
import "dotenv/config";

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.EMAIL,
        pass: process.env.EMAIL_PASSWORD
    }
});

export async function sendOtpEmail(email: string, otp: string) {

    await transporter.sendMail({
        from: process.env.EMAIL,
        to: email,
        subject: "TeamoMart Account Deletion OTP",
        html: `
            <h2>Delete Account OTP</h2>
            <p>Your OTP is:</p>
            <h1>${otp}</h1>
            <p>Valid for 5 minutes.</p>
        `
    });

}