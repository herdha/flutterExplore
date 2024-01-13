const Assignment = require("../models/assignment")
const user = require("../models/user")

exports.getAllTask = async (req, res) => {
    // console.log(req)
    // console.log(req.session)
    const token = req.headers.authorization.slice(7)
    if(token){
        await user.find({token: token})
        .then((data)=>{
            if(data[0].role == "User Biasa"){
                const filter = {uid: data[0].id, username: data[0].username, role: data[0].role}
                Assignment.find({assignTo: filter})
                .then((d)=>{
                    res.send(d)
                })
                .catch((e)=>{
                    res.send({message: e})
                })
            } else {
                Assignment.find()
                .then((d)=>{
                    res.send(d)
                })
                .catch((e)=>{
                    res.send({message: e})
                })
            }
        })
        .catch((e)=>{
            res.send({message: e})
        })        
    } else {
        res.send({message: 'Required token'})
    }
}

exports.postTask = async (req, res) => {
    const tokenAuth = req.headers.authorization
    if(tokenAuth) {
        const data = req.body
        const token = tokenAuth.slice(7)
        let assignBy, assignTo = {}
        
        await user.findOne({token: token})
        .then((d)=>{
            assignBy = {
                uid: d.id,
                username: d.username,
                role: d.role
            }
        })

        if(data.assignTo){
            await user.findOne({_id: data.assignTo})
            .then((d)=>{
                assignTo = {
                    uid: d.id,
                    username: d.username,
                    role: d.role
                }
                
                const dataTask = new Assignment({
                    title: data.title,
                    description: data.description,
                    assignBy: assignBy,
                    areaStart: {
                        areaName: data.areaStart.location,
                        long: data.areaStart.long,
                        lat: data.areaStart.lat
                    },
                    areaEnd: {
                        areaName: data.areaEnd.location,
                        long: data.areaEnd.long,
                        lat: data.areaEnd.lat
                    },
                    assignTo: assignTo
                })
                console.log(dataTask)
                
                dataTask.save()
                // .then(()=>{
                //     res.send({message: "Assignment has submitted"})
                // })
                res.status(200).send(dataTask)
            })
        } else {
            return res.status(400).send({message: 'You have not assigned user'})
        }        

    } else {
        res.status(401).send({message: "Need authorization"})
    }
}

exports.editTask = async (req, res) => {
    const id = req.params.id
    const data = req.body
    if(id){
        // await Assignment.findByIdAndUpdate({id, data})
        // .then((d)=>{
            console.log(data)
            res.status(200).send(d)
        // })
        // .catch((e)=>{
        //     res.status(500).send({message: e.message})
        // })
    }
}

exports.delTask = async (req, res) => {
    const id = req.params.id
    // id ? res.status(200).send({message: "data has deleted"}) : res.status(500).send({message: err.message})
    await Assignment.findByIdAndDelete(id)
    .then(()=>{
        res.status(200).send({message: "Data has deleted successfully"})
    })
    .catch((err)=>{
        res.status(500).send({message: err.message})
    })
}

exports.getOneTask = async (req, res) => {
    const id = req.params.id
    await Assignment.findById(id)
    .then((d)=>{
        res.status(200).send(d)
    })
    .catch((e)=>{
        res.status(400).send({message: e.message})
    })
}

exports.startTask = async (req, res) => {
    const id = req.params.id
    const timeStart = new Date().toLocaleString()
    const userLong = req.body.long
    const userLat = req.body.lat
    let status = null
    let long = null
    let lat = null
    let dataStart = {
        statusTask: 'Running',
        timeStart: timeStart,
    }

    await Assignment.findById(id)
    .then((d)=>{
        status = d.statusTask
        long = d.areaStart.long
        lat = d.areaStart.lat
    })

    let jarakTitik = calculateDistance(lat, long, userLat, userLong)
    if(jarakTitik < 200){
        res.status(400).send('You are too far, come closer')
    } else {
        if(status==='On'){
            await Assignment.findByIdAndUpdate(id, dataStart)
            .then((d)=>{
                res.status(200).send('Task is running')
            })
            .catch((e)=>{
                res.status(404).send({message: e.message})
            })
        } else if (status==="Running"){
            res.status(400).send('Task has been running')        
        } else {
            res.status(400).send("Task has done")
        }
    }   
}

exports.endTask = async (req, res) => {
    const id = req.params.id
    const userLong = req.body.long
    const userLat = req.body.lat
    const note = req.body.note
    let long = null
    let lat = null
    let dataTimeEnd = new Date().toLocaleString()
    let dataTimeStart = null
    let status = null

    await Assignment.findById(id)
    .then((d)=>{
        dataTimeStart = new Date(d.timeStart).getTime()
        status = d.statusTask
        long = d.areaEnd.long
        lat = d.areaEnd.lat
    })
    
    let duration = timeDuration(new Date(dataTimeEnd).getTime(), dataTimeStart)
    let dataEnd = {
        statusTask: 'Off',
        timeEnd: dataTimeEnd,
        timeTotal: duration,
        note: note
    }

    let jarakTitik = calculateDistance(lat, long, userLat, userLong)

    if(jarakTitik > 200) {
        res.status(400).send('You are too far, come closer')
    } else {
        if(status === "Running"){
            await Assignment.findByIdAndUpdate(id, dataEnd)
            .then((d)=>{
                res.status(200).send("Task has done")
            })
            .catch((e)=>{
                res.status(401).send({message: e.message})
            })
        } else if(status === "On"){
            res.status(400).send("Task has not started")
        } else {
            res.status(400).send("Task has done")
        }
    }
}

function timeDuration(t1, t2){
    let distance = Math.abs(t1 - t2);
    const hours = Math.floor(distance / 3600000);
    distance -= hours * 3600000;
    const minutes = Math.floor(distance / 60000);
    distance -= minutes * 60000;
    const seconds = Math.floor(distance / 1000);
    return `${hours}:${('0' + minutes).slice(-2)}:${('0' + seconds).slice(-2)}`;
}

function calculateDistance(lat1, lon1, lat2, lon2) {
    const R = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    const radLat1 = (lat1 * Math.PI) / 180;
    const radLon1 = (lon1 * Math.PI) / 180;
    const radLat2 = (lat2 * Math.PI) / 180;
    const radLon2 = (lon2 * Math.PI) / 180;

    // Calculate the change in coordinates
    const dLat = radLat2 - radLat1;
    const dLon = radLon2 - radLon1;

    // Haversine formula to calculate distance
    const a =
        Math.sin(dLat / 2) ** 2 +
        Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(dLon / 2) ** 2;
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    // Distance in kilometers
    const distance = R * c;

    return distance;
}