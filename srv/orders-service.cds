using {mrm.proy.cap.salesorders as mrmcap} from '../db/schema';

service OrdersService {
 /* //OK
    entity OrdersSrv             as projection on mrmcap.Orders;
    entity ItemsSrv              as projection on mrmcap.Items;
    entity OrderStatus           as projection on mrmcap.Status;
    entity UnitOfMeasuresSrv     as projection on mrmcap.UnitOfMeasures;

    entity UnitOfMeasuresTextSrv as projection on mrmcap.UnitOfMeasures.texts; //?
*/


//exponemos las asociaciones
//entity UnitOfMeasure as projection on mrmcap.UnitOfMeasures;
//entity ToItems as projection on mrmcap.Items
}
