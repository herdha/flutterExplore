const mongoose = require('mongoose');

const DeliverySchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Delivery', DeliverySchema);