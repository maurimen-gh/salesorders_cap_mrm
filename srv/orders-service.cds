using {mrm.proy.cap.salesorders as mrmcap} from '../db/schema';

service OrdersService {
    entity OrdersSrv as projection on mrmcap.Orders;
    entity ItemsSrv  as projection on mrmcap.Items;
}
