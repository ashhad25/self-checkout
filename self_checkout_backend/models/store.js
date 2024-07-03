const mongoose = require('mongoose');
const { Schema,model } = mongoose;

const storeSchema = Schema({
    storename:{
        type:String,
        required:true
    },
    latlng:{
        type:String,
        required:true
    },
    getapi:{
        type:String,
        required:true
    },
    postapi:{
        type:String,
        required:true
    },
    addedby:{
        type:String,
        required:true
    }
},{timestamps:true});
const storeModel = model('Store',storeSchema,'stores');
module.exports = storeModel; 

