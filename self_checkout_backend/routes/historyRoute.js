const express = require("express");
const router = express.Router();
const historyModel = require('../models/history')

// router.use(express.json());
//route to add history
router.post('/addHistory',async (req,res)=>{
    console.log(req.body);
    const {storeid,storename,orderid,userid,items,totalprice} = req.body;
    try {
        let history =await  historyModel.create({
            storeid,storename,orderid,userid,items,totalprice
        });
        if (history) {
            return res.status(200).send({
              msg: "History added successfully.",
              historyid: history._id,
              history
            });
        }
        return res.status(400).send({ msg: "Invalid request" });
    } catch (e) {
        console.log(e.errors)
        return res.status(500).send({ msg: "Internal server error.", error: e });
    }

});

// route to get history of specific user
router.get('/getHistory/:userid',async (req,res)=>{
    // return res.status(200).send({"msg":"api working","params":req.params.userid});
    const userid = req.params.userid;
    // console.log(userid);
    try {
        let history =await  historyModel.find({userid})
        if (history) {
            return res.status(200).send({
              userid,history
            });
        }
        return res.status(400).send({ msg: "Invalid request" });
    } catch (e) {
        console.log(e.errors)
        return res.status(500).send({ msg: "Internal server error.", error: e });
    }

});

// route to get all the history
router.get('/getAllHistory',async (req,res)=>{
    // return res.status(200).send({"msg":"api working","params":req.params.userid});
    // const userid = req.params.userid;
    // console.log(userid);
    try {
        let history =await  historyModel.find()
        if (history) {
            return res.status(200).send(
              history
            );
        }
        return res.status(400).send({ msg: "Invalid request" });
    } catch (e) {
        console.log(e.errors)
        return res.status(500).send({ msg: "Internal server error.", error: e });
    }

});

module.exports = router;