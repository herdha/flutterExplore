const mongoose = require('mongoose');

const PutawaySchema = new mongoose.Schema(
    {},
    {strict: false},
	{ versionKey: false }
)
module.exports = mongoose.model('Putaway', PutawaySchema);