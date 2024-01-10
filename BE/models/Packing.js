const mongoose = require('mongoose');

const PackingSchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Packing', PackingSchema);