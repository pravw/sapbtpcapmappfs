
const cds = require('@sap/cds');
const {employees} = cds.entities ("anubhav.db.master");



module.exports = (srv) => {

srv.on('pokymon',req =>  `Hello ${req.data.name}`);
 srv.on('READ', 'ReadEmployeeSrv',async(req)=>{
// to get 5 record and change the value of name middle
    const tx = await cds.tx(req);
    // var returndata = [];
    // var results = await tx.run(SELECT.from(employees).limit(5));
    // for (let i = 0; i < results.length; i++)
    // {
    // const element = results[i];
    // element.nameMiddle = 'hello'
    // returndata.push(element);
    // }
    // return returndata;


    // working with condition.

    var whereCondition = req.data;
    if(whereCondition.hasOwnProperty("ID")){

        return await tx.run(SELECT.from(employees).where(whereCondition))

    }else{
        return await tx.run(SELECT.from(employees).limit(2).where({

            "sex":'F'
        }));



    }





})};