const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
	name: {
		type: String,
		required: [true, 'Name required.'],
	},
	username: {
		type: String,
		required: [true, 'Name required.'],
	},
	email: {
		type: String,
		required: [true, 'Email required.'],
		unique: true,
		match: [
			/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
			'Email not valid.',
		],
	},
	role: {
		type: String,
		required: [true, 'Role required']
	},
	password: {
		type: String,
		required: [true, 'Password required.'],
		minlength: 6,
		select: false,
	},
	roleRef: {
		name: {type: String},
		permission: {
			type: Array
		}
	},
    token: {
        type: String,
        default: ""
    },
	},
	{ versionKey: false }
)
module.exports = mongoose.model('User', UserSchema);