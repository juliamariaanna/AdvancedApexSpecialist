public class Constants {
	public static final integer DEFAULT_ROWS = 5;
    public static final string SELECT_ONE = system.label.select_one;
    public static final string INVENTORY_LEVEL_LOW = system.label.inventory_level_low;
    public static final List<schema.PicklistEntry> PRODUCT_FAMILY = 
        Product2.Family.getDescribe().getPicklistValues();
    public static final string DRAFT_ORDER_STATUS = 'Draft';
    public static final string ACTIVATED_ORDER_STATUS = 'Activated';
    public static final string INVENTORY_ANNOUNCEMENTS = 'Inventory Announcements';
    public static final string ERROR_MESSAGE = 'An error has occurred,' + 
        'please take a screenshot with the URL and send it to IT.';
    public static final id STANDARD_PRICEBOOK_ID = '01s0900000EJwAGAA1';
}