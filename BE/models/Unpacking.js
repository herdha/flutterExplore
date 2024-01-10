const mongoose = require('mongoose');

const UnpackingSchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Unpacking', UnpackingSchema);