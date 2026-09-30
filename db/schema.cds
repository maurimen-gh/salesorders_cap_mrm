namespace mrm.proy.cap.salesorders;

using {
    cuid,
    managed,
    sap.common.CodeList,
    sap.common.Countries
} from '@sap/cds/common';
//using { cuid, managed } from '@sap/cds/common'; //OK managed

//entity Orders : cuid {
entity Orders : cuid, managed {
    //  key ID           : UUID       @mandatory; // Se comenta porque manejamos aspecto CUID
    Email        : String(30)          @mandatory;
    FirstName    : String(30) not null @mandatory;
    LastName     : String;
    Country      : Association to Countries default 'BO';
    CreateOn     : Date default $now;
    DeliveryDate : DateTime;
    OrderStatus  : Association to Status; // OrderStatus_Code
    ImageUrl     : String;
    ToItems      : Composition of many Items // composición
                       on ToItems.Order = $self
/*ToItems      : Association to many Items
                   on ToItems.Order = $self; // uno a muchos (asociación)*/
}

// define entity Items : cuid, managed { //OK managed
define entity Items : cuid {
    //    key ID               : UUID                @mandatory;
    Name             : String(40) not null @mandatory;
    Description      : String(40);
    ReleaseDate      : Date;
    DiscontinuedDate : Date;
    Price            : Decimal(12, 2);
    Height           : Decimal(15, 3);
    Width            : Decimal(13, 3);
    Depth            : Decimal(12, 2);
    Quantity         : Decimal(16, 2);
    UnitOfMeasure    : Association to UnitOfMeasures;
    Order            : Association to Orders;
}

//entity UnitOfMeasures : cuid {
entity UnitOfMeasures {
    key ID          : String(2);
        Description : localized String;
}

define entity Status : CodeList {
    key Code        : String(20) enum {
            Open = 'Open in process';
            Completed = 'Completed and Billed';
            Rejected = 'Rejected';
        };
        Criticality : Int16;
}

/*
// EJEMPLOS
// Ejemplo entidad select (los campos de join corregir)
entity SelOrders  as
    select from Orders
    inner join Items
        on Orders.Country = Items.Name
    {
        Orders.FirstName,
        Email
    }

// Ejemplo entidad de proyección
entity ProjOrders as
    projection on Orders {
        *
    };

// Ejemplo extensión de campos
extend Orders with {
    Status        : String(1);
    Observaciones : String(100);
}
*/
