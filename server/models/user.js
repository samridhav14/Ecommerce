const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    name:{
        type:String,
        required:true,
        min:6,
        max:255,
        trim:true,
    },
    email:{
        type:String,
        required:true,
        max:255,
        min:6,
        trim:true,
        validate:{
            validator: (value)=>{
                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message:'Please enter a valid email address',
        }
    },
    password:{
        type:String,
        required:true,
        min:6,
        validator:{
            validator: (value)=>{
                const re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,14}$/;
                return value.match(re);
            }
        } 
    },
    address:{
        type:String,
        default:"",
        max:1024,
        min:6
    },
    type:{
        type:String,
        default:"user",
    },
    // cart
});

const User=mongoose.model('User',userSchema);
module.exports=User;