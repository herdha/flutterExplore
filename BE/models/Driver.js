const mongoose = require('mongoose');

const DriverSchema = new mongoose.Schema({
        name: {
            type: String
        },
        driverID: {
            type: String
        },
        status: {
            type: String
        },
        driverLicense: {
            type: String
        },
        props: {
            type: Object,
            app: {
                type: String
            }
        },
        createdAt: {
            type: String
        },
        updatedAt: {
            type: String
        },
        id: {
            type: String
        }
	},
	{ versionKey: false }
)
module.exports = mongoose.model('driver', DriverSchema);