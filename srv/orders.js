const cds = require("@sap/cds");
const { SELECT, INSERT, UPDATE } = require("@sap/cds/lib/ql/cds-ql");
const { Orders, Items, UnitOfMeasure } = cds.entities("mrm.proy.cap.salesorders");

// Operaciones JavaScript --> No son necesarias si la operación es general, es decir
// el handler genérico de CAP ya hace todo esto. Excepto si lógica adicional.

//Para composición de 1 a 1 ok
module.exports = class SrvManageOrders extends cds.ApplicationService {
    init() {
        //const { Orders } = this.entities;
        // Cuando exista una composición de 1:1
        this.before('XXXNEW', Items.drafts, async (req) => {
            req.data.detail ??= {
                Name: '',
                Description: null,
                ReleaseDate: null,
                DiscontinuedDate: null,
                Price: null,
                Height: null,
                Width: null,
                Depth: null,
                Quantity: null,
                UnitOfMeasure_ID: null
            };
            req.log(req.data);
            //console.log("Estoy creando un registro en la tabla borrador");
        });

        return super.init();
    }
};

module.exports = (srv) => {
    srv.on("READ", "Orders", async (req, next) => {
        // lógica previa si la necesitas (logs, validaciones, etc.)
        return next();
    });
    //*** READ todo
    //srv.on("READ", "GetOrdersAll", async (req) => {
    /* srv.on("READ", "Orders", async (req) => {
         return await SELECT.from(Orders);
     });*/
    //*** READ con parámetro
    //srv.on("READ", "GetOrders", async (req) => {
    /*srv.on("READ", "Orders", async (req) => {
        if (req.data.ID !== undefined) {
            return await SELECT.from`mrm.proy.cap.salesorders.Orders`
                .where`ID = ${req.data.ID}`;
        }
        return await SELECT.from(Orders);
    });*/

    //*** CREATE
    srv.on("CREATE", "Orders", async (req) => {
        let returnData = await cds
            .transaction(req)
            .run(
                INSERT.into(Orders).entries(req.data
                    /* {
                     ID: req.data.ID,
                     Email: req.data.Email,
                     FirstName: req.data.FirstName,
                     LastName: req.data.LastName,
                     Country: req.data.Country,
                     CreateOn: req.data.CreateOn,
                     DeliveryDate: req.data.DeliveryDate,
                     OrderStatus: req.data.OrderStatus,
                     ImageUrl: req.data.ImageUrl,
                 }*/
                )
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

    srv.on("UPDATE", "Orders", async (req) => {
        const { ID, ...data } = req.data; // separa la clave de los datos a modificar

        const affected = await UPDATE(Orders, ID).with(data);

        if (affected === 0) {
            return req.reject(404, `Order ${ID} not found`);
        }

        return SELECT.one
            .from(Orders, (o) => {
                o`*`, o.ToItems((i) => { i`*` });
            })
            .where({ ID });
    });

    //*** UPDATE */
    /*srv.on("UPDATE", "Orders", async (req) => {
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
    });*/

    //*** DELETE */
    srv.on("DELETE", "Orders", async (req) => {
        const { ID } = req.data;

        const affected = await DELETE.from(Orders).where({ ID });

        if (affected === 0) {
            return req.reject(404, `Order ${ID} not found`);
        }
        // no hace falta devolver nada: OData responde 204 No Content
    });

    //OK
    /*srv.on("DELETE", "Orders", async (req) => {
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
});*/

};