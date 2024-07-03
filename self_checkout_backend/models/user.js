const mongoose = require('mongoose');
const { Schema,model } = mongoose;

const userSchema = Schema({
    username:{
        type:String,
        required:true
    },
    email:{
        type:String,
        required:true
    },
    password:{
        type:String,
        required:true
    },
},{timestamps:true});
const userModel = model('User',userSchema,'users');
module.exports = userModel; 