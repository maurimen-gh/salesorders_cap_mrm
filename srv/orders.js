const cds = require("@sap/cds");
const { SELECT, INSERT } = require("@sap/cds/lib/ql/cds-ql");
const { Orders } = cds.entities("mrm.proy.cap.salesorders");

module.exports = (srv) => {
    //*** READ todo
    srv.on("READ", "GetOrdersAll", async (req) => {
        return await SELECT.from(Orders);
    });

    //*** READ con parámetro
    srv.on("READ", "GetOrders", async (req) => {
        if (req.data.ID !== undefined) {
            return await SELECT.from`mrm.proy.cap.salesorders.Orders`
                .where`ID = ${req.data.ID}`;
        }

        return await SELECT.from(Orders);
    });

    //*** CREATE
    srv.on("CREATE", "CreateOrder", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                INSERT.into(Orders).entries({
                    ID: req.data.ID,
                    Email: req.data.Email,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    Country: req.data.Country,
                    CreateOn: req.data.CreateOn,
                    DeliveryDate: req.data.DeliveryDate,
                    OrderStatus: req.data.OrderStatus,
                    ImageUrl: req.data.ImageUrl,
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve", resolve);
                console.log("Reject", reject);

                if (typeof resolve !== "undefined") {
                    return req.data;
                } else {
                    req.error(409, "Record Not Inserted");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        return returnData;
    });
};