const mongoose = require('mongoose');

mongoose.connect(process.env.DB_CONNECTION_STRING);

mongoose.connection.on("connected",()=>{
    console.log("app is connected with db");
});

mongoose.connection.on("error",(err)=>{
    console.log("error occur to connection with db "+{err});
});