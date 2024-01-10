const mongoose = require('mongoose');

const VehicleSchema = new mongoose.Schema({
        vehicleName: {
            type: String
        },
        licensePlate: {
            type: String
        },
        vehicleType: {
            type: String
        },
        app: {
            type: String
        },
        status: {
            type: String
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
module.exports = mongoose.model('Vehicle', VehicleSchema);