const mongoose = require("mongoose");

// connect to db
// single record db (aggregate) = fullstack
// sparated record db = stack
const db = mongoose.connect('mongodb://localhost/fullstack', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})

module.exports = db