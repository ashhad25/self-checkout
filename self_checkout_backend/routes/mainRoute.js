const express = require('express');
const router = express.Router();
//auth route
router.use('/authRoute',require('./authRoute'));
//store route
router.use('/storeRoute',require('./storeRoute'));
//data history route
router.use('/historyRoute',require('./historyRoute'));
module.exports = router;
