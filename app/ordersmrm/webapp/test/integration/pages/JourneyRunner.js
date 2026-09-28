sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"mrm/sapfiori/ordersmrm/test/integration/pages/OrdersList.gen",
	"mrm/sapfiori/ordersmrm/test/integration/pages/OrdersObjectPage.gen",
	"mrm/sapfiori/ordersmrm/test/integration/pages/ItemsObjectPage.gen"
], function (JourneyRunner, OrdersListGenerated, OrdersObjectPageGenerated, ItemsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('mrm/sapfiori/ordersmrm') + '/test/flp.html#app-preview',
        pages: {
			onTheOrdersListGenerated: OrdersListGenerated,
			onTheOrdersObjectPageGenerated: OrdersObjectPageGenerated,
			onTheItemsObjectPageGenerated: ItemsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

