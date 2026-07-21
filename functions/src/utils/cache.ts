import { Response } from "express";

export class CacheUtil {

    static setPublicCache(res: Response): void {

        res.set(

            "Cache-Control",

            "public, max-age=300, s-maxage=600, stale-while-revalidate=86400"

        );

    }

}