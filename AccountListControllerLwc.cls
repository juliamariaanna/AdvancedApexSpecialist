public with sharing class AccountListControllerLwc {
    @AuraEnabled(cacheable=true)
    public static List<Account> queryAccounts(Integer numberOfEmployees) {
        return [ // Return whatever the component needs
            SELECT Name
            FROM Account
            WHERE NumberOfEmployees >= :numberOfEmployees
        ];
    }
    @AuraEnabled(cacheable=true)
    public static list<account> queryAccountsByRevenue(decimal annualRevenue){
        return [SELECT Id, AnnualRevenue 
                FROM Account 
                where AnnualRevenue >= :annualRevenue];
    }
}