const mongoose = require('mongoose');

const PickingSchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Picking', PickingSchema);