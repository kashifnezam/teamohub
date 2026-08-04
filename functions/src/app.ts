import express from "express";
import cors from "cors";
import helmet from "helmet";
import compression from "compression";
import morgan from "morgan";
import productRoutes from "./routes/product.routes";
import deleteAccountRoute from "./routes/deleteAccount.route";

const app=express();

app.use(

helmet({

contentSecurityPolicy:false

})

);

app.use(cors());

app.use(compression());

app.use(morgan("combined"));

app.use(express.json());

app.use("/",productRoutes);
app.use("/", deleteAccountRoute);


app.get("/",(_,res)=>{

res.send("TeamoMart Product Service");

});

export default app;