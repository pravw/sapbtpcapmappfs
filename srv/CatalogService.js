module.exports = cds.service.impl(async function () {

  const { POs, EmployeeSet } = this.entities;




  this.before(['CREATE', 'PATCH'], EmployeeSet, (req) => {

    if (parseFloat(req.data.salaryAmount) >= 1000000) {

      req.error(500, "Hi We cannot support salary over a million");
    }

  });

  this.on('boost', async (req) => {
    console.log('yes');
    try {
      const ID = req.params[0]
      //start a db transation
      const tx = cds.tx(req);
      // cds query language-communicate to db
      await tx.update(POs).with({
        GROSS_AMOUNT: { '+=': 20000 }
      }).where(ID);
    } catch (error) {

      return "error" + error.string();
    }

  });


  this.on('largestOrder', async (req) => {
    console.log('yes');
    try {
      //start a db transation
      const tx = cds.tx(req);
      // to read the highest value gross amount
      const recordData = tx.read(POs).orderBy({
        GROSS_AMOUNT: 'desc'
      }).limit(1);
      return recordData;
    } catch (error) {

      return "Error" + error.tostring();
    }

  });




  this.on('getOrderStatus', async(req,res) => {

    return{


      "OVERALL_STATUS": "N"
    };
  });
  
  
  
  
  
  
  
  




});

