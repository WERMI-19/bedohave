import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

// Apex
import getOpportunityLineItems   from '@salesforce/apex/OpportunityLineItemController.getOpportunityLineItems';
import deleteOpportunityLineItem from '@salesforce/apex/OpportunityLineItemController.deleteOpportunityLineItem';
import getCurrentUserProfile     from '@salesforce/apex/UserProfileController.getCurrentUserProfile';

export default class BdhOpportunityProducts extends NavigationMixin(LightningElement) {
    @api recordId;

    lineItems = [];
    columns = [];
    userProfile = '';
    wiredResult;

    // Libellés en dur (pas de Custom Labels)
    text = {
        titleCard: 'Produits Opportunité',
        msgNoItems: 'Aucun produit pour cette opportunité',
        msgStockError: 'Stock insuffisant détecté sur un ou plusieurs produits.',
        colProduct: 'Nom Produit',
        colQty: 'Quantité',
        colUnitPrice: 'Prix Unitaire',
        colTotalPrice: 'Prix Total',
        colQtyStock: 'Quantité en Stock',
        btnDelete: 'Supprimer',
        btnView: 'Voir Produit',
        toastInitError: 'Échec de l\'initialisation du profil',
        toastLoadError: 'Erreur de chargement des produits',
        toastUnknownError: 'Erreur inconnue',
        toastDeleted: 'Ligne supprimée',
        toastError: 'Erreur',
        toastSuccess: 'Succès'
    };

    connectedCallback() {
        this.initProfileAndColumns();
    }

    async initProfileAndColumns() {
        try {
            this.userProfile = await getCurrentUserProfile();
            this.columns = this.buildColumns();
        } catch (e) {
            this.columns = this.buildColumns();
            this.showToast(this.text.toastError, this.text.toastInitError, 'error');
            // eslint-disable-next-line no-console
            console.error(e);
        }
    }

    @wire(getOpportunityLineItems, { opportunityId: '$recordId' })
    wiredLineItems(result) {
        this.wiredResult = result;
        const { data, error } = result;
        if (data) {
            this.lineItems = data.map(item => {
                // Comme aucun champ de stock n'existe, on force 0.
                const qtyStock = 0;
                return {
                    id:              item.Id,
                    productName:     item.Product2?.Name,
                    productId:       item.Product2?.Id,
                    quantity:        item.Quantity,
                    unitPrice:       item.UnitPrice,
                    totalPrice:      (item.Quantity || 0) * (item.UnitPrice || 0),
                    quantityInStock: qtyStock,
                    stockCellStyle:  (qtyStock - (item.Quantity || 0)) < 0
                        ? 'background-image: repeating-linear-gradient(45deg,#f8eaea,#f8eaea 10px,#f0d9d9 10px,#f0d9d9 20px); color: #8B0000; font-weight: 700;'
                        : 'color: #0b6b3a; font-weight: 700;'
                };
            });
        } else if (error) {
            this.lineItems = [];
            this.showToast(this.text.toastError, error?.body?.message || this.text.toastLoadError, 'error');
            // eslint-disable-next-line no-console
            console.error(error);
        }
    }

    buildColumns() {
        const cols = [
            { label: this.text.colProduct,    fieldName: 'productName',     type: 'text' },
            { label: this.text.colQty,        fieldName: 'quantity',        type: 'number',
              cellAttributes: { style: { fieldName: 'stockCellStyle' } } },
            { label: this.text.colUnitPrice,  fieldName: 'unitPrice',       type: 'currency' },
            { label: this.text.colTotalPrice, fieldName: 'totalPrice',      type: 'currency' },
            { label: this.text.colQtyStock,   fieldName: 'quantityInStock', type: 'number' },
            {
                type: 'button-icon',
                fixedWidth: 60,
                typeAttributes: {
                    iconName: 'utility:delete',
                    name: 'delete',
                    title: this.text.btnDelete,
                    alternativeText: this.text.btnDelete,
                    variant: 'border-filled'
                }
            }
        ];
        if ((this.userProfile || '').toLowerCase() === 'system administrator') {
            cols.push({
                type: 'button',
                label: this.text.btnView,
                typeAttributes: {
                    label:    this.text.btnView,
                    name:     'view',
                    iconName: 'utility:preview',
                    variant:  'brand'
                }
            });
        }
        return cols;
    }

    get hasLineItems() {
        return Array.isArray(this.lineItems) && this.lineItems.length > 0;
    }

    get hasStockError() {
        return this.lineItems.some(i => (i.quantityInStock - (i.quantity || 0)) < 0);
    }

    handleRowAction(event) {
        const action = event.detail.action?.name;
        const row    = event.detail.row;
        if (action === 'delete') this.handleDelete(row);
        if (action === 'view')   this.handleViewProduct(row);
    }

    async handleDelete(row) {
        try {
            await deleteOpportunityLineItem({ lineItemId: row.id });
            this.showToast(this.text.toastSuccess, this.text.toastDeleted, 'success');
            await refreshApex(this.wiredResult);
        } catch (e) {
            this.showToast(this.text.toastError, e?.body?.message || this.text.toastUnknownError, 'error');
            // eslint-disable-next-line no-console
            console.error(e);
        }
    }

    handleViewProduct(row) {
        if ((this.userProfile || '').toLowerCase() === 'system administrator') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId:     row.productId,
                    objectApiName:'Product2',
                    actionName:   'view'
                }
            });
        }
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
