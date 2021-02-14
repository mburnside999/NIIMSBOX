public with sharing class ApplicationController {
  @AuraEnabled(cacheable=true)
  public static List<Application__c> getApplicationList() {
    return [
      SELECT
        Id,
        Name,
        Status__c,
        Practitioner_s_Name__c,
        Medicare_Provider_Number__c,
        Address__c,
        createddate
      FROM Application__c
      WITH SECURITY_ENFORCED
      ORDER BY createddate DESC
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<Application__c> findApplications(String searchKey) {
    String key = '%' + searchKey + '%';
    return [
      SELECT
        Id,
        Name,
        Status__c,
        Practitioner_s_Name__c,
        Medicare_Provider_Number__c
      FROM Application__c
      WHERE Name LIKE :key
      WITH SECURITY_ENFORCED
      LIMIT 10
    ];
  }

  @AuraEnabled(cacheable=true)
  public static Application__c getSingleApplication() {
    return [
      SELECT
        Id,
        Name,
        Status__c,
        Practitioner_s_Name__c,
        Medicare_Provider_Number__c
      FROM Application__c
      WITH SECURITY_ENFORCED
      LIMIT 1
    ];
  }
}
