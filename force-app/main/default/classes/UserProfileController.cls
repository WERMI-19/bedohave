// api: 64.0
public with sharing class UserProfileController {
    @AuraEnabled(cacheable=true)
    public static String getCurrentUserProfile() {
        return [SELECT Profile.Name FROM User WHERE Id = :UserInfo.getUserId()].Profile.Name;
    }
}
