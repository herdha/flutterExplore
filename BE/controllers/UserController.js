const User = require("../models/user");
const jwt = require('jsonwebtoken')

exports.getUser = async (req, res) => {
    await User.find().select("+password")
    .then((d)=>{
        res.send(d);
    })
    .catch((e)=>{
        res.send(e)
    })
}

exports.postUser = async (req, res) => {
    const userAdmin = {
        name: 'Super Admin',
        permission: [
            {
                name: 'Common',
                allAccess: true,
                menu: [
                    {
                        name: 'Dashboard',
                        view: false,
                    }, 
                    {
                        name: 'Item',
                        view: true,
                        add: false,
                        edit: false,
                        delete: false,
                    }, 
                    {
                        name: 'Scan Barcode',
                        view: true,
                        scan: true,
                    }, 
                    {
                        name: 'Task',
                        view: true,
                        add: true,
                        edit: false,
                        delete: false,
                        start: false,
                        end: false
                    }
                ]
            }
        ]
    }
    const userNotAdmin = {
        name: 'User',
        permission: [
            {
                name: 'Common',
                allAccess: false,
                menu: [
                    {
                        name: 'Dashboard',
                        view: false,
                    }, 
                    {
                        name: 'Item',
                        view: false,
                        add: false,
                        edit: false,
                        delete: false,
                    }, 
                    {
                        name: 'Scan Barcode',
                        view: false,
                        scan: false,
                    }, 
                    {
                        name: 'Task',
                        view: true,
                        add: true,
                        edit: false,
                        delete: false,
                        start: false,
                        end: false
                    }
                ]
            }
        ]
    }
    const userNotAdmin2 = {
        name: 'User2',
        permission: [
            {
                name: 'Common',
                allAccess: false,
                menu: [
                    {
                        name: 'Dashboard',
                        view: false,
                    }, 
                    {
                        name: 'Item',
                        view: false,
                        add: false,
                        edit: false,
                        delete: false,
                    }, 
                    {
                        name: 'Scan Barcode',
                        view: false,
                        scan: false,
                    }, 
                    {
                        name: 'Task',
                        view: true,
                        add: true,
                        edit: false,
                        delete: false,
                        start: false,
                        end: false
                    }
                ]
            }
        ]
    }
    const data = new User({
        name: 'Almira asy',
        username: 'almiraasy',
        email: 'almiraasy@gmail.com',
        role: 'User',
        password: 'Admin123!',
        roleRef: userNotAdmin2
    })

    await data.save()
    .then((d)=>{
        res.send({data: d, message: "User was registered successfully!" });
    })
    .catch((err)=>{
        res.status(500).send({ message: err });
        return;
    })
}

exports.editUser = async (req, res) => {
    const id = req.params.id
    const userAdmin = {
        name: 'Super Admin',
        permission: [
            {
                name: 'Common',
                allAccess: false,
                menu: [
                    {
                        name: 'Dashboard',
                        view: true,
                    }, 
                    {
                        name: 'Item',
                        view: true,
                        add: true,
                        edit: true,
                        delete: true,
                    }, 
                    {
                        name: 'Scan Barcode',
                        view: true,
                        scan: true,
                    }, 
                    {
                        name: 'Task',
                        view: true,
                        add: true,
                        edit: false,
                        delete: false,
                        start: false,
                        end: false
                    }, 
                    {
                        name: 'Dashboard Explore',
                        view: true,
                    }
                ]
            }
        ]
    }
    const dataEdit = {
        name: req.body.name,
        username: req.body.username,
        email: req.body.email,
        role: req.body.role,
        password: req.body.password,
        roleRef: userAdmin
    }

    await User.findByIdAndUpdate(id, dataEdit)
    .then((d)=>{
        res.status(200).send({data: d, message: "Data is successfully updated"})
    })
    .catch((e)=>{
        res.status(400).send({message: e.message})
    })
}

exports.userSignin = async (req, res) => {
    let dataSignin = {
        email: req.body.email,
        password: req.body.password
    }
    await User.findOne({email: dataSignin.email}).select('+password')
        .then((data) => {
            if(!data){
                return res.status(404).send({message: 'user not found'})
            }
            if(data.password !== dataSignin.password){
                return res.status(404).send({message: 'password salah'})
            }
            if(data.token != ''){
                return res.status(404).send({message: 'User already loged in'})
            }
            const token = jwt.sign({ data },'abcd',{expiresIn: 20 * 1000});
            data.token = token
            data.save().then(d=>{
                req.session.data = d;
                req.session.token = token;
                res.status(200).send(d)
            })
        })
}

exports.getUserActive = async (req, res) => {
    const token = req.params.token;
    await User.findOne({token: token}).then(data => {
        // console.log('data : ')
        // console.log(data)
        res.send(data)
    })
    .catch(e=>{
        res.send(e)
    })
}

exports.userLogout = async (req, res) => {
    const token = req.params.token;
    console.log(token)
    await User.findOneAndUpdate({token: token}, {token: ''})
    .then(() => {
        req.session = null
        return res.status(200).send({ message: "You've been signed out!" });
    })
    .catch((e)=>{
        return res.status(404).send({ message: e });
    })
}
