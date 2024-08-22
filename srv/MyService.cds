
// using {anubhav.cds } from '../db/CDSViews';

using {anubhav.db.master} from '../db/data-model';

service MyService @(path:'MyService') {

    function pokymon (name:String (20)) returns String;
    entity ReadEmployeeSrv as projection on master.employees;
}
