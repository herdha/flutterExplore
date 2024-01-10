const express = require("express");
const UserController = require('../controllers/UserController')
const AssignmentController = require('../controllers/AssignmentController')
const DashboardController = require('../controllers/DashboardController')
const verifyToken = require('../middleware/verifyToken')
const router = express.Router();

router.get('/getUser', UserController.getUser)
router.post('/postUser', UserController.postUser)
router.post('/login', UserController.userSignin)
router.put('/editUser/:id', UserController.editUser)
router.get('/currentActive/:token', UserController.getUserActive)
router.get('/logout/:token', UserController.userLogout)

router.get('/allTask', AssignmentController.getAllTask)
router.post('/addTask', AssignmentController.postTask)
router.put('/editTask', AssignmentController.editTask)
router.delete('/delTask/:id', AssignmentController.delTask)
router.get('/getOneTask/:id', AssignmentController.getOneTask)
router.put('/startTask/:id', AssignmentController.startTask)
router.put('/endTask/:id', AssignmentController.endTask)

router.get('/driver', DashboardController.dataDriver)
router.get('/vehicle', DashboardController.dataVehicle)
router.get('/inoutbound', DashboardController.dataInvsOut)
router.get('/inboundMonth', DashboardController.dataInboundMonth)
router.get('/outboundMonth', DashboardController.dataOutboundMonth)
router.get('/inboundWeek', DashboardController.dataInboundWeek)
router.get('/outboundWeek', DashboardController.dataOutboundWeek)
router.get('/orderfulfilment', DashboardController.dataOrderFulfilment)
router.get('/orderfillrate', DashboardController.dataOrderFillRate)
router.get('/notgoodrate', DashboardController.dataNotGoodRate)

module.exports = router