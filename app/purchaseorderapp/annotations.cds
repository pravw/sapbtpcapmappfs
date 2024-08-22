using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(

   UI.SelectionFields      : [
      PO_ID,
      PARTNER_GUID.COMPANY_NAME,
      PARTNER_GUID.ADDRESS_GUID.COUNTRY,
      GROSS_AMOUNT
   ],
   //line item
   UI.LineItem             : [
      {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.COMPANY_NAME,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
      },
      {
         $Type: 'UI.DataField',
         Value: GROSS_AMOUNT,
      },
      {
         $Type : 'UI.DataFieldForAction',
         Action: 'CatalogService.boost',
         Label : 'boost',
         Inline: true,
      },

      {
         $Type      : 'UI.DataField',
         Value      : OVERALL_STATUS,
         Criticality: colorCoding,
      },

   ],
   //annotation header and navigation to object page
   UI.HeaderInfo           : {
      TypeName      : 'Purchase Order',
      TypeNamePlural: 'Purchase Orders',
      // ndetails of navigation page   below is object page heading
      Title         : {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      Description   : {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.COMPANY_NAME,
      },
   },

   //definig the columns in object page
   UI.Facets               : [
      {
         $Type : 'UI.CollectionFacet',
         Label : 'More Info',
         Facets: [
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Additional data',
               Target: '@UI.Identification',
            },
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Pricing data',
               Target: '@UI.FieldGroup#Spiderman',
            },
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Statues',
               Target: '@UI.FieldGroup#Superman',
            },

         ],

      },

      {
         $Type : 'UI.ReferenceFacet',
         Target: 'Items/@UI.LineItem',
      },

   ],

   // first column
   UI.Identification       : [
      {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID_NODE_KEY,
      },


   ],

   //second column
   UI.FieldGroup #Spiderman: {
      Label: 'Price Data',
      Data : [
         {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
         },
         {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
         },
         {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
         },
      ],
   },
   // third column
   UI.FieldGroup #Superman : {
      Label: 'Status',
      Data : [
         {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
         },

         {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
         },

         {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
         },


      ],


   }


);


//navigation to object page to another object page.
annotate service.POItems with @(
   UI.LineItem               : [
      {
         $Type: 'UI.DataField',
         Value: PO_ITEM_POS,
      },
      {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID_NODE_KEY,
      },
      {
         $Type: 'UI.DataField',
         Value: GROSS_AMOUNT,
      },
      {
         $Type: 'UI.DataField',
         Value: 'CURRENCY_code',
      },
   ],
   UI.HeaderInfo             : {
      TypeName      : 'Items',
      TypeNamePlural: 'Items',
      // ndetails of navigation page   below is object page heading
      Title         : {
         $Type: 'UI.DataField',
         Value: PO_ITEM_POS,
      },
      Description   : {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID.DESCRIPTION,
      },
   },
   UI.Facets                 : [{
      $Type : 'UI.CollectionFacet',
      Label : 'Item Info',
      Facets: [
         {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#ItemDetails',
         },
         {
            $Type : 'UI.ReferenceFacet',
            Label : 'Price',
            Target: '@UI.FieldGroup#Pricing',
         },
         {
            $Type : 'UI.ReferenceFacet',
            Label : 'Product DEtails',
            Target: '@UI.FieldGroup#Product',
         },

      ],
   }, ],

   UI.FieldGroup #ItemDetails: {

   Data: [
      {
         $Type: 'UI.DataField',
         Value: PO_ITEM_POS,
      },
      {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID_NODE_KEY,
      },
      {
         $Type: 'UI.DataField',
         Value: CURRENCY_code,
      },
   ], },
   UI.FieldGroup #Pricing    : {

   Data: [
      {
         $Type: 'UI.DataField',
         Value: GROSS_AMOUNT,
      },
      {
         $Type: 'UI.DataField',
         Value: NET_AMOUNT,
      },
      {
         $Type: 'UI.DataField',
         Value: TAX_AMOUNT,
      },
   ], },
   UI.FieldGroup #Product    : {

   Data: [
      {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID.DESCRIPTION,
      },
      {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID.CATEGORY,
      },
      {
         $Type: 'UI.DataField',
         Value: PRODUCT_GUID.PRICE,
      },
   ], },

);

//linking the help with po
annotate service.POs with{
PARTNER_GUID@(
Common.Text: PARTNER_GUID.COMPANY_NAME,
Common.ValueList.entity: service.BusinessPartnerSet
);

} ;

//linking the help with po
annotate service.POItems with{
PRODUCT_GUID@(
Common.Text: PRODUCT_GUID.DESCRIPTION,
Common.ValueList.entity:service.ProductSet
);

} ;










// creation of drop down list for a feild in table
@cds.odata.valuelist 
annotate service.BusinessPartnerSet with @(
   UI.Identification: [
      {
   $Type: 'UI.DataField'   , 
   Value: COMPANY_NAME,

}

]

);

// creation of drop down list for a feild in table
@cds.odata.valuelist
annotate service.ProductSet with @(
   UI.Identification: [
      {
   $Type: 'UI.DataField' ,
   Value: DESCRIPTION,

}

]

);
