using mrm.proy.cap.salesorders as capjs from '../db/schema';

service ManageOrders {
    //    entity GetOrders as projection on capjs.Orders;
    entity Orders            as projection on capjs.Orders;
    entity Items             as projection on capjs.Items;

    @readonly
    entity OrderStatus       as projection on capjs.Status;
     
    @readonly
    entity VH_UnitOfMeasures    as projection on capjs.UnitOfMeasures;
    
    /*entity VH_UnitOfMeasures as
        select from capjs.UnitOfMeasures {
            ID          as Code,
            Description as Description
        };*/
}
