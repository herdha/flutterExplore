const express = require("express");
const cors = require("cors");
const cookieSession = require("cookie-session");
const db = require('./config/db')
const router = require('./routes/index')

const app = express();

var corsOptions = {
    origin: "*",
    // methods: ['GET','HEAD','PUT','PATCH','POST','DELETE'],
    // credentials: true,
    // preflightContinue: false
};
  
app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(
    cookieSession({
        name: "mysession",
        keys: ["COOKIE_SECRET"],
        httpOnly: true
    })
);
app.use(router);

db.then(() => {
    console.log("Successfully connect to MongoDB.");
})
.catch(err => {
    console.error("Connection error", err);
});

app.get("/", (req, res) => {
    res.json({ message: "Welcome to my application." });
});

const PORT = process.env.PORT || 8080;
    app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}.`);
});