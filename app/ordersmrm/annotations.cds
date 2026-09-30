using ManageOrders as service from '../../srv/orders';

annotate service.Orders with @odata.draft.enabled;

annotate service.Orders with {
    ImageUrl    @title: '{i18n>ImageUrl}';
    Email       @title: '{i18n>Email}'; //'E-mail';
    FirstName   @title: '{i18n>FirstName}';
    LastName    @title: '{i18n>LastName}';
    Country     @title: '{i18n>Country}';
    CreateOn    @title: '{i18n>CreateOn}';
    OrderStatus @title: '{i18n>OrderStatus}';
}

annotate service.Orders with {
    ImageUrl @(UI.IsImageURL: true)
};

annotate service.Orders with @(
    /* // Ocultar botón Delete
       Capabilities                 : {DeleteRestrictions: {
            $Type    : 'Capabilities.DeleteRestrictionsType',
            Deletable: false
        }, },*/

    UI.SelectionFields           : [
        FirstName,
        LastName,
        Country_code,
        OrderStatus_Code
    ],

    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : '{i18n>Order}',
        TypeNamePlural: '{i18n>Orders}',
        ImageUrl      : ImageUrl,
        Title         : {
            $Type: 'UI.DataField',
            Value: FirstName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: LastName
        }
    },

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            //   Label: 'ImageUrl',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Value: Email,
        },
        {
            $Type: 'UI.DataField',
            Value: FirstName,
        },
        {
            $Type: 'UI.DataField',
            Value: LastName,
        },
     /*   {
            $Type: 'UI.DataField',
            Value: Country_code,
        },*/
        {
            $Type             : 'UI.DataField',
            Value             : Country.name, // OrderStatus_Code,
           // Label             : 'Country',
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        },
        {
            $Type: 'UI.DataField',
            Value: CreateOn,
        },
        {
            $Type             : 'UI.DataField',
            Value             : OrderStatus.name, // OrderStatus_Code,
           // Label             : 'Status',
            Criticality       : OrderStatus.Criticality,
            @HTML5.CssDefaults: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        }
    ],

    UI.FieldGroup #Picture       : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: ImageUrl,
            Label: '',
        }],
    },
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                // Label: '{i18n>Email}',  <PEND> Probar en title
                //Label: 'Email',
                Value: Email,
            },
            {
                $Type: 'UI.DataField',
                // Label: 'FirstName',
                Value: FirstName,
            },
            {
                $Type: 'UI.DataField',
                //Label: 'LastName',
                Value: LastName,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Country}',
                //'Country',
                Value: Country_code,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>CreateOn}',
                //'CreateOn',
                Value: CreateOn,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DeliveryDate}',
                //'DeliveryDate',
                Value: DeliveryDate,
            },
            {
                $Type      : 'UI.DataField',
                Value      : OrderStatus_Code, //OrderStatus.name,
                Criticality: OrderStatus.Criticality,
                Label      : '{i18n>OrderStatus}',
            //Label      : 'Order Status',
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ImageUrl}',
                Value: ImageUrl,
            },
        ],
    },

    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Sales Order',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Items',
            Target: 'ToItems/@UI.LineItem#Items',
        },
    ],
    UI.HeaderFacets              : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#Picture',
    }, ],
/*UI.HeaderFacets:[{
    $Type   : 'UI.ReferenceFacet',
    Target  : '',
}],*/
);

annotate service.Items with {
    Name             @title: 'Name';
    Description      @title: 'Description'      @UI.MultiLineText;
    ReleaseDate      @title: 'Release Date';
    DiscontinuedDate @title: 'Discontinued Date';
    Price            @title: 'Price'; // @Measures.ISOCurrency
    Height           @title: 'Height'           @Measures.Unit: UnitOfMeasure_ID;
    Width            @title: 'Width'            @Measures.Unit: UnitOfMeasure_ID;
    Depth            @title: 'Depth'            @Measures.Unit: UnitOfMeasure_ID;
    Quantity         @title: 'Quantity';
    UnitOfMeasure    @title: 'Unit Of Measure'  @Common.IsUnit;
};

annotate service.Items with @(
    UI.HeaderInfo                  : {
        TypeName      : '{i18n>Item}',
        TypeNamePlural: '{i18n>Items}',
        Title         : {
            $Type: 'UI.DataField',
            Value: Order.FirstName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: Order.LastName
        }
    },

    UI.LineItem #Items             : [
        {
            $Type: 'UI.DataField',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Value: Description,
        },
        {
            $Type: 'UI.DataField',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Value: DiscontinuedDate,
        },
        {
            $Type: 'UI.DataField',
            Value: Price,
        },
        {
            $Type: 'UI.DataField',
            Value: Height,
        },
        {
            $Type: 'UI.DataField',
            Value: Width,
        },
        {
            $Type: 'UI.DataField',
            Value: Depth,
        },
        {
            $Type: 'UI.DataField',
            Value: Quantity,
        },
        {
            $Type: 'UI.DataField',
            Value: UnitOfMeasure_ID,
        },
    ],

    UI.FieldGroup #ItemsInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Name,
            },
            {
                $Type: 'UI.DataField',
                Value: Description,
            },
            {
                $Type: 'UI.DataField',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Value: UnitOfMeasure_ID,
            },
        ]
    },

    UI.Facets                      : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#ItemsInformation',
        Label : 'Items detail'
    }],
);

annotate service.Items with {
    UnitOfMeasure @(Common: {
        Text                    : UnitOfMeasure.Description,
        TextArrangement         : #TextOnly,
        ValueListWithFixedValues: false,
        // true = dropdown en lugar de diálogo
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_UnitOfMeasures',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: UnitOfMeasure_ID,
                    ValueListProperty: 'ID'
                },
                /*{
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: UnitOfMeasure_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'UM'
                },*/
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Description'
                }
            ]
        }
    });
};

annotate service.VH_UnitOfMeasures with {
    ID          @title: 'UM';
    Description @title: 'Description';
};

annotate service.VH_UnitOfMeasures with {
    ID @(
        UI.Hidden             : true,
        Common.Text           : Description,
        Common.TextArrangement: #TextOnly
    );
};

/*
// Para ver solo texto en el value help
annotate service.VH_UnitOfMeasures with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly,
        }}
    );
    Text @(UI: {HiddenFilter: true});
};
*/
