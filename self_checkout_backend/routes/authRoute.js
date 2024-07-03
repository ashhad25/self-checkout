const express = require('express');
const router = express.Router();
const {body,validationResult} = require('express-validator');
const userModel = require('../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const fetchUserMW = require('../middlewares/fetchUser')

router.use(express.json());

//validation
const registerValidation = [
    body('username','username must be of 3 charachter or more.').isLength({min:3}),
    body('email','invalid email.').isEmail(),
    body('password','password must be of 8 charachter or more.').isLength({min:8})
];

const loginValidation = [
    body('email','invalid email.').isEmail(),
    body('password','password must be of 8 charachter or more.').isLength({min:8})
];
//auth routes
//register user api
router.post('/register',registerValidation,async (req,res)=>{

    const {username,email,password} = req.body;
    try{
        const validation = validationResult(req);
        if(!validation.isEmpty()){
            return res.status(400).send({"msg":"validation error","error":validation.errors[0].msg})
        }
        
        let user = await userModel.findOne({
            'email':email
        });

        if(user){
            return res.status(400).send({msg:"User already registered on this email."});
        }

        const salt = await bcrypt.genSalt(10);
        const hash_pass = await bcrypt.hash(password,salt);
        user = await userModel.create({username,email,"password":hash_pass});
        if(user){
            const uid = user._id;
            let token = jwt.sign({uid},process.env.EN_KEY);
            return res.status(200).send({msg:"User successfully registered.",token});
        }

        return res.status(400).send({'msg':'Invalid request'});
    }catch(e){
        return res.status(500).send({msg:"Internal server error.",error:e});
    }
});
//login user api
router.post('/login',loginValidation,async (req,res)=>{
    console.log(req.body);
    const {email,password} = req.body;
    try{
        const validation = validationResult(req);
        if(!validation.isEmpty()){
            return res.status(400).send({"msg":"validation error","error":validation.errors[0].msg});
        }

        let user = await userModel.findOne({
            "email":email
        });

        if(!user){
            return res.status(400).send({msg:"User not registered on this email."});
        }
        const hash_pass = await bcrypt.compare(password,user.password);
        if(hash_pass){
            const uid = user._id;
            let token = jwt.sign({uid},process.env.EN_KEY);
            return res.status(200).send({msg:"User loggedin successfully.",token});
        }

        return res.status(400).send({'msg':'Invalid request'});
    }catch(e){
        return res.status(500).send({msg:"Internal server error.",error:e});
    }
});
//get user api
router.get('/getUser',fetchUserMW,async(req,res)=>{
    try{
        const {uid} = req;
        const user = await userModel.findById(uid).select('-password');
        if(!user){
            return res.status(400).send({"msg":"Authentication failed."});
        }
        return res.status(200).send(user);
    }catch(e){
        return res.status(500).send({"msg":"Internal server error."});
    }
});

module.exports = router;