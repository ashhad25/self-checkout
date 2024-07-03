const express = require("express");
const router = express.Router();
const storeModel = require("../models/store");
const { body, validationResult } = require("express-validator");

const validation = [
  body("storename", "store name must be of 5 charachter or more.").isLength({
    min: 5,
  }),
];

//routes
//add store api
router.post("/addStore", validation, async (req, res) => {
  const { storename, latlng, getapi, postapi, addedby } = req.body;
  try {
    const validation = validationResult(req);
    console.log(validation);
    if (!validation.isEmpty()) {
      return res
        .status(400)
        .send({ msg: "validation error", error: validation.errors[0].msg });
    }
    let store = await storeModel.findOne({
      latlng: latlng,
    });
    // console.log(store);
    if (store) {
      console.log("store exists");
      return res
        .status(400)
        .send({ msg: "something already registered with these coordinates." });
    }

    store = await storeModel.create({
      storename,
      latlng,
      getapi,
      postapi,
      addedby,
    });
    //store.save()
    if (store) {
      return res.status(200).send({
        msg: "Store registered successfully.",
        storeid: store._id,
      });
    }
    return res.status(400).send({ msg: "Invalid request" });
  } catch (e) {
    console.log(e.errors)
    return res.status(500).send({ msg: "Internal server error.", error: e });
  }
});
//get all stores api
router.get("/getStores", async (req, res) => {
  try {
    let stores = await storeModel.find({});
    if (stores) {
      return res.status(200).send(stores);
    }
    return res.status(400).send({ msg: "Stores not found." });
  } catch (e) {
    return res.status(500).send({ msg: "Internal server error.", error: e });
  }
});
//get specific store against id
router.get("/getStore/:id", async (req, res) => {});

module.exports = router;
