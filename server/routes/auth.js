const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');
const appRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth=require('../middleware/auth');
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
        console.log(err);
        return res.status(500).json({error:"Something went wrong"});
    }
});
 // Sign in route
 appRouter.post('/api/signin',async (req, res) => {
    try{
        // get data from client
        const {email,password}=req.body;
        // save data to database
        const existingUser=await
        User.findOne({email:email});
        if(!existingUser){
            // we are sentding status 400 because the user already exists its a client error
            return res.status(400).json({message:"User does not exist"});
        }
        // compare the password
        const isMatch = await bcrypt.compare(password,existingUser.password);
        if(!isMatch){
            return res.status(400).json({message:"Invalid credentials"});
        }
        // send response to client
        // we are sending status 200 because the request was successful
       const token = jwt.sign({id:existingUser._id},"passwordKey");
       // ... is a spread operator
        res.json({token,...existingUser._doc});
    }catch(err){
        // console.log(err);
        return res.status(500).json({error:"Something went wrong"});
    }
});
appRouter.get('/api/tokenIsValid',async (req, res) => {
    try{
        const token = req.header("x-auth-token");
        // if there is no token then we return false to the client 
        if(!token){
            return res.json(false);
        }
      const verified =  jwt.verify(token,"passwordKey",(err,user));
        if(!verified){
            return res.status(500).json({error:"Token verification failed"});
        }
         const user = await User.findById(verified.id);
            if(!user){
                return res.status(500).json({error:"User not found"});
            }
            return res.json(true);
    }catch(err){
        console.log(err);
        return res.status(500).json({error:"Something went wrong"});
    }
});
// get user data
appRouter.get('/',auth,async(req,res)=>{
  const user=await User.findById(req.user);
  res.json({..._doc,token : req.token})
})

module.exports = appRouter;