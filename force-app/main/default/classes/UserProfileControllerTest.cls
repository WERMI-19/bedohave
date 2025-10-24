//  BEDOHAVE DEV – Oct 2025
// api: 64.0
@IsTest
private class UserProfileControllerTest {
    @IsTest
    static void testProfile() {
        Test.startTest();
        String profileName = UserProfileController.getCurrentUserProfile();
        Test.stopTest();
        System.assertNotEquals(null, profileName, 'Le nom du profil ne doit pas être null');
    }
}
