const jwt = require('jsonwebtoken');

const auth=async(req,res,next)=>{
    try{
     const token=req.header('x-auth-token');
     if(!token){
        return res.status(401).json({msg:"No auth token access denied"});
     }
        const verified =  jwt.verify(token,"passwordKey",(err,user));
        if(!verified){
            return res.status(401).json({msg:"Token verification failed ,authorization denied."});
        }
         // important
         req.user=verified.id;
         req.token=token;
         user();
    }catch(err){
        res.status(500).json({error:err.message});
    }
}
module.exports=auth;