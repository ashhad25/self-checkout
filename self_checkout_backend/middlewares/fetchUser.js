const jwt = require('jsonwebtoken');

const fetchUser = async (req,res,next)=>{
    try{
        const token = req.header('auth-token');
        if(!token){
            res.staus(401).send({"msg":"Authentication failed."});
        }
        const data = jwt.verify(token,process.env.EN_KEY);
        req.uid = data.uid;
        next();
    }catch(e){
        res.staus(401).send({"msg":"Authentication failed.","error":e});
    }
};

module.exports = fetchUser;