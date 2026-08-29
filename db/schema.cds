namespace mrm.proy.cap.salesorders;

using { cuid, managed } from '@sap/cds/common';

//entity Orders : cuid, managed {
entity Orders : cuid {
    key ID           : UUID @mandatory;
        Email        : String(30) @mandatory;
        FirstName    : String(30) not null;
        LastName     : String;
        Country      : String(30);
        CreateOn     : Date default $now;
        DeliveryDate : DateTime;
        OrderStatus  : Integer;
        ImageUrl     : String;
        ToItems         : Composition of many Items
                           on ToItems.Order = $self
        /*ToItems      : Association to many Items
                           on ToItems.Order = $self;  // uno a muchos*/
}

define entity Items : cuid, managed {
    key ID               : UUID @mandatory;
        Name             : String(40);
        Description      : String(40) not null @mandatory;
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

@readonly
entity UnitOfMeasures {
    key ID          : String(2);
        Description : localized String;
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
