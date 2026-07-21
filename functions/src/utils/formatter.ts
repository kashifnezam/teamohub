export class Formatter {

    static currency(price: number): string {

        return new Intl.NumberFormat("en-IN", {

            style: "currency",

            currency: "INR",

            maximumFractionDigits: 0

        }).format(price);

    }

    static date(date: Date): string {

        return new Intl.DateTimeFormat("en-IN", {

            day: "numeric",

            month: "long",

            year: "numeric"

        }).format(date);

    }

    static location(city: string, state: string): string {

        if (!city && !state) {

            return "";

        }

        if (!city) {

            return state;

        }

        if (!state) {

            return city;

        }

        return `${city}, ${state}`;

    }

}