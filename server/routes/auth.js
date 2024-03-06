const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const appRouter = express.Router();
// we made this call back async because we are using await inside it
appRouter.post('/api/signup',async (req, res) => {
    try{
     // get data from client
    const {name,email,password}=req.body;
    // save data to database
     const existingUser=await User.findOne({email:email});
     if(existingUser){
         // we are sentding status 400 because the user already exists its a client error
         return res.status(400).json({message:"User already exists"});
     }
        // hash the password
        const hashedpassword = await bcrypt.hash(password, 12);
     let user = new User({
         name,
         email,
         password:hashedpassword
     });
     user = await user.save();
    // send response to client
    // we are sending status 200 because the request was successful
     res.json({user});
    }catch(err){
        return res.status(500).json({error:"Something went wrong"});
    }
   
});

module.exports = appRouter;