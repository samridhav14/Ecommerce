// creating an api
const express = require('express');
const mongoose =require('mongoose');
require('dotenv').config();
// initialize it and save it in some variable
const port = 3000;
const app = express();
const DB=process.env.DB;
// import from other files
const appRouter = require('./routes/auth');


// use the imported file
// this parses the incoming data to json
app.use(express.json());
app.use(appRouter);

// if we dont specify anything with port it will run on localhost:3000
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
mongoose.connect(DB).then(() => {
    console.log('Database connected');
}).catch((err) => {
    console.log(err);
});
// create read update delete - CRUD
// req will contain what the user is sending to the server
// res will contain what the server is sending back to the user
app.get('/', (req, res) => {
    res.json({'name':'Samridha'});
});