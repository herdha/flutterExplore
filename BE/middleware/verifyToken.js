const jwt = require('jsonwebtoken');

exports.verifyToken = (req, res, next) => {
    let token = req.session.token;
    if(!token){
        return res.status(403).send({message: 'We need token to accesss'});
    }

    jwt.verify(token, 'abcd', (err, data) => {
        if(err){ 
            res.status(401).send({message: 'Token is expired'}); 
        }
        req.username = data.username;
        next();
    })
}