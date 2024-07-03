
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const app = express();
app.use(cors())
app.use(express.json());

const mainRoute = require('./routes/mainRoute');
const bodyParser = require('body-parser');

const db = require('./config/dbConfig');


const port = process.env.port || 6000 ;

app.use(bodyParser.urlencoded({extended:false}));
app.use(cors());
app.use(bodyParser.json());

app.use('/api',mainRoute);


app.listen(port,()=>{
    console.log('server is running on port= '+port);
});