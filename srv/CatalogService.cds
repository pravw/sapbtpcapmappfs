using { anubhav.db.master, anubhav.db.transaction } from '../db/data-model';

service CatalogService @(path:'CatalogService',requires: 'authenticated-user') {

    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity EmployeeSet@(restrict: [
    { grant: 'READ',to: 'Viewer', where:'bankName = $user.BankName' },
     { grant: 'WRITE',to: 'Admin',  }
  ]) as projection on master.employees;
    entity ProductSet as projection on master.product;
    function getOrderStatus() returns POs;
    entity POs @(
        odata.draft.enabled: true,
        Common.DefaultValuesFunction: 'getOrderStatus')as projection on transaction.purchaseorder{
  *,
  case OVERALL_STATUS
     when 'N'then 'New'
     when 'P'then 'Pending'
     when 'X'then 'Rejected'
     when 'A'then 'Approved'
     when 'D'then 'Delivered' end as OVERALL_STATUS:String(10),
     case  OVERALL_STATUS
when 'N'then 0
when 'P'then 3
when 'X'then 1
when 'A'then 3
when 'D'then 3 end as colorCoding: Integer,Items
     }
    actions{
        @cds.odata.bindingparameter.name:'_varibe'
        @Common.SideEffects:{
            TargetProperties:['_varibe/GROSS_AMOUNT']
        }
        action boost() returns POs ;
        function largestOrder() returns POs;


    };
    entity POItems as projection on transaction.poitems;

}
