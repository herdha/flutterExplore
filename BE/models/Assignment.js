const mongoose = require('mongoose');
const User = require('./user')

const AssignmentSchema = new mongoose.Schema({
	title: {
		type: String,
		required: [true, 'Name required.'],
	},
    description: {
        type: String,
    },
    assignBy: {
        type: Object,
        uid: {
            type: String
        },
        username: {
            type: String
        },
        role: {
            type: String
        }
    },
    statusTask: {
        type: String,
        default: 'On'
    },
    areaStart:{
        type: Object,
        areaName: {
            type: String
        },
        long: {
            type: Number
        },
        lat: {
            type: Number
        }
    },
    areaEnd:{
        type: Object,
        areaName: {
            type: String
        },
        long: {
            type: Number
        },
        lat: {
            type: Number
        }
    },
    assignTo: {
        type: Object,
        uid: {
            type: String
        },
        username: {
            type: String
        },
        role: {
            type: String
        }
    },
    timeStart:{type: String, default: ''},
    timeEnd: {type: String, default: ''},
    timeTotal: {type: String, default: ''}
	},
	{ versionKey: false }
)
module.exports = mongoose.model('Assignment', AssignmentSchema);