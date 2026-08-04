import * as admin from "firebase-admin";
import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
const db = admin.firestore();

const USERS = "users";
const REFERRALS = "referrals";

const REFERRAL_REWARD = 10;

const CHARACTERS = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

function requireAuth(uid?: string): string {
  if (!uid) {
    throw new HttpsError(
      "unauthenticated",
      "Authentication required.",
    );
  }

  return uid;
}

function createCode(length = 8): string {
  let code = "";

  for (let i = 0; i < length; i++) {
    code += CHARACTERS.charAt(
      Math.floor(Math.random() * CHARACTERS.length),
    );
  }

  return code;
}

async function getUser(uid: string) {
  const snapshot = await db
    .collection(USERS)
    .doc(uid)
    .get();

  if (!snapshot.exists) {
    throw new HttpsError(
      "not-found",
      "User not found.",
    );
  }

  return snapshot;
}

async function getUserByReferralCode(
  referralCode: string,
) {
  const query = await db
    .collection(USERS)
    .where("referralCode", "==", referralCode)
    .limit(1)
    .get();

  if (query.empty) {
    throw new HttpsError(
      "not-found",
      "Invalid referral code.",
    );
  }

  return query.docs[0];
}

async function generateUniqueReferralCode(): Promise<string> {
  while (true) {
    const code = createCode();

    const exists = await db
      .collection(USERS)
      .where("referralCode", "==", code)
      .limit(1)
      .get();

    if (exists.empty) {
      return code;
    }
  }
}
export const generateReferralCode = onCall(
  {
    region: "asia-south1",
  },
  async (request) => {
      logger.info("Auth", request.auth);
    const uid = requireAuth(request.auth?.uid);

    const userSnap = await getUser(uid);
    const user = userSnap.data()!;

    if (
      typeof user.referralCode === "string" &&
      user.referralCode.trim() !== ""    ) {
      return {
        referralCode: user.referralCode,
      };
    }

    const referralCode = await generateUniqueReferralCode();

    await userSnap.ref.update({
      referralCode,
      rewardPoints: user.rewardPoints ?? 0,
      referredBy: user.referredBy ?? null,
      hasUsedReferral: user.hasUsedReferral ?? false,
      successfulReferrals: user.successfulReferrals ?? 0,
      totalRewardEarned: user.totalRewardEarned ?? 0,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      referralCode,
    };
  },
);
export const validateReferral = onCall(
  {
    region: "asia-south1",
  },
  async (request) => {
    const uid = requireAuth(request.auth?.uid);

    const referralCode = String(
      request.data.referralCode ?? "",
    )
      .trim()
      .toUpperCase();

    if (!referralCode) {
      throw new HttpsError(
        "invalid-argument",
        "Referral code is required.",
      );
    }

    const currentUserSnap = await getUser(uid);
    const currentUser = currentUserSnap.data()!;

    if (currentUser.hasUsedReferral === true) {
      throw new HttpsError(
        "failed-precondition",
        "Referral already used.",
      );
    }

const existingReferrer = currentUser.referredBy as string | null;

    if (existingReferrer != null &&
        existingReferrer.trim().length > 0) {
      throw new HttpsError(
        "failed-precondition",
        "Referral already applied.",
      );
    }

    const referrerDoc = await getUserByReferralCode(
      referralCode,
    );

    if (referrerDoc.id === uid) {
      throw new HttpsError(
        "failed-precondition",
        "You cannot use your own referral code.",
      );
    }

    return {
      success: true,
      valid: true,
      referrerId: referrerDoc.id,
      referrerName: referrerDoc.get("name") ?? "",
      rewardPoints: REFERRAL_REWARD,
    };
  },
);
export const applyReferral = onCall(
  {
    region: "asia-south1",
  },
  async (request) => {
    const uid = requireAuth(request.auth?.uid);

    const referralCode = String(
      request.data.referralCode ?? "",
    )
      .trim()
      .toUpperCase();

    if (!referralCode) {
      throw new HttpsError(
        "invalid-argument",
        "Referral code is required.",
      );
    }

    const referredUserSnap = await getUser(uid);
    const referredUser = referredUserSnap.data()!;

    if (referredUser.hasUsedReferral === true) {
      throw new HttpsError(
        "failed-precondition",
        "Referral already used.",
      );
    }

    const existingReferrer = referredUser.referredBy as string | null;

    if (existingReferrer && existingReferrer.trim().length > 0) {
      throw new HttpsError(
        "failed-precondition",
        "Referral already applied.",
      );
    }

    const referrerDoc = await getUserByReferralCode(referralCode);

    if (referrerDoc.id === uid) {
      throw new HttpsError(
        "failed-precondition",
        "You cannot refer yourself.",
      );
    }

    const duplicateReferral = await db
      .collection(REFERRALS)
      .where("referredUserId", "==", uid)
      .limit(1)
      .get();

    if (!duplicateReferral.empty) {
      throw new HttpsError(
        "already-exists",
        "Referral already processed.",
      );
    }

    await db.runTransaction(async (transaction) => {
      const referrerSnap = await transaction.get(referrerDoc.ref);
      const referredSnap = await transaction.get(referredUserSnap.ref);

      if (!referrerSnap.exists || !referredSnap.exists) {
        throw new HttpsError(
          "not-found",
          "User not found.",
        );
      }

      const referrer = referrerSnap.data()!;
      const referred = referredSnap.data()!;

      const referralRef = db.collection(REFERRALS).doc();

      transaction.set(referralRef, {
        referrerId: referrerDoc.id,
        referrerCode: referrer.referralCode,
        referredUserId: uid,
        referredUserName: referred.name ?? "",
        rewardPoints: REFERRAL_REWARD,
        status: "completed",
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      transaction.update(referrerDoc.ref, {
        rewardPoints:
          (referrer.rewardPoints ?? 0) + REFERRAL_REWARD,
        successfulReferrals:
          (referrer.successfulReferrals ?? 0) + 1,
        totalRewardEarned:
          (referrer.totalRewardEarned ?? 0) + REFERRAL_REWARD,
      });

      transaction.update(referredUserSnap.ref, {
        rewardPoints:
          (referred.rewardPoints ?? 0) + REFERRAL_REWARD,
        referredBy: referrerDoc.id,
        hasUsedReferral: true,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    });

    return {
      success: true,
      rewardPoints: REFERRAL_REWARD,
      message: "Referral applied successfully.",
    };
  },
);