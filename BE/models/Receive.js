const mongoose = require('mongoose');

const ReceiveSchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Receive', ReceiveSchema);