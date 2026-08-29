using mrm.proy.cap.salesorders as capjs from '../db/schema';

service ManageOrders {
    entity GetOrders as projection on capjs.Orders;
}
