const mongoose = require('mongoose');
const { Schema,model } = mongoose;

const historySchema = Schema({
    storeid:{
        type:String,
        required:true
    },
    storename:{
        type:String,
        required:true
    },
    orderid:{
        type:String,
        required:true
    },
    userid:{
        type:String,
        required:true
    },
    totalprice:{
        type:String,
        required:true
    },
    items:{
        type:Array,
        required:true
    }
},{timestamps:true});
const historyModel = model('History',historySchema,'history');
module.exports = historyModel; 