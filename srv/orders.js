const cds = require("@sap/cds");
const { SELECT, INSERT, UPDATE } = require("@sap/cds/lib/ql/cds-ql");
const { Orders } = cds.entities("mrm.proy.cap.salesorders");

module.exports = (srv) => {
    //*** READ todo
    //srv.on("READ", "GetOrdersAll", async (req) => {
    srv.on("READ", "Orders", async (req) => {
        return await SELECT.from(Orders);
    });

    //*** READ con parámetro
    //srv.on("READ", "GetOrders", async (req) => {
    srv.on("READ", "Orders", async (req) => {
        if (req.data.ID !== undefined) {
            return await SELECT.from`mrm.proy.cap.salesorders.Orders`
                .where`ID = ${req.data.ID}`;
        }

        return await SELECT.from(Orders);
    });

    //*** CREATE
    srv.on("CREATE", "Orders", async (req) => {
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
        console.log("Before end", returnData);
        return returnData;
    });

    //*** UPDATE */
    srv.on("UPDATE", "Orders", async (req) => {
        let returnData = await cds.transaction(req).run(
            [
                UPDATE(Orders, req.data.ID).set({
                    Email: req.data.Email,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    Country: req.data.Country,
                    DeliveryDate: req.data.DeliveryDate,
                    OrderStatus: req.data.OrderStatus
                })
            ])
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);

                if (resolve[0] == 0) {
                    req.error(409, "Record not found.");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        console.log("Before End", returnData);
        return returnData;
    });

    //*** DELETE */
    srv.on("DELETE", "Orders", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                DELETE.from(Orders).where({
                    ID: req.data.ID,
                })
            )
            .then((resolve, reject) => {
                console.log("Resolve: ", resolve);
                console.log("Reject: ", reject);

                if (resolve !== 1) {
                    req.error(409, "Record not found.");
                }
            })
            .catch((err) => {
                console.log(err);
                req.error(err.code, err.message);
            });
        console.log("Before End", returnData);
        return await returnData;
    });
};