namespace mrm.proy.cap.salesorders;

entity Orders {
    key id           : String;
    key email        : String;
        firstName    : String;
        lastName     : String;
        country      : String;
        createOn     : Date;
        deliveryDate : DateTime;
        orderStatus  : Integer;
        imageUrl     : String;
}

entity Items {
    key id               : String;
        name             : String;
        description      : String;
        releaseDate      : Date;
        discontinuedDate : Date;
        price            : Decimal;
        height           : Decimal;
        width            : Decimal;
        depth            : Decimal;
        quantity         : Decimal;
        unitOfMeasure    : Decimal;
}
